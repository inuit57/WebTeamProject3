package com.payment.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tradeLog.db.TradeLogDAO;
import com.user.db.UserDAO;

public class PaymentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 한글처리
		request.setCharacterEncoding("UTF-8");
		
		
		// 전달된 정보(파라미터 저장)
		HttpSession session = request.getSession();
		String user_nick = (String) session.getAttribute("user_nick");
		
		int totalamount = Integer.parseInt(request.getParameter("totalamount"));
		
		System.out.println("==========================================");
		System.out.println(totalamount);
		
		// DB저장 - member테이블에 coin 추가
		UserDAO udao = new UserDAO();
		TradeLogDAO tlDAO = new TradeLogDAO(); 
		
		udao.charge(user_nick, totalamount); //충전 
		tlDAO.chargeLog(user_nick, totalamount); //로그 기록 추가
		
		return null;
	}

}
