
package com.user.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		}
		else if (command.equals("/UserJoin.us")) {
			//회원 가입 페이지로 이동
			forward = new ActionForward();
			forward.setPath("./user/userJoin.jsp");
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