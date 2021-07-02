package com.board.comment.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.board.comment.db.boardCommentDAO;
import com.board.comment.db.boardCommentDTO;

public class BoardCommentWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("BoardCommentWriteAction_execute() 호출");
		
		request.setCharacterEncoding("UTF-8");
		
		// 전달된 게시글번호 저장
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		
		// DTO객체생성
		boardCommentDTO bcDTO = new boardCommentDTO();
		
		// 아이피
		bcDTO.setCmt_ip(request.getRemoteAddr());
		
		// DTO에 전달된 댓글정보 저장
		bcDTO.setUser_nickname(request.getParameter("user_nickname"));
		bcDTO.setCmt_content(request.getParameter("cmt_content"));
		bcDTO.setBoard_num(board_num);
		
		// 댓글DAO객체 생성해서 댓글등록하기
		boardCommentDAO bcDAO = new boardCommentDAO();
		bcDAO.insertBoardComment(board_num, bcDTO);
		
		// 페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./board_content.bo?board_num="+board_num + "&pageNum="+pageNum);
		forward.setRedirect(true);

		return forward;
	}

}
