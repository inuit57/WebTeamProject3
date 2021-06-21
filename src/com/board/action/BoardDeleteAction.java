package com.board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.board.db.boardDAO;

public class BoardDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("BoardDeleteAction_execute() 호출");
		
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
		boardDAO bDAO = new boardDAO();
		bDAO.deleteBoard(board_num);
		
		// 페이지이동
		ActionForward forward = new ActionForward();
		forward.setPath("./board_List.bo");
		forward.setRedirect(true);
		
		return forward;
	}

}
