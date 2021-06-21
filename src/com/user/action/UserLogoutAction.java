package com.user.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UserLogoutAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		session.invalidate();
		
		ActionForward forward = new ActionForward();
		forward.setPath("./index.us");
		forward.setRedirect(true);
		
		return forward;
	}

}
