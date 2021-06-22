package com.user.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.user.db.UserDAO;

public class UserLoginAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		session.setAttribute("id", null);
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		UserDAO udao = new UserDAO();
		
		boolean b = udao.Login(id,pw);
		
		ActionForward forward = new ActionForward();
		
		if(b == true) {
			session.setAttribute("id", id);
			forward.setPath("./index.us");
			forward.setRedirect(true);
		} else {
			forward.setPath("./UserLogin.us?error=1");
			forward.setRedirect(true);
		}
		

		return forward;
	}

}
