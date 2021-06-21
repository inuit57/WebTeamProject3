package com.board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.board.db.boardDAO;
import com.board.db.boardDTO;

public class BoardContentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("BoardContentAction_execute() 호출");
		
		// 전달된 정보저장
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		String pageNum = request.getParameter("pageNum");
		
		boardDAO bDAO = new boardDAO();
		bDAO.updateReadcount(board_num);
		
		boardDTO bDTO = bDAO.getContent(board_num);
		
		request.setAttribute("bDTO", bDTO);
		
		// 페이지 이동
		ActionForward forward = new ActionForward();
		
		forward.setPath("./board/board_content.jsp");
		forward.setRedirect(false);
			
		return forward;
	}

}
