package com.declaration.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.board.db.boardDAO;
import com.declaration.db.declarationDAO;

public class decl_normal_boardDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("BoardDeleteAction_execute() 호출");
		
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
		boardDAO bDAO = new boardDAO();
		bDAO.deleteBoard(board_num);
		
		declarationDAO dcDAO = new declarationDAO();
		// 해당글삭제하기 를 하면 일반게시판 DB에서 삭제하고 신고목록 DB에서도 지우기
		dcDAO.decl_normal_delete(board_num);
		
		// 페이지이동
		ActionForward forward = new ActionForward();
		forward.setPath("decl_normal_list.decl");
		forward.setRedirect(true);
		
		return forward;
	}

}
