package com.inquery.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.inquery.db.InqueryDAO;
import com.inquery.db.InqueryDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class InqueryWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("M : InqueryWriteAction_execute() 호출");
				
		request.setCharacterEncoding("utf-8");
		
		// 파일업로드
		// upload 폴더생성
		// request.getRealPath("/upload"); <- 가능은하나 권장하지않음
		ServletContext ctx = request.getServletContext();
		String realpath = ctx.getRealPath("/inquery/upload");
		
		int maxSize = 5 * 1024 * 1024;
		
		MultipartRequest multi = new MultipartRequest(request, realpath, maxSize,"UTF-8",new DefaultFileRenamePolicy());
		
		System.out.println("M : 파일업로드 완료");
		
		InqueryDTO inDTO = new InqueryDTO();
		
		inDTO.setUser_nick(multi.getParameter("name"));
		inDTO.setInq_sub(multi.getParameter("subject"));
		inDTO.setInq_content(multi.getParameter("content"));
		inDTO.setInq_img(multi.getFilesystemName("img"));
		
		InqueryDAO inDAO = new InqueryDAO();
		
		inDAO.addInquery(inDTO);
		
		
		ActionForward forward = new ActionForward();
		
		
		forward.setPath("./InqueryList.in");
		forward.setRedirect(true);

		
		return forward;
	}

}
