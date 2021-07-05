package com.chat.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ChatController extends HttpServlet{
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String requestURI = request.getRequestURI();
		
		String contextPath = request.getContextPath();
		
		String command = requestURI.substring(contextPath.length());
		
		Action action = null;
		ActionForward forward = null;
		
		if(command.equals("/chat.ch")){
			
			forward = new ActionForward();
			
			forward.setPath("./chat/chat.jsp");
			forward.setRedirect(false);
		} else if(command.equals("/ChatAction.ch")) {
			System.out.println("ChatAction 들어옴");
			try {
				action = new ChatAction();
				forward = action.execute(request, response);
			} catch (Exception e) {
				System.out.println(e.toString());
				System.out.println("ChatController's else if(chatAction.ch) Error - KBH");
			}
		} else if(command.equals("/chatlist.ch")) {
			forward = new ActionForward();
			
			forward.setPath("./chat/chatlist.jsp");
			forward.setRedirect(false);
		}
		
		if(forward != null){ // 페이지 이동정보가 있다.
			if(forward.isRedirect()){ // true
				response.sendRedirect(forward.getPath());
			} else { // false
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
