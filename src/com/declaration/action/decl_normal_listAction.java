package com.declaration.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.board.db.boardDAO;
import com.board.db.boardDTO;
import com.declaration.db.declarationDAO;
import com.declaration.db.declarationDTO;

public class decl_normal_listAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("M : decl_normal_listAction_execute() 호출");
		
		int state = Integer.parseInt(request.getParameter("state"));
		
		declarationDAO dcDAO = new declarationDAO();
		
		// 신고게시판 게시글 개수 
		int decl_normal_listcnt = dcDAO.decl_normal_listCount();
		
		// 한페이지당 보여줄 글의 개수
		int pageSize = 10;
		
		// 현페이지가 몇페이지 인지 확인
		String pageNum = request.getParameter("pageNum");
		
		if(pageNum == null){
			pageNum = "1";
		}
		
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		
		int endRow = currentPage * pageSize;
		
		// 신고게시판에 있는 글의 목록을 신고가 많은 순으로 정렬해서 한번씩 보여주는 함수
		
		List decl_normal_list = new ArrayList();
		
		if( state == 0 ){
		
			decl_normal_list = dcDAO.getDecl_normal_list(startRow, pageSize);
		
		} else {
			
			decl_normal_list = dcDAO.getDecl_normal_list(state, startRow, pageSize);
			decl_normal_listcnt = dcDAO.decl_normal_listCount(state);
		
		}
		
		request.setAttribute("decl_normal_list", decl_normal_list);
		request.setAttribute("decl_normal_listcnt", decl_normal_listcnt);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("currentPage", currentPage);
		
		// 페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./declaration/decl_normal_list.jsp");
		forward.setRedirect(false);
			
		return forward;
	}

}
