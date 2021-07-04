package com.auction.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.auction.db.AuctionDAO;

public class AuctionDeleteAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, 
								 HttpServletResponse response) throws Exception {

		
		int num = Integer.parseInt(request.getParameter("num"));
		
		
		AuctionDAO aDAO = new AuctionDAO();
		aDAO.deleteAuction(num);
		
		
		ActionForward forward = new ActionForward();
		forward.setPath("./AuctionList.ac");
		forward.setRedirect(true);
		
		return forward;
	}

}
