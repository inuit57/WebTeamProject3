package com.admin.user.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.user.db.AdminUserDAO;



public class AdminUserGradeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			System.out.println("AdminUserLevelAction_execute() ");
		
			request.setCharacterEncoding("utf-8");
			
			int user_grade = Integer.parseInt(request.getParameter("user_grade"));
			String user_nick = request.getParameter("user_nick");
				
			System.out.println(user_grade+user_nick);
			
			AdminUserDAO auDAO = new AdminUserDAO();
			
			auDAO.changeUserGrade(user_grade,user_nick);
				
		
		
		
		return null;
	}

}
