package com.board.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.board.comment.db.boardCommentDAO;
import com.board.db.boardDAO;
import com.board.db.boardDTO;

public class BoardContentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("BoardContentAction_execute() 호출");
		
		boardDAO bDAO = new boardDAO();
		// 조회수 증가
		int cmt_cnt = bDAO.getBoardCount();
		
		// 한페이지당 보여줄 글의 개수
		int cmt_pageSize = 5;
		
		
		// 전달된 정보저장
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
		// 현페이지가 몇페이지 인지 확인
		String cmt_pageNum = request.getParameter("cmt_pageNum");
		if(cmt_pageNum == null){
			cmt_pageNum = "1";
		}
		
		int currentPage = Integer.parseInt(cmt_pageNum);
		int startRow = (currentPage - 1) * cmt_pageSize + 1;
		
		int endRow = currentPage * cmt_pageSize;
		
		boardCommentDAO bcDAO = new boardCommentDAO();
		List boardCommentList = bcDAO.getBoardCommentList(startRow, cmt_pageSize);
		
		bDAO.updateReadcount(board_num);
		
		boardDTO bDTO = bDAO.getContent(board_num);
		
		request.setAttribute("boardCommentList", boardCommentList);
		request.setAttribute("cmt_pageNum", cmt_pageNum);
		request.setAttribute("cmt_pageSize", cmt_pageSize);
		request.setAttribute("currentPage", currentPage);
		
		request.setAttribute("bDTO", bDTO);
		
		// 페이지 이동
		ActionForward forward = new ActionForward();
		
		forward.setPath("./board/board_content.jsp");
		forward.setRedirect(false);
			
		return forward;
	}

}
