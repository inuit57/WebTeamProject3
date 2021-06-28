package com.user.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.user.db.UserDAO;

public class UserBankChangeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		
		String id = (String)session.getAttribute("id");
		String bankName = request.getParameter("bankname");
		String bankAccount = request.getParameter("bankaccount");
		
		UserDAO udao = new UserDAO();
		
		udao.changeBankAccount(id,bankName,bankAccount);
		
		ActionForward forward = new ActionForward();
		forward.setPath("./UserInfoAction.us");
		forward.setRedirect(true);
		
		return forward;
	}

}
