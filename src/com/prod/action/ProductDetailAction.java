package com.prod.action;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.prod.db.ProdDAO;
import com.prod.db.ProdDTO;
import com.wish.db.WishDAO;

public class ProductDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, 
								 HttpServletResponse response) throws Exception {

		System.out.println("제품 상세 페이지");
		
		//중고거래 글 list에서 넘어오는 주소창 num 값 
		int num = Integer.parseInt(request.getParameter("num"));
		
		ProdDAO pDAO = new ProdDAO();
		request.setAttribute("product", pDAO.getProduct(num));

		//상품 찜 횟수
		//WishDAO wDAO = new WishDAO();
		//request.setAttribute("wishCount", wDAO.wishCount(num));
				
		
		
		int count = 0;
		
		Cookie[] cookies = request.getCookies();
		
		
		// IP 조회 : request.getRemoteAddr()
			if(cookies != null) {
				for(int i=0;i<cookies.length;i++) {
					//if(cookies[i].getName().equals(pDTO.getProd_num()+"")) {
					if(cookies[i].getName().equals("prod_count"+num) && cookies[i].getValue().equals(request.getRemoteAddr())) {
						count = 0;
						System.out.println("테슽@@@@@"+cookies[i].getName());
						break;
					}else {
						Cookie cookie = new Cookie("prod_count"+num,
													request.getRemoteAddr());
													//String.valueOf(pDTO.getProd_num()+""));
						cookie.setMaxAge(60*60*24);
						//cookie.setPath("/");
						response.addCookie(cookie);
						count += 1;
						System.out.println("else 출력~~~");
					}
				}
			}
		
			if(count > 0) {
				pDAO.updateCount(num);
			}
		
		
			
		
		//페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./prod_trade/prod_trade_detail.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
