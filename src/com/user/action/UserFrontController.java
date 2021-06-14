
package com.user.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


// 개발에서 사용되는 중요 개념 => 도메인 

// 컨트롤러 -> 서블릿 


public class UserFrontController extends HttpServlet{

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 가상주소 전체 가져오기
		String requestURI = request.getRequestURI();
		System.out.println("requestURI:" + requestURI);
		// 프로젝트명 가져오기
		String contextPath = request.getContextPath();
		System.out.println("contextPath" + contextPath);
		// 필요한 가상 주소 생성
		String command = requestURI.substring(contextPath.length());
		System.out.println(command);

		Action action = null;
		ActionForward forward = null;
		
		
		if (command.equals("/JoinUser.us")) {
			//회원 가입 페이지로 이동
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