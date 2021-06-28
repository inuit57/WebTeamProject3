package com.user.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.user.db.UserDAO;

public class UserLoginAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		

		request.setCharacterEncoding("UTF-8");
		
		
		HttpSession session = request.getSession();
		
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String loginType = request.getParameter("loginType");
		
		UserDAO udao = new UserDAO();
		
		String user_nick = "";
		
		if(loginType.equals("normal")){
			user_nick = udao.Login(id,pw);
			
		}else{
			user_nick = udao.checkEmail(id);
		}
		
		
	
		ActionForward forward = new ActionForward();
		
		if(user_nick != null) {
			session.setAttribute("user_nick", user_nick);
			forward.setPath("./Main.do");
			forward.setRedirect(true);
		} else {
			forward.setPath("./UserLogin.us?error=1");
			forward.setRedirect(true);
		}
		

		return forward;
	}

}
