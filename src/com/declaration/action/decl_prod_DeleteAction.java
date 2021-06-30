package com.declaration.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.declaration.db.declarationDAO;
import com.prod.db.ProdDAO;

public class decl_prod_DeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("prodDeleteAction_execute() 호출");
		
		int num = Integer.parseInt(request.getParameter("num"));
		
		ProdDAO pDAO = new ProdDAO();
		pDAO.deleteProduct(num);
		
		declarationDAO dcDAO = new declarationDAO();
		// 해당글삭제하기 를 하면 상품 DB에서 삭제하고 신고목록 DB에서도 지우기
		dcDAO.decl_prod_delete(num);
		
		// 페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("decl_prod_list.decl");
		forward.setRedirect(true);
		
		return forward;
	}

}
