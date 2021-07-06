package com.user.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.user.db.UserDAO;

public class UserPwUpdate implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");		
		
		String user_pw = request.getParameter("user_pw");
		String user_phone = request.getParameter("user_phone");
		String user_id = request.getParameter("user_id");
		
		UserDAO udao = new UserDAO();
		udao.updatePW(user_pw, user_phone , user_id);
		
		
		ActionForward forward = new ActionForward();
		forward.setPath("./UserLogin.us");
		forward.setRedirect(true);
		return forward;
	}

}
