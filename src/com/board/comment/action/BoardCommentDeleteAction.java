package com.board.comment.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.board.comment.db.boardCommentDAO;

public class BoardCommentDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("M : boardCommentDeleteAction_execute() 호출");
		
		// 전달된 댓글번호, 게시글번호, 페이지번호 저장
		int cmt_num = Integer.parseInt(request.getParameter("cmt_num"));
		String pageNum = request.getParameter("pageNum");
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
		boardCommentDAO bcDAO = new boardCommentDAO();
		bcDAO.boardCommentDelete(cmt_num);
		
		// 페이지이동
		ActionForward forward = new ActionForward();
		forward.setPath("./board_content.bo?board_num="+board_num + "&pageNum="+pageNum);
		forward.setRedirect(true);
			
		return forward;
	}

}
