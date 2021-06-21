package com.prod.action;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.prod.db.ProdDAO;
import com.prod.db.ProdDTO;

public class ProductDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, 
								 HttpServletResponse response) throws Exception {

		System.out.println("제품 상세 페이지");
		
		//중고거래 글 list에서 넘어오는 주소창 num 값 
		int num = Integer.parseInt(request.getParameter("num"));
		
		ProdDAO pDAO = new ProdDAO();
		request.setAttribute("product", pDAO.getProduct(num));

		ProdDTO pDTO = new ProdDTO();
		
		int count = 0;
		Cookie[] cookies = request.getCookies();
		
			if(cookies != null) {
				for(int i=0;i<cookies.length;i++) {
					if(cookies[i].getName().equals("prod_count"+pDTO.getProd_count())) {
						count = 0;
						break;
					}else {
						Cookie cookie = new Cookie("prod_count"+pDTO.getProd_count(), 
													String.valueOf(pDTO.getProd_count()));
						cookie.setMaxAge(60*60*24);
						//cookie.setPath("/");
						response.addCookie(cookie);
						count += 1;
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
