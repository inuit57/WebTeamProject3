package com.user.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.msg.db.MsgDAO;
import com.user.db.UserDAO;

public class UserLoginAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		

		request.setCharacterEncoding("UTF-8");
		
		
		HttpSession session = request.getSession();

    // 병한 형님 작업
		//session.setAttribute("id", null);
		//session.setAttribute("nick", null);
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String loginType = request.getParameter("loginType");
		
		UserDAO udao = new UserDAO();
		MsgDAO mdao = new MsgDAO();
	
    // 병한 형님 작업
//		boolean b = udao.Login(id,pw);
//		String user_nick = udao.getUserNick(id);
    
		String user_nick = "";
		
		if(loginType.equals("normal")){
			user_nick = udao.Login(id,pw);
		}else{
			user_nick = udao.checkEmail(id);
		}
		
		ActionForward forward = new ActionForward();
		
// 		if(b == true) {
// 			session.setAttribute("id", id);
// 			session.setAttribute("nick", user_nick);
// 			forward.setPath("./index.us");
		if(user_nick != null) {
			session.setAttribute("user_nick", user_nick);
			session.setAttribute("user_profile", udao.getProfile(user_nick));
			session.setAttribute("msgAlarm", mdao.getRecvChk(user_nick));
			forward.setPath("./Main.do");
			forward.setRedirect(true);
		} else {
			forward.setPath("./UserLogin.us?error=1");
			forward.setRedirect(true);
		}
		

		return forward;
	}

}
