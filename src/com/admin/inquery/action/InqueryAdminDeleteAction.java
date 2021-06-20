package com.admin.inquery.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.inquery.db.AdminInqueryDAO;

public class InqueryAdminDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("M : InqueryAdminDeleteAction_execute() 호출");
		
		int num = Integer.parseInt(request.getParameter("num"));
		
		AdminInqueryDAO aiDAO = new AdminInqueryDAO();
		
		aiDAO.adminDelete(num);
		
		ActionForward forward = new ActionForward();
		
		forward.setPath("./InqueryAdminList.ai");
		forward.setRedirect(true);
		
		
		return forward;
	}

}
