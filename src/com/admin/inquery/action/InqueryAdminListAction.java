package com.admin.inquery.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.inquery.db.AdminInqueryDAO;

public class InqueryAdminListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			System.out.println("M : InqueryAdminListAction_execute() 호출");
		
		
		ActionForward forward = new ActionForward();
		
		AdminInqueryDAO aiDAO = new AdminInqueryDAO();
		
		String check = request.getParameter("check");
		
		System.out.println("@@@@@@@@@@@@@@@check : "+check);
		
		
		List aiList = new ArrayList();
		
		if(check == null){
		
		aiList = aiDAO.getAdminInqueryList();
		
		}else{
			
		aiList = aiDAO.getAdminInqueryList(check);
			
		}
		
		
		request.setAttribute("aiList", aiList);
		
		
		// "./admin_inquery/admin_inquery_list.jsp"
		forward.setPath("./admin_inquery/admin_inquery_list.jsp");
		forward.setRedirect(false);
	
		return forward;
	}

}
