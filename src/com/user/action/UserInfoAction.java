package com.user.action;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.user.db.UserDAO;
import com.user.db.UserDTO;

public class UserInfoAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		String id = (String)session.getAttribute("id");
		
		UserDAO udao = new UserDAO();
		
		UserDTO udto = udao.getUserInfo(id);
		
		session.setAttribute("udto", udto);
		
		ActionForward forward = new ActionForward();
		forward.setPath("./UserInfo.us");
		forward.setRedirect(true);
		
		return forward;
	}

}
