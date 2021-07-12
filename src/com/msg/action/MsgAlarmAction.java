package com.msg.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.msg.db.MsgDAO;

public class MsgAlarmAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

				// 한글처리 
				request.setCharacterEncoding("utf-8");
				// 전달된 정보(파라미터 저장)
				String user_nick = request.getParameter("user_nick");
			
				MsgDAO mdao = new MsgDAO();
				
				
				
				PrintWriter out = response.getWriter();
				out.print(mdao.getRecvChk(user_nick));
				out.close();
		
		return null;
	}

}
