package com.chat.action;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chat.db.chatDAO;
import com.msg.db.MsgDAO;
import com.prod.db.ProdDAO;
import com.wish.db.WishDAO;

public class ChatSaveAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		
		String roomId = request.getParameter("roomId");
		String chatRole = request.getParameter("chatRole");
		String msg = request.getParameter("msg");
		
		int prod_num = 0 ; 
		
		ProdDAO pDAO = new ProdDAO(); 
		WishDAO wDAO = new WishDAO(); 
		MsgDAO msgDAO = new MsgDAO(); 
		chatDAO chDAO = new chatDAO(); 
		
		prod_num = chDAO.getChatInfo(roomId).getProd_num(); 
		
		// 거래 단계별 처리 
		if( "sell01".equals(msg)){ // 거래 요청
			// DO NOTHING - DB에서 처리할 사항은 여기에서 없다. 
		}else if( "buy01".equals(msg)){  // 거래 승인
			// 여기에서 코인이 DB에 걸리게 된다. 
			// member DB에서 코인 차감하기 
			// trade_log DB에 기록 넣어주기 
			
		}else if( "sell02".equals(msg)){ // 거래 완료
			// DO NOTHING - DB에서 처리할 사항은 여기에서 없다.
		}else if( "buy02".equals(msg)){ // 구매확정 
			//******* 판매상품 떨구기 동작 시작 ----------------------------------
				pDAO.updateStatus(prod_num, 3);
				
				// 찜목록에 해당 상품 찜한 사람들 가져오기 
				List<String> memberList = wDAO.getWishMembers(prod_num); 
				String prod_sub = pDAO.getProduct(prod_num).getProd_sub(); 
				
				// 시스템 메시지 보내주기 
				msgDAO.msgWrite(memberList , prod_sub); 
				
				// 찜목록에서 해당 상품 삭제 
				wDAO.favoriteDelete(prod_num);
			//******* 판매상품 떨구기 동작 끝 ---------------------------------------
			
			// 구매 확정 처리하기 시작
				
				
			// 구매 확정 처리하기 끝. 
				
			//--------------------------------------------------------------------------
				
			// 거래가 걸려있는 다른 사람이 있을 때 처리 시작
				
			// 환불 처리 수행
				
			// 거래가 걸려있는 다른 사람이 있을 때 처리 끝.
				
		}else{ // 만약 중간에 나가는 동작을 할 경우  
			// 코인 환불 처리가 필요하다. 
		}
		
		String saveMsg = chatRole + "|" + msg + "/";
		
		ServletContext ctx = request.getServletContext();
		String realpath = ctx.getRealPath("/chatlog/");
		
		//System.out.println("chat log path :: " + realpath);
		try {
			// 텍스트 파일에 채팅 내용 작성해주기 
			BufferedWriter fw = new BufferedWriter(new FileWriter(realpath + roomId + ".txt",true));
//			BufferedWriter fw = new BufferedWriter(new FileWriter(realpath + roomId,true));
			
			fw.write(saveMsg);
			fw.flush();
			fw.close();
		} catch (Exception e) {
			System.out.println(e.toString());
			System.out.println("ChatSaveAction.java error - KBH");
		}
		
		
		return null;
	}

}
