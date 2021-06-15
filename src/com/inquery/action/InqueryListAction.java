package com.inquery.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.inquery.action.ActionForward;

public class InqueryListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			System.out.println("M : InqueryListAction_execute() 호출");
		
			
			
			
			
			
		ActionForward forward = new ActionForward();
		forward.setPath("./inquery/inquery_list.jsp");
		forward.setRedirect(false);	

		
		return forward;
	}

}
