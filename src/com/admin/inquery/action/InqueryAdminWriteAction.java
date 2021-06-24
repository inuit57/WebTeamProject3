package com.admin.inquery.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.inquery.db.AdminInqueryDAO;
import com.inquery.db.InqueryDTO;


public class InqueryAdminWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			System.out.println("M : InqueryAdminWriteAction_execute() 호출");
		
		// 관리자 제어
			
			request.setCharacterEncoding("utf-8");

			
			
			InqueryDTO inDTO = new InqueryDTO();
			
			inDTO.setInq_num(Integer.parseInt(request.getParameter("num")));
			inDTO.setUser_nick(request.getParameter("name"));
			inDTO.setInq_sub(request.getParameter("subject"));
			inDTO.setInq_content(request.getParameter("content"));

			
			
			AdminInqueryDAO aiDAO = new AdminInqueryDAO();
			
			aiDAO.adminReWrite(inDTO);
			
			aiDAO.adminCheckUpdate(inDTO);
			
			ActionForward forward = new ActionForward();
			
			forward.setPath("./InqueryAdminList.ai");
			forward.setRedirect(true);
		
		
		
		return forward;
	}

}
