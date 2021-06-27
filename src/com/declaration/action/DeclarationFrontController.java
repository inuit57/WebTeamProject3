package com.declaration.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



public class DeclarationFrontController extends HttpServlet{

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("C : BoardDeclarationFrontController_doPrecess() 호출");
		
		/******************* 1.페이지 주소 파싱 ********************************/
		
		// 가상주소 전체 가져오기
		String requestURI = request.getRequestURI();
		// 프로젝트명 가져오기
		String contextPath = request.getContextPath();
		// 필요한 가상주소 생성
		String command = requestURI.substring(contextPath.length());
		
		System.out.println("command : " + command);
		System.out.println("C : 1.페이지 주소 파싱 완료");
		
		/******************* 1.페이지 주소 파싱 ********************************/
		
		
		/******************* 2.페이지 주소 매핑(연결) ****************************/
		
		Action action = null;
		ActionForward forward = null;
		
		if(command.equals("/declaration.decl")){
			System.out.println("C : /declaration.decl 호출");
			
			forward = new ActionForward();
			forward.setPath("./declaration/declaration.jsp");
			forward.setRedirect(false);
			
		}
		else if(command.equals("/declarationAction.decl")){
			System.out.println("C : declarationAction.decl 호출");
			
			action = new declarationAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(command.equals("/declarationList.decl")){
			System.out.println("C : /declarationList.decl 호출");
			
			forward = new ActionForward();
			forward.setPath("./declaration/declarationList.jsp");
			forward.setRedirect(false);
			
		}
		else if(command.equals("/decl_normal_list.decl")){
			System.out.println("C : decl_normal_list.decl 호출");
			
			action = new decl_normal_listAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		else if(command.equals("/decl_normal_content.decl")){
			System.out.println("C : /decl_normal_content.decl 호출");
			
			action = new decl_normal_contentAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(command.equals("/decl_normal_boardDeleteAction.decl")){
			System.out.println("C : /decl_normal_boardDeleteAction.decl 호출");
			
			action = new decl_normal_boardDeleteAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		
		
		
		
		
		
		

		System.out.println("C : 2.페이지 주소 매핑 완료");
		
		/******************* 2.페이지 주소 매핑(연결) ****************************/
		
		
		/******************* 3.페이지 주소 이동 ********************************/
		
		if(forward != null){ // 페이지 이동정보가 있다.
			if(forward.isRedirect()){ // true
				response.sendRedirect(forward.getPath());
				System.out.println("C : sendRedirect() 방식, " + forward.getPath() + " 페이지 이동");
			} else { // false
				RequestDispatcher dis = request.getRequestDispatcher(forward.getPath());
				dis.forward(request, response);
				
				System.out.println("C : forward() 방식, " + forward.getPath() + " 페이지 이동");
			}
			System.out.println("C : 3. 페이지 주소이동 완료");
		}
		System.out.println("C : 3. 페이지 주소이동 X(컨트롤러 이동X)");
		/******************* 3.페이지 주소 이동 ********************************/
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("C : BoardDeclarationFrontController_doGet() 호출");
		doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("C : BoardDeclarationFrontController_doPost() 호출");
		doProcess(request, response);
	}
}
