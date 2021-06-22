package com.board.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.board.db.boardDAO;

public class BoardListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("M : board_List.bo_execute()호출");
		
		boardDAO bDAO = new boardDAO();
		
		
		// 한페이지당 보여줄 글의 개수
		int pageSize = 5;
		
		// 현페이지가 몇페이지 인지 확인
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null){
			pageNum = "1";
		}	
		
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		
		int endRow = currentPage * pageSize;
		
		List boardList = bDAO.getBoardList(startRow, pageSize);
		
		request.setAttribute("boardList", boardList);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("currentPage", currentPage);
		
		// 페이지이동
		ActionForward forward = new ActionForward();
		forward.setPath("./board/board_List.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
