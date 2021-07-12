package com.chat.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chat.db.chatDAO;
import com.chat.db.chatDTO;
import com.tradeLog.db.TradeLogDAO;
import com.user.db.UserDAO;

public class ChatDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		
		String roomId = request.getParameter("roomId");
		
		chatDAO cdao = new chatDAO();
		TradeLogDAO tlDAO = new TradeLogDAO(); 
		
		
		chatDTO chDTO = cdao.getChatInfo(roomId); 
		
		int prod_num = chDTO.getProd_num();  // 상품 번호 얻어오기 
		String buyerName = chDTO.getChat_buyer(); 
		String sellerName = chDTO.getChat_seller();

		// 환불 처리 돌리기 
		tlDAO.buyCancleLog(buyerName, sellerName, prod_num);
		
		try {
			System.out.println(roomId);
			cdao.deleteRoomId(roomId);
		} catch (Exception e) {
			System.out.println(e.toString());
			System.out.println("ChatDeleteAction");
		}
		
		System.out.println("채팅방 삭제 완료");
		
		return null;
	}

}
