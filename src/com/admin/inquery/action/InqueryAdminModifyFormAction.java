package com.admin.inquery.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.inquery.db.AdminInqueryDAO;

public class InqueryAdminModifyFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
				
		System.out.println("M : InqueryAdminModifyFormAction_execute() 호출");
		
		int num = Integer.parseInt(request.getParameter("num"));
		
		AdminInqueryDAO aiDAO = new AdminInqueryDAO();
		
		aiDAO.getInqueryContent(num);
		
		request.setAttribute("inDTO", aiDAO.getInqueryContent(num));
		
		ActionForward forward = new ActionForward();
		
		forward.setPath("./admin/admin_inquery/admin_inquery_modify_form.jsp");
		forward.setRedirect(false);
		
		
		return forward;
	}

}
