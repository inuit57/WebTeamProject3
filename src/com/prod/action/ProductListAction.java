package com.prod.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.prod.db.ProdDAO;

public class ProductListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, 
								 HttpServletResponse response) throws Exception {

		System.out.println("PRList 페이지");
		
		request.setCharacterEncoding("UTF-8");
		
		//list에서 받아온 item 값
		String item = request.getParameter("item");
		
		if(item == null) {
			
			item = "all";
		}
		
		//중고거래 글 리스트 DAO 생성
		//productList()
		ProdDAO pDAO = new ProdDAO();
		//List productList = pDAO.getProductList();
		request.setAttribute("productList", pDAO.getProductList(item));
		
		//request.setAttribute("productList", productList);
		
		ActionForward forward = new ActionForward();
		forward.setPath("./prod_trade/prod_trade_list.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
