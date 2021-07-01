package com.declaration.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.board.db.boardDAO;
import com.board.db.boardDTO;
import com.declaration.db.declarationDAO;
import com.declaration.db.declarationDTO;
import com.prod.db.ProdDAO;
import com.prod.db.ProdDTO;

public class decl_prod_contentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("M : decl_prod_contentAction_execute() 호출");
		
		request.setCharacterEncoding("utf-8");
		
		int num = Integer.parseInt(request.getParameter("num"));
		
		declarationDAO dcDAO = new declarationDAO();
		List decl_prod_reason = dcDAO.getDecl_prod_reason(num);
		
		
		ProdDAO pDAO = new ProdDAO();
		
		ProdDTO pDTO = pDAO.getProduct(num);
		
		request.setAttribute("pDTO", pDTO);
		request.setAttribute("decl_prod_reason", decl_prod_reason);
		
		// 페이지이동
		ActionForward forward = new ActionForward();
		
		forward.setPath("./declaration/decl_prod_content.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
