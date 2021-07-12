package com.chat.action;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ChatController extends HttpServlet{
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
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
		} else if(command.equals("/MakeSession.ch")) {
			try {
				action = new MakeSessionAction();
				action.execute(request, response);
			} catch (Exception e) {
				System.out.println(e.toString());
				System.out.println("ChatController's else if(MakeSession.ch) Error - KBH");
			}
		} else if(command.equals("/ChatSave.ch")) {
			try {
				action = new ChatSaveAction();
				action.execute(request, response);
			} catch (Exception e) {
				System.out.println(e.toString());
				System.out.println("ChatController's else if(ChatSave.ch) Error - KBH");
			}
		} else if(command.equals("/ChatDeleteAction.ch")) {
			try {
				System.out.println("chatdeleteaction 들어옴");
				action = new ChatDeleteAction();
				action.execute(request, response);
			} catch (Exception e) {
				System.out.println(e.toString());
				System.out.println("ChatController's else if(ChatDeleteAction.ch) Error - KBH");
			}
		} else if(command.equals("/ChatLoad.ch")) {
			try {
				
				request.setCharacterEncoding("UTF-8");
				
				String result = "";
				
				String roomId = request.getParameter("roomId");
				
				ServletContext ctx = request.getServletContext();
				String realpath = ctx.getRealPath("/chatlog/" + roomId +".txt");
				
				File file = new File(realpath);
				FileWriter fw2 = null;
				
				if(!file.exists()) {
					fw2 = new FileWriter(file);
					fw2.write("");
					fw2.flush();
					fw2.close();
				}
				
				BufferedReader br = new BufferedReader(new FileReader(realpath));
				PrintWriter out = response.getWriter();
				
				while(true) {
					String str = br.readLine();
					
					if(str == null) break;
					
					result += str;
				}
				
				out.print(URLEncoder.encode(result,"UTF-8"));
				
				br.close();
				out.close();
				
			} catch (Exception e) {
				System.out.println(e.toString());
				System.out.println("ChatController's else if(ChatLoadAction.ch) Error - KBH");
			} finally {
				
			}
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
