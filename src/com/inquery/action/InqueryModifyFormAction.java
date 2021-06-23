package com.inquery.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.inquery.db.InqueryDAO;

public class InqueryModifyFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
				System.out.println("M : InqueryModifyFormAction_execute 호출");
		
				int num = Integer.parseInt(request.getParameter("num"));
				
				InqueryDAO inDAO = new InqueryDAO();
				
				inDAO.getInqueryContent(num);
				
				request.setAttribute("inDTO", inDAO.getInqueryContent(num));
				
				ActionForward forward = new ActionForward();
				
				forward.setPath("./inquery/inquery_modify_form.jsp");
				forward.setRedirect(false);
				
		
		return forward;
	}

}
