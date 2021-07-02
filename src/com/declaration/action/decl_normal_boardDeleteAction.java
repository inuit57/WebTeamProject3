package com.declaration.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.board.comment.db.boardCommentDAO;
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
		//	- 신고게시판에서는 지우지 않는걸로 변경
		
		// dcDAO.decl_normal_delete(board_num);
		
		// 게시글 삭제되면 댓글도 같이 삭제되게 처리
		boardCommentDAO bcDAO = new boardCommentDAO();
		bcDAO.delete_cmt_to_board(board_num);
		
		// 관리자가 신고된 글 삭제시 처리상태를 1(처리중)에서 2(처리완료)로 변경
		dcDAO.decl_state_update(board_num);
		
		// 페이지이동
		ActionForward forward = new ActionForward();
		forward.setPath("decl_normal_list.decl");
		forward.setRedirect(true);
		
		return forward;
	}

}
