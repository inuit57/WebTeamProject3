package com.board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.board.db.boardDAO;
import com.board.db.boardDTO;

public class BoardModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("M : BoardModifyAction_execute() 호출");
		
		// 한글처리
		request.setCharacterEncoding("UTF-8");
		
		// 전달된 수정할 정보를 저장(DTO)
		boardDTO bDTO = new boardDTO();
		
		bDTO.setBoard_num(Integer.parseInt(request.getParameter("board_num")));
		bDTO.setBoard_sub(request.getParameter("board_sub"));
		bDTO.setBoard_area(request.getParameter("board_area"));
		bDTO.setBoard_content(request.getParameter("board_content"));
		
		boardDAO bDAO = new boardDAO();
		bDAO.modifyBoard(bDTO);
		
		// 페이지이동
		ActionForward forward = new ActionForward();
		
		forward.setPath("./board_List.bo");
		forward.setRedirect(true);
		
		return forward;
	}

}
