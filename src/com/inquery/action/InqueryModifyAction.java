package com.inquery.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.inquery.db.InqueryDAO;
import com.inquery.db.InqueryDTO;


public class InqueryModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
				System.out.println("M : InqueryModifyAction_execute() 실행");
		
				request.setCharacterEncoding("utf-8");
				
			
				System.out.println("M : 파일업로드 완료");
				
				InqueryDTO inDTO = new InqueryDTO();
				
				inDTO.setInq_num(Integer.parseInt(request.getParameter("num")));
				inDTO.setUser_nick(request.getParameter("name"));
				inDTO.setInq_sub(request.getParameter("subject"));
				inDTO.setInq_content(request.getParameter("content"));
				
				InqueryDAO inDAO = new InqueryDAO();
				
				inDAO.myModify(inDTO);
				
				ActionForward forward = new ActionForward();
				
				forward.setPath("./InqueryList.in");
				forward.setRedirect(true);
				
		
		return forward;
	}

}
