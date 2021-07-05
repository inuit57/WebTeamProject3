package com.chat.action;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chat.db.chatDAO;

public class ChatAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = new ActionForward();
		
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		
		String user_nick = (String)session.getAttribute("user_nick");
		
		String seller = request.getParameter("seller");
		
		int prod_num = Integer.parseInt(request.getParameter("prod_num"));
		
		chatDAO cdao = new chatDAO();
		
		String roomId = null;
		
		if(user_nick.equals(seller)) {
			
			session.setAttribute("seller", seller);
			
			forward.setPath("./chatlist.ch");
			forward.setRedirect(true);	
			
		} else {
			roomId = cdao.getRoomId(prod_num, seller, user_nick);
			
			if(roomId == null) {
				cdao.createRoomId(prod_num, seller, user_nick);
				
				roomId = cdao.getRoomId(prod_num, seller, user_nick);	
			}
			
			
			session.setAttribute("roomId", roomId);
			
			forward.setPath("./chat.ch");
			forward.setRedirect(true);
		}
		
		System.out.println("방 넘버:"+roomId);
		
		return forward;
	}

}
