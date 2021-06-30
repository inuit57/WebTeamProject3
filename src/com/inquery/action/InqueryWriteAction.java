package com.inquery.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.inquery.db.InqueryDAO;
import com.inquery.db.InqueryDTO;

public class InqueryWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("M : InqueryWriteAction_execute() 호출");
				
		request.setCharacterEncoding("utf-8");
		
		// 파일업로드
		// upload 폴더생성
		// request.getRealPath("/upload"); <- 가능은하나 권장하지않음
		
		
		InqueryDTO inDTO = new InqueryDTO();
		
		inDTO.setUser_nick(request.getParameter("name"));
		inDTO.setInq_sub(request.getParameter("subject"));
		inDTO.setInq_content(request.getParameter("content"));

		
		InqueryDAO inDAO = new InqueryDAO();
		
		inDAO.addInquery(inDTO);
		
		
		ActionForward forward = new ActionForward();
		
		
		forward.setPath("./InqueryList.in");
		forward.setRedirect(true);

		
		return forward;
	}

}
