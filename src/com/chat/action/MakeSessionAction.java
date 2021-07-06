package com.chat.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MakeSessionAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String roomId = request.getParameter("val");
		
		HttpSession session = request.getSession();
		
		session.setAttribute("roomId", roomId);
		session.setAttribute("chatRole", "seller");
		
		return null;
	}

}
