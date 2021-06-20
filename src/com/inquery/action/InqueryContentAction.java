package com.inquery.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.inquery.db.InqueryDAO;
import com.inquery.db.InqueryDTO;

public class InqueryContentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("M : InqueryContentAction_execute() 호출");
		
		int num = Integer.parseInt(request.getParameter("num"));
		
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+num);
		
		InqueryDAO inDAO = new InqueryDAO();
		
		
		
		inDAO.getInqueryContent(num);
		
		request.setAttribute("inDTO", inDAO.getInqueryContent(num));
		
		ActionForward forward = new ActionForward();
		
		forward.setPath("./inquery/inquery_content.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
