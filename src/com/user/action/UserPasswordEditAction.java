package com.user.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.user.db.UserDAO;

public class UserPasswordEditAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		String nickname = (String)session.getAttribute("user_nick");
		
		String pw = request.getParameter("pw");
		String new_pw = request.getParameter("new_pw");
		String new_pw_check = request.getParameter("new_pw_check");
		
		UserDAO udao = new UserDAO();
		
		String id = udao.getId(nickname);  
		String nick_chk = udao.Login(id, pw); 
		
		ActionForward forward = new ActionForward();
		
		if(nick_chk != null) {
			if(new_pw.equals(new_pw_check)) {
				udao.changePassword(id,new_pw);
				
				session.invalidate(); 
				//forward.setPath("./Main.do");
				forward.setPath("./UserInfo.us?onClose=1");
				forward.setRedirect(true);
			} else {
				forward.setPath("./UserInfo.us?m=2");
				forward.setRedirect(true);
			}
		} else {
			forward.setPath("./UserInfo.us?m=3");
			forward.setRedirect(true);
		}
		
		return forward;
	}

}
