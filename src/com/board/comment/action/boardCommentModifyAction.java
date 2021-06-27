package com.board.comment.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.board.comment.db.boardCommentDAO;
import com.board.comment.db.boardCommentDTO;

public class boardCommentModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("M : boardCommentModifyAction_execute() 호출");
		
		// 한글처리
		request.setCharacterEncoding("UTF-8");
		
		// 댓글번호, 게시글번호, 페이지번호 저장
		int cmt_num = Integer.parseInt(request.getParameter("cmt_num"));
		String pageNum = request.getParameter("pageNum");
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
		boardCommentDTO	bcDTO = new boardCommentDTO();
		
		bcDTO.setCmt_content(request.getParameter("cmt_content_modify"));
		bcDTO.setCmt_num(Integer.parseInt(request.getParameter("cmt_num")));
		
		boardCommentDAO bcDAO = new boardCommentDAO();
		bcDAO.BoardCommentModify(bcDTO);
		
		// 페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./board_content.bo?board_num="+board_num + "&pageNum="+pageNum);
		forward.setRedirect(true);
		
		return forward;
	}

}
