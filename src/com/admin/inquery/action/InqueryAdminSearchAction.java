package com.admin.inquery.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.inquery.db.AdminInqueryDAO;

public class InqueryAdminSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("M : InqueryAdminSearchAction_execute() 실행");
		
		request.setCharacterEncoding("utf-8");
		
		String sk = request.getParameter("sk");
		String sv = request.getParameter("sv");
		
		AdminInqueryDAO aiDAO = new AdminInqueryDAO();
		
		aiDAO.inquerySearchList(sk,sv);
		
		request.setAttribute("aiList",aiDAO.inquerySearchList(sk,sv) );
		
		ActionForward forward = new ActionForward();
		
		forward.setPath("./admin_inquery/admin_inquery_search.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
