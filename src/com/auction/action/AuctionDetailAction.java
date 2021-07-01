package com.auction.action;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.auction.db.AuctionDAO;

public class AuctionDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, 
								 HttpServletResponse response) throws Exception {

		
		//list에서 넘어오는 num
		int num = Integer.parseInt(request.getParameter("num"));
		
		AuctionDAO aDAO = new AuctionDAO();
		//경매 상품 정보 가져오기
		request.setAttribute("Auction", aDAO.getAuction(num));
		
		
		int count = 0;
		
		Cookie[] cookies = request.getCookies();
		
		if(cookies != null) {
			for(int i=0;i<cookies.length;i++) {
				if(cookies[i].getName().equals("auct_count"+num)&& cookies[i].getValue().equals(request.getRemoteAddr())) {
					count = 0;
					break;
				}else {
					Cookie cookie = new Cookie("auct_count"+num,
											request.getRemoteAddr());
					cookie.setMaxAge(60*60*24);
					response.addCookie(cookie);
					count += 1;
				}
			}
		}
		if(count > 0) {
			aDAO.updateCount(num);
		}
		
		//페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./auction/auction_detail.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
