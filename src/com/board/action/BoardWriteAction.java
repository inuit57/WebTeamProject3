package com.board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.board.db.boardDAO;
import com.board.db.boardDTO;

public class BoardWriteAction implements Action{
	
	

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("M : BoardWrite_execute() 호출");
		
		request.setCharacterEncoding("utf-8");
		
		
		// 나머지 전달정보를 DB에 저장
		
		// boardDTO 객체를 생성후 전달된 정보를 저장
		boardDTO bDTO = new boardDTO();
		
		// 아이피생성
		bDTO.setBoard_ip(request.getRemoteAddr());
		
		bDTO.setBoard_area(request.getParameter("board_area"));
		bDTO.setUser_nickname(request.getParameter("user_nickname"));
		bDTO.setBoard_sub(request.getParameter("board_sub"));
		bDTO.setBoard_content(request.getParameter("board_content"));
		
		boardDAO bDAO = new boardDAO();
		bDAO.insertBoard(bDTO);
		
		// 페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./board_List.bo");
		forward.setRedirect(true);

		return forward;
	}

}
