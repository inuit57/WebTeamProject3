package com.board.action;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.board.db.boardDAO;

public class BoardSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("M : BoardSearchAction.bo_execute() 호출");
		
		request.setCharacterEncoding("UTF-8");
		
		String sk = request.getParameter("sk");
		String[] sv = request.getParameter("sv").split(" ");
		
		boardDAO bDAO = new boardDAO();
		ArrayList boList = (ArrayList) bDAO.boardSearch(sk,sv);
		int cnt = bDAO.getBoardCount(sk, sv);
		
		// 한페이지당 보여줄 글의 개수
		int pageSize = 5;
		
		// 현페이지가 몇페이지 인지 확인
		String pageNum = request.getParameter("pageNum");
		
		if(pageNum == null){
			pageNum = "1";
		}	
		
		// 페이지별 시작행 계산하기
	    // 1p -> 1번, 2p -> 11번, 3p -> 21번, ... => 일반화
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		
		// 끝행 계산하기
	    // 1p -> 10번, 2p -> 20번,... => 일반화
		int endRow = currentPage * pageSize;
		
		request.setAttribute("boList", boList);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("cnt", cnt);
		request.setAttribute("sk", sk);
	    request.setAttribute("sv", sv);

		
		// 페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./board/board_search_List.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
