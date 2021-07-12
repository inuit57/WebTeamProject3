package com.inquery.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.inquery.action.ActionForward;
import com.inquery.db.InqueryDAO;

public class InqueryListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			System.out.println("M : InqueryListAction_execute() 호출");

		
		HttpSession session = request.getSession();
		String user_nick = (String) session.getAttribute("user_nick");
		
		System.out.println(user_nick);
		
		ActionForward forward = new ActionForward();
		
		
		
			
		InqueryDAO inDAO = new InqueryDAO();
		
		inDAO.getMyInqueryList(user_nick);
			
		request.setAttribute("myInqueryList", inDAO.getMyInqueryList(user_nick));
			
		forward.setPath("./inquery/inquery_list.jsp");
		forward.setRedirect(false);	

		
		return forward;
	}

}
