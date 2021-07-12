package com.admin.inquery.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.inquery.action.Action;
import com.admin.inquery.action.ActionForward;

@WebServlet("*.ai")
public class InqueryAdminFrontController extends HttpServlet{

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("C : InqueryAdminFrontController_doPrecess() 호출");
		
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
		
		if(command.equals("/InqueryAdminList.ai")){
			System.out.println("C : /InqueryAdminList.ai 호출");
			
			action = new InqueryAdminListAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(command.equals("/InqueryAdminWriteFormAction.ai")){
			System.out.println("C : /InqueryAdminWriteAction.ai 호출");
			
			forward = new ActionForward();
			
			forward.setPath("./admin/admin_inquery/admin_inquery_write_form.jsp");
			forward.setRedirect(false);
		} else if(command.equals("/InqueryAdminWriteAction.ai")){
			System.out.println("C : /InqueryAdminWriteAction.ai 호출");
			
			action = new InqueryAdminWriteAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			
		} else if(command.equals("/InqueryAdminContent.ai")){
			System.out.println("C : ./InqueryAdminContent.ai 호출");
			
			action = new InqueryAdminContentAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		} else if(command.equals("/InqueryAdminModifyForm.ai")){
			System.out.println("C : /InqueryAdminModifyForm.ai 호출");
			
			action = new InqueryAdminModifyFormAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(command.equals("/InqueryAdminModify.ai")){
			System.out.println("C : /InqueryAdminModify.ai 호출");
			
			action = new InqueryAdminModifyAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		} else if(command.equals("/InqueryAdminDelete.ai")){
			System.out.println("C : /InqueryAdminDelete.ai 호출");
			
			action = new InqueryAdminDeleteAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		} else if(command.equals("/InqueryAdminSearch.ai")){
			System.out.println("C : /InqueryAdminSearch.ai 호출");
			
			action = new InqueryAdminSearchAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(command.equals("/InqueryAdminListSample.ai")){
			System.out.println("/InqueryAdminListSample.ai 호출");
			
			action = new InqueryAdminListAction2();
			
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
		System.out.println("---------------------------------------------------------");
		System.out.println("C : InqueryAdminFrontController_doGet() 호출");
		doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("---------------------------------------------------------");
		System.out.println("C : InqueryAdminFrontController_doPost() 호출");
		doProcess(request, response);
	}

	
}
