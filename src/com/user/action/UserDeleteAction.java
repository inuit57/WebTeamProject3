package com.user.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.user.db.UserDAO;

public class UserDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		String id = (String)session.getAttribute("id");
		
		UserDAO udao = new UserDAO();
		
		udao.userDelete(id);
		
		session.invalidate();
		
		ActionForward forward = new ActionForward();
		forward.setPath("./index.us");
		forward.setRedirect(true);
		
		return forward;
	}

}
