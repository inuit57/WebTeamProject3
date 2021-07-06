package com.declaration.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.declaration.db.declarationDAO;

public class decl_prod_listAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("M : decl_prod_listAction_execute() 호출");
		
		int state = Integer.parseInt(request.getParameter("state"));
		
		declarationDAO dcDAO = new declarationDAO();
		
		// 신고게시판 게시글 개수
		int decl_prod_listcnt = dcDAO.decl_prod_listCount();
		
		// // 한페이지당 보여줄 글의 개수
		int pageSize = 10;
		
		// 현페이지가 몇페이지 인지 확인
		String pageNum = request.getParameter("pageNum");
		
		if(pageNum == null){
			pageNum = "1";
		}
		
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		
		int endRow = currentPage * pageSize;
		
		List decl_prod_list = new ArrayList();
		
		if(state == 0) {
		
			decl_prod_list = dcDAO.getDecl_prod_list(startRow, pageSize);
		
		} else {
			
			decl_prod_list = dcDAO.getDecl_prod_list(state, startRow, pageSize);
			decl_prod_listcnt = dcDAO.decl_prod_listCount(state);
		}
		
		request.setAttribute("decl_prod_list", decl_prod_list);
		request.setAttribute("decl_prod_listcnt", decl_prod_listcnt);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("currentPage", currentPage);
		
		ActionForward forward = new ActionForward();
		forward.setPath("./declaration/decl_prod_list.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
