package com.auction.bid.aciton;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.auction.bid.db.bidDAO;
import com.auction.bid.db.bidDTO;
import com.auction.db.AuctionDAO;
import com.user.db.UserDAO;

public class AuctBidAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, 
								 HttpServletResponse response) throws Exception {

		
		bidDTO bDTO = new bidDTO();
		
		int num = Integer.parseInt(request.getParameter("auct_num"));
		String user_nick = request.getParameter("user_nick");
		int bidprice = Integer.parseInt(request.getParameter("bidprice"));
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@업데이트 돼" + bidprice);
		bidDAO bDAO = new bidDAO();
		UserDAO uDAO = new UserDAO();
		
		//입찰을 했는지 안했는지 확인하는 메소드
		int data = bDAO.bidCheck(num,user_nick);
		
		
		//입찰하려는 코인이 자신이 가진 코인보다 적으면 입찰 할 수 없다
		/*
		 * if(uDAO.getCoin(user_nick) < bidprice) { data = 1; }
		 */
		
				
		//버튼 눌렀을때 입찰완료 버튼 바뀌기(insert)
		if(data == 0) {//입찰을 하지 않았다면 입찰 등록하기
			bDAO.updateBid(num, user_nick, bidprice);
		}
		//bDAO.deleteBid(num, user_nick);
		
		//최고가 메소드
		int maxPrice = bDAO.getMaxPrice(num);
		
		request.setAttribute("maxPrice", maxPrice);
		
		
		response.setContentType("application/x-json; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();
		
		obj.put("check", data);
		obj.put("maxPrice", maxPrice);
		
		out.print(obj);
		out.close();
		
		
		
		return null;
	}

}
