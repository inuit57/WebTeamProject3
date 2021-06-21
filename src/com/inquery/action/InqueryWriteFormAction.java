package com.inquery.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class InqueryWriteFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
		ActionForward forward = new ActionForward();
		forward.setPath("./inquery/inquery_write_form.jsp");
		forward.setRedirect(false);	
		
		return forward;
	}

}
