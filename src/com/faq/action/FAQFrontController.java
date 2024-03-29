package com.faq.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.faq")
public class FAQFrontController extends HttpServlet {

	protected void doProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("C : FAQFrontController_doPrecess() 호출");

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

		if (command.equals("/FAQAdd.faq")) {
			System.out.println("C : /FAQAdd.faq  호출");
			// 정보를 입력받는 페이지 -> view페이지 이동

			forward = new ActionForward();
			forward.setPath("./faq_board/faq_write.jsp");
			forward.setRedirect(false);
		} else if (command.equals("/FAQAddAction.faq")) {
			System.out.println("C : /FAQAddAction.faq 호출");
			action = new FAQAddAction();

			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/FAQ.faq")) {
			System.out.println("C : /FAQ.faq 호출");
			// DB정보를 화면이동 없이 출력
			action = new FAQListAction();

			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/FAQDelAction.faq")) {
			System.out.println("C : /FAQDelAction.faq 호출");
			// DB정보를 화면이동 없이 출력
			action = new FAQDelAction();

			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/FAQUpdate.faq")) {
			System.out.println("C : /FAQUpdate.faq 호출");
			// DB 정보를 꺼내서 화면에 출력
			action = new FAQUpdateFormAction();

			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/FAQUpdateAction.faq")) {
			System.out.println("C : /FAQUpdateAction.faq 호출");
			// DB 정보를 꺼내서 화면에 출력

			action = new FAQUpdateAction();

			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/FAQSerchAction.faq")) {
			System.out.println("C : /FAQSerchAction.faq 호출");
			// DB 정보를 꺼내서 화면에 출력

			action = new FAQSerchAction();

			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		System.out.println("C : 2.페이지 주소 매핑 완료");

		/******************* 2.페이지 주소 매핑(연결) ****************************/

		/******************* 3.페이지 주소 이동 ********************************/

		if (forward != null) { // 페이지 이동정보가 있다.
			if (forward.isRedirect()) { // true
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
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("---------------------------------------------------------");
		System.out.println("C : InqueryFrontController_doGet() 호출");
		doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("---------------------------------------------------------");
		System.out.println("C : InqueryFrontController_doPost() 호출");
		doProcess(request, response);
	}

}
