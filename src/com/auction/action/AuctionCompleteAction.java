package com.auction.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.auction.bid.db.bidDAO;
import com.auction.db.AuctionDAO;
import com.msg.db.MsgDAO;
import com.prod.db.ProdDAO;
import com.wish.db.WishDAO;

public class AuctionCompleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, 
								 HttpServletResponse response) throws Exception {

		System.out.println("낙찰 완료 처리");
		
		int auct_num = Integer.parseInt(request.getParameter("num")); 
		
		AuctionDAO aDAO = new AuctionDAO();
		bidDAO bDAO = new bidDAO();
		
		// 1: 낙찰완료 
		aDAO.updateStatus(auct_num, 1);
		
		
		//페이지 이동 
		ActionForward forward = new ActionForward();
		forward.setPath("./AuctionList.ac");
		forward.setRedirect(true);
		
		return forward;
	}

}
