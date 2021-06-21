package com.prod.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.prod.db.ProdDAO;

public class ProductDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, 
								 HttpServletResponse response) throws Exception {
		
		System.out.println("상품삭제!!!!");
		
		int num = Integer.parseInt(request.getParameter("num"));
		
		ProdDAO pDAO = new ProdDAO();
		pDAO.deleteProduct(num);
		
		
		ActionForward forward = new ActionForward();
		forward.setPath("./ProductList.pr");
		forward.setRedirect(true);
		
		return forward;
	}

}
