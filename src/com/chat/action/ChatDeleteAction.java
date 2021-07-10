package com.chat.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chat.db.chatDAO;

public class ChatDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		
		String roomId = request.getParameter("roomId");
		
		chatDAO cdao = new chatDAO();
		
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
