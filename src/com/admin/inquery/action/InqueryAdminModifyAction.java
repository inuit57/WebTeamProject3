package com.admin.inquery.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.inquery.db.AdminInqueryDAO;
import com.inquery.db.InqueryDTO;


public class InqueryAdminModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
				
		System.out.println("M : InqueryAdminModifyAction_execute() 호출");
		
		request.setCharacterEncoding("utf-8");
		
		

		
		System.out.println("M : 파일업로드 완료");
		
		InqueryDTO inDTO = new InqueryDTO();
		
		inDTO.setInq_num(Integer.parseInt(request.getParameter("num")));
		inDTO.setUser_nickname(request.getParameter("name"));
		inDTO.setInq_sub(request.getParameter("subject"));
		inDTO.setInq_content(request.getParameter("content"));
		
		
		AdminInqueryDAO aiDAO = new AdminInqueryDAO();
		
		aiDAO.adminModify(inDTO);
		
		ActionForward forward = new ActionForward();
		
		forward.setPath("./InqueryAdminList.ai");
		forward.setRedirect(true);
		
				
		return forward;
	}

}
