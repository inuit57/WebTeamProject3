package com.declaration.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.board.db.boardDAO;
import com.board.db.boardDTO;
import com.declaration.db.declarationDAO;
import com.declaration.db.declarationDTO;

public class decl_normal_listAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("M : decl_normal_listAction_execute() 호출");
		
		declarationDAO dcDAO = new declarationDAO();
		List decl_normal_list = dcDAO.getDecl_normal_list();
		
		request.setAttribute("decl_normal_list", decl_normal_list);
		
		// 페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./declaration/decl_normal_list.jsp");
		forward.setRedirect(false);
			
		return forward;
	}

}
