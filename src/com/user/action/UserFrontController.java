
package com.user.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.user.db.UserDAO;

/* 3조
 * 
 * 
 * 유저 테이블로 작업 합니다.
 * 기존 수업에서 사용하던 member단어를 user로 바꾸어 진행했습니다.
 * 주소 표기는 *.us(user 약자)로 했습니다.
 * 
 * 
 * */

public class UserFrontController extends HttpServlet{

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		// 가상주소 전체 가져오기
		String requestURI = request.getRequestURI();
		
		// 프로젝트명 가져오기
		String contextPath = request.getContextPath();
		String command = requestURI.substring(contextPath.length());

		Action action = null;
		ActionForward forward = null;
		
		if (command.equals("/index.us")) {
			//index 페이지로 이동
			forward = new ActionForward();
			forward.setPath("./index.jsp");
			forward.setRedirect(false);
		} else if (command.equals("/UserJoinChk.us")) {
			//회원 가입 페이지로 이동
			forward = new ActionForward();
			forward.setPath("./user/userJoinChk.jsp");
			forward.setRedirect(false);
		} else if(command.equals("/UserLogin.us")) {
			//로그인 페이지로 이동
			forward = new ActionForward();
			forward.setPath("./user/userLogin.jsp");
			forward.setRedirect(false);
		} else if(command.equals("/UserJoinAction.us")) {
			//회원 가입 페이지에서 Submit 누르면 이동
			try {
				action = new UserJoinAction();
				forward = action.execute(request, response);
			} catch (Exception e) {
				System.out.println(e.toString());
				System.out.println("UserFrontController's if(UserJoinAction.us) Error - KBH");
			}
		} else if(command.equals("/UserNickCheckAction.us")) {
			//닉네임 체크 ajax
			PrintWriter out = response.getWriter();
			String a = request.getParameter("nickname");
			boolean isExist = false;
			isExist = new UserDAO().checkNick(a);
			if(isExist) {
				out.write("1");
			} else {
				out.write("0");
			}
			out.close();
		} else if(command.equals("/UserIdCheckAction.us")) {
			//아이디 체크 ajax
			PrintWriter out = response.getWriter();
			String a = request.getParameter("id");
			boolean isExist = false;
			isExist = new UserDAO().checkId(a);
			if(isExist) {
				out.write("1");
			} else {
				out.write("0");
			}
		} else if(command.equals("/UserLoginAction.us")) {
			//로그인
			try {
				action = new UserLoginAction();
				forward = action.execute(request, response);
			} catch (Exception e) {
				System.out.println(e.toString());
				System.out.println("UserFrontController command(UserLoginAction.us) Problem - KBH");
			}
		} else if(command.equals("/UserLogoutAction.us")) {
			try {
				action = new UserLogoutAction();
				forward = action.execute(request, response);
			} catch (Exception e) {
				System.out.println(e.toString());
				System.out.println("UserFrontController command(UserLogoutAction.us) Problem - KBH");
			}
		} else if(command.equals("/UserInfo.us")) {
			//UserInfo 페이지로 이동
			forward = new ActionForward();
			forward.setPath("./user/userInfo.jsp");
			forward.setRedirect(false);
		} else if(command.equals("/UserInfoAction.us")) {
			try {
				action = new UserInfoAction();
				forward = action.execute(request, response);
			} catch (Exception e) {
				System.out.println(e.toString());
				System.out.println("UserFrontController command(UserInfoAction.us) Problem - KBH");
			}
		} else if(command.equals("/UserDeleteAction.us")) {
			try {
				action = new UserDeleteAction();
				forward = action.execute(request, response);
			} catch (Exception e) {
				System.out.println(e.toString());
				System.out.println("UserFrontController command(UserDeleteAction.us) Probelm - KBH");
			}
		} else if(command.equals("/UserInfoEditAction.us")) {
			try {
				action = new UserInfoEditAction();
				forward = action.execute(request, response);
			} catch (Exception e) {
				System.out.println(e.toString());
				System.out.println("UserFrontController command(UserInfoEditAction.us) Problem - KBH");
			}
		} else if(command.equals("/UserPasswordEditAction.us")) {
			try {
				action = new UserPasswordEditAction();
				forward = action.execute(request, response);
			} catch (Exception e) {
				System.out.println(e.toString());
				System.out.println("UserFrontController command(UserPasswordEditAction.us) Problem - KBH");
			}
		} else if(command.equals("/UserBankChangeAction.us")) {
			try {
				action = new UserBankChangeAction();
				forward = action.execute(request, response);
			} catch (Exception e) {
				System.out.println(e.toString());
				System.out.println("UserFrontController command(UserBankChangeAction.us) Problem - KBH");
			}
		}else if(command.equals("/UserEmail.us")){
			forward = new ActionForward();
			forward.setPath("./user/mail.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/UserEmailSendAction.us")){
			try {
				action = new UserEmailSendAction();
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/UserEmailChk.us")){
			forward = new ActionForward();
			forward.setPath("./user/mailChk.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/UserJoin.us")){
			forward = new ActionForward();
			forward.setPath("./user/userJoin.jsp");
			forward.setRedirect(false);
		}
		
		if(forward != null) {
			if(forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			} else {
				RequestDispatcher dis = request.getRequestDispatcher(forward.getPath());
				dis.forward(request, response);
			}
		}
	}
	
	@Override
	protected void doGet(HttpServletRequest request , HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	
}