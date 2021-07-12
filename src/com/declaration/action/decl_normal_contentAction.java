package com.declaration.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.board.db.boardDAO;
import com.board.db.boardDTO;
import com.declaration.db.declarationDAO;
import com.declaration.db.declarationDTO;

public class decl_normal_contentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("M : decl_normal_contentAction_execute() 호출");
		
		request.setCharacterEncoding("utf-8");
		
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		int state = Integer.parseInt(request.getParameter("state"));
		int decl_num = Integer.parseInt(request.getParameter("decl_num"));
		
		declarationDAO dcDAO = new declarationDAO();
		List decl_normal_reason = dcDAO.getDecl_normal_reason(board_num);
		
		
		System.out.println(board_num);
		
		boardDAO bDAO = new boardDAO();
		
		boardDTO bDTO = bDAO.getContent(board_num);
		
		request.setAttribute("bDTO", bDTO);
		request.setAttribute("decl_normal_reason", decl_normal_reason);
		request.setAttribute("decl_num", decl_num);
		
		// 페이지이동
		ActionForward forward = new ActionForward();
		
		forward.setPath("./declaration/decl_normal_content.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
