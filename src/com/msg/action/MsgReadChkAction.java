package com.msg.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.msg.db.MsgDAO;
import com.user.db.UserDAO;

public class MsgReadChkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 한글처리
		request.setCharacterEncoding("UTF-8");

		int msg_idx = Integer.parseInt(request.getParameter("msg_idx"));
		
		MsgDAO mdao = new MsgDAO();

		mdao.updateMsgChk(msg_idx);

		PrintWriter out = response.getWriter();
		out.print("성공");
		out.close();
		
		return null;
	}

}
