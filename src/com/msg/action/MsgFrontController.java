package com.msg.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faq.action.FAQAddAction;

@WebServlet("*.ms")
public class MsgFrontController extends HttpServlet {

	protected void doProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("C : PaymentFrontController_doPrecess() 호출");

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

		if (command.equals("/Msg.ms")) {
			System.out.println("C : /Msg.ms  호출");
			// 정보를 입력받는 페이지 -> view페이지 이동

			forward = new ActionForward();
			forward.setPath("./msg/msg_list.jsp");
			forward.setRedirect(false);
		}else if (command.equals("/MsgWriteAction.ms")) {
			System.out.println("C : /MsgWriteAction.ms 호출");
			action = new MsgWriteAction();

			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if (command.equals("/MsgListAction.ms")) {
			System.out.println("C : /MsgListAction.ms 호출");
			action = new MsgListAction();

			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if (command.equals("/MsgReadChkAction.ms")) {
			System.out.println("C : /MsgReadChkAction.ms 호출");
			action = new MsgReadChkAction();

			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if (command.equals("/MsgDelAction.ms")) {
			System.out.println("C : /MsgDelAction.ms 호출");
			action = new MsgDelAction();

			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if (command.equals("/MsgAlarmAction.ms")) {
			System.out.println("C : /MsgAlarmAction.ms 호출");
			action = new MsgAlarmAction();

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

