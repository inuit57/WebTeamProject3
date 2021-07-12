package com.prod.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.prod.db.ProdDAO;
import com.prod.db.ProdSearch;

public class MyPageProductListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("PRList 페이지");
		
		HttpSession session = request.getSession() ; 
		
		String user_nick = (String)session.getAttribute("user_nick"); 
		
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
		
		ProdSearch prodsearch = new ProdSearch(); 
		
		prodsearch.setSearch_text(user_nick);
		prodsearch.setSearch_type("seller");
		prodsearch.setItem("all");
		prodsearch.setMin_price("0");
		
//		request.setAttribute("productList", pDAO.getProductList(item));
		request.setAttribute("productList", pDAO.getProductList(prodsearch));
		//request.setAttribute("productList", productList);
		
		//조회수
		//int cnt = pDAO.getProductCount();
		//request.setAttribute("productListCount", pDAO.getProductCount());
		
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
		
		List productListWant = pDAO.getProductList(startRow,pageSize);
		
		request.setAttribute("productListWant", productListWant);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("currentPage", currentPage);
		
		
		
		ActionForward forward = new ActionForward();
		forward.setPath("./prod_trade/mypage_prod_list.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
