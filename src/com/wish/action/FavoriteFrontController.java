package com.wish.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.fp")
public class FavoriteFrontController extends HttpServlet{
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//가상주소 전체 가져오기
		String requestURI = request.getRequestURI();
		
		//프로젝트명 가져오기
		String contextPath = request.getContextPath();
		
		//필요한 가상주소 생성
		String command = requestURI.substring(contextPath.length());
		System.out.println("페이지 주소 파싱완료");
		
		/***************************** 페이지 주소 파싱 ******************************/
		
		/***************************** 페이지 주소 연결 ******************************/
		Action action = null;
		ActionForward forward = null;
		

		if(command.equals("/favoriteProdAction.fp")) {
			///favoriteProdAction.fp 객체 생성
			action = new favoriteProdAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if(command.equals("/favoriteListAction.fp")) {
			
			action = new FavoriteListAction(); 
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			} 
		}
		
		
		
		
		
		
		
		
		/***************************** 페이지 주소 이동 ******************************/
		
		if(forward != null) {
			if(forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			}else {
				RequestDispatcher dis = request.getRequestDispatcher(forward.getPath());
				dis.forward(request, response);
			}
		}
		System.out.println("페이지이동xxxxx");
		
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
