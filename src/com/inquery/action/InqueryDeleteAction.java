package com.inquery.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.inquery.db.InqueryDAO;

public class InqueryDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("M : InqueryDeleteAction_execute() 호출");
		
		int num = Integer.parseInt(request.getParameter("num"));
		
		InqueryDAO inDAO = new InqueryDAO();
		
		inDAO.myDelete(num);
		
		ActionForward forward = new ActionForward();
		
		forward.setPath("./InqueryList.in");
		forward.setRedirect(true);
		
		return forward;
	}

}
