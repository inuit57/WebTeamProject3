package com.prod.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.prod.db.ProdDAO;
import com.prod.db.ProdSearch;

public class ProductListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, 
								 HttpServletResponse response) throws Exception {

		System.out.println("PRList 페이지");
		
		request.setCharacterEncoding("UTF-8");
		
		//list에서 받아온 item 값
		// null로 들어오는 거 처리하려고 다 string으로 받았습니다.
		String item = request.getParameter("item");
		String search_type = request.getParameter("search_type");
		String search_text = request.getParameter("search_text");
		String min_price = request.getParameter("min_price");
		String max_price = request.getParameter("max_price"); 
		
		if(item == null || item.equals("")) {
			item = "all";
		}
		if(min_price == null || min_price.equals("")){
			min_price = "0"; 
		}

		ProdSearch prodSearch = new ProdSearch(); 
		prodSearch.setItem(item);
		prodSearch.setMin_price(min_price);
		prodSearch.setMax_price(max_price);
		prodSearch.setSearch_type(search_type);
		prodSearch.setSearch_text(search_text);
		
		//중고거래 글 리스트 DAO 생성
		//productList()
		ProdDAO pDAO = new ProdDAO();
		//List productList = pDAO.getProductList();
		//request.setAttribute("productList", pDAO.getProductList(item));
		
		request.setAttribute("productList", pDAO.getProductList(prodSearch));
		
		//request.setAttribute("productList", productList);
		
		//pDTO = (ProdDTO)productList.get(num);
		
		
		//페이징처리
		int pageSize = 10;
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) {
				pageNum = "1";
				
		}
		
		//시작행
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage-1)*pageSize+1; 

		//끝행
		int endRow = currentPage*pageSize;

		//request.setAttribute("productListWant", pDAO.getProductList(startRow,pageSize));
		
		//List productListWant = pDAO.getProductList(startRow,pageSize);
		
		//request.setAttribute("productListWant", productListWant);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("currentPage", currentPage);
		
		ActionForward forward = new ActionForward();
		forward.setPath("./prod_trade/prod_trade_list.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
