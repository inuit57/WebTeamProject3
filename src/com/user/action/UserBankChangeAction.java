package com.user.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.user.db.UserDAO;

public class UserBankChangeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		String nick_name = (String)session.getAttribute("user_nick");
		
		String bankName = request.getParameter("bankname");
		String bankAccount = request.getParameter("bankaccount");
		
		UserDAO udao = new UserDAO();
		
		String id = udao.getId(nick_name);
		udao.changeBankAccount(id,bankName,bankAccount);
		
		ActionForward forward = new ActionForward();
		forward.setPath("./UserInfoAction.us");
		forward.setRedirect(true);
		System.out.println("은행 저장 완료");
		System.out.println(id);
		return forward;
	}

}
