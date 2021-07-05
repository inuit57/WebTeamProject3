package com.admin.user.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.user.db.AdminUserDAO;

public class AdminUserActivateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		
		String user_nick = request.getParameter("user_nick");
		
		System.out.println(user_nick);

		
		AdminUserDAO auDAO = new AdminUserDAO();
		
		auDAO.activateUser(user_nick);
		
//		ActionForward forward = new ActionForward();
		
//		forward.setPath("/AdminUserList.au");
//		forward.setRedirect(true);
		
				
		return null;
	}

}
