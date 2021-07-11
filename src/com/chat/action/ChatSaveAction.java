package com.chat.action;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chat.db.chatDAO;
import com.chat.db.chatDTO;
import com.msg.db.MsgDAO;
import com.prod.db.ProdDAO;
import com.tradeLog.db.TradeLogDAO;
import com.user.db.UserDAO;
import com.wish.db.WishDAO;

public class ChatSaveAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		
		String roomId = request.getParameter("roomId");
		String chatRole = request.getParameter("chatRole");
		String msg = request.getParameter("msg");
		
		HttpSession session = request.getSession(); 
		String user_nick = (String) session.getAttribute("user_nick"); 
		
		int prod_num = 0 ; 
		int prod_price = 0 ; 
		String buyerName = ""; 
		String sellerName = "" ; 
		
		ProdDAO pDAO = new ProdDAO(); 
		WishDAO wDAO = new WishDAO(); 
		MsgDAO msgDAO = new MsgDAO(); 
		chatDAO chDAO = new chatDAO(); 
		UserDAO uDAO = new UserDAO(); 
		TradeLogDAO tlDAO = new TradeLogDAO(); 
		
		
		chatDTO chDTO = chDAO.getChatInfo(roomId); 
		
		prod_num = chDTO.getProd_num();  // 상품 번호 얻어오기 
		prod_price = pDAO.getProduct(prod_num).getProd_price(); // 상품 가격 얻어오기 
		buyerName = chDTO.getChat_buyer(); 
		sellerName = chDTO.getChat_seller(); 
		
		boolean flag = true; //거래 처리 관련 flag. 
		
		// 거래 단계별 처리 
		if( "sell01".equals(msg)){ // 거래 요청
			// DO NOTHING - DB에서 처리할 사항은 여기에서 없다. 
		}else if( "buy01".equals(msg)){  // 거래 승인
			// 여기에서 코인이 DB에 걸리게 된다. 
			// member DB에서 코인 차감하기 -> 만약 코인이 적다면??? 
			if( tlDAO.wantBuyLog(buyerName, sellerName, prod_num) != 0 ) { 
				flag = false ; 
			}
			// 버튼이 아예 누르지 않은 것처럼 처리가 필요하다. 
			
			
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
				//uDAO.updateCoin(sellerName, prod_price , true); //코인 증가시켜주기 
				// trade_log DB에 기록 넣어주기 
				tlDAO.buyConfirmLog(buyerName, sellerName, prod_num);
				
			// 구매 확정 처리하기 끝. 
				
			//--------------------------------------------------------------------------
				
			// 거래가 걸려있는 다른 사람이 있을 때 처리 시작
				
				// tlDAO 한번 돌아주기 
				
			// 그러한 대상이 있는지 확인하기 
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
