package com.auction.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.auction.db.AuctionDAO;

public class AuctionListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, 
								 HttpServletResponse response) throws Exception {

		System.out.println("상품리스트 액션");
		
		request.setCharacterEncoding("UTF-8");
		
		//status에서 임의로 넣어준 값
		String auc = request.getParameter("auc");
		
		if(auc == null) {
			auc = "all";
		}
		
		AuctionDAO aDAO = new AuctionDAO();
		request.setAttribute("AuctionList", aDAO.getAuctionList(auc));

		//페이징
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) {
			pageNum = "1";
			System.out.println("@@@@@@@@@@@@@@@@@"+pageNum);
		}
		
		request.setAttribute("pageNum", pageNum);
		
		
		
		
		
		
		ActionForward forward = new ActionForward();
		forward.setPath("./auction/auction_list.jsp");
		forward.setRedirect(false);
		 
		return forward;
	}

}
