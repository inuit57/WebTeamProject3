package com.payment.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.user.db.UserDAO;

public class CoinAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
				// 한글처리
				request.setCharacterEncoding("UTF-8");

				String user_nick = request.getParameter("user_nick");
				
				System.out.println(user_nick);
				
				UserDAO udao = new UserDAO();

				int result = udao.getCoin(user_nick);

				PrintWriter out = response.getWriter();
				out.print(result);
				out.close();
				
		return null;
	}

}
