package com.chat.action;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ChatSaveAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		
		String roomId = request.getParameter("roomId");
		String chatRole = request.getParameter("chatRole");
		String msg = request.getParameter("msg");
		
		String saveMsg = chatRole + "|" + msg + "/";
		
		ServletContext ctx = request.getServletContext();
		String realpath = ctx.getRealPath("/chatlog/");
		
		
		
		try {
			BufferedWriter fw = new BufferedWriter(new FileWriter(realpath + roomId + ".txt",true));
//			BufferedWriter fw = new BufferedWriter(new FileWriter(realpath + roomId,true));
			
			fw.write(saveMsg);
			fw.flush();
			fw.close();
		} catch (Exception e) {
			System.out.println(e.toString());
			System.out.println("ChatSaveAction.java error - KBH");
		}
		
		
		return null;
	}

}
