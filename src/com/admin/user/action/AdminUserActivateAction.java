package com.admin.user.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.user.db.AdminUserDAO;

public class AdminUserActivateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		
		String user_nickname = request.getParameter("user_nickname");
		
		System.out.println(user_nickname);

		
		AdminUserDAO auDAO = new AdminUserDAO();
		
		auDAO.activateUser(user_nickname);
		
//		ActionForward forward = new ActionForward();
		
//		forward.setPath("/AdminUserList.au");
//		forward.setRedirect(true);
		
				
		return null;
	}

}
