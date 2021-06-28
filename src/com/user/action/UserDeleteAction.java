package com.user.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.user.db.UserDAO;

public class UserDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		String nickname = (String)session.getAttribute("user_nick");
		
		UserDAO udao = new UserDAO();
		String id = udao.getId(nickname); 
		udao.userDelete(id);
		
		session.invalidate();
		
		ActionForward forward = new ActionForward();
		forward.setPath("./index.us");
		forward.setRedirect(true);
		
		return forward;
	}

}
