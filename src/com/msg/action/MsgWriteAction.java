package com.msg.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.msg.db.MsgDAO;
import com.msg.db.MsgDTO;

public class MsgWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
				// 한글처리
				request.setCharacterEncoding("UTF-8");
				
				// 전달된 정보(파라미터 저장)
				MsgDTO mdto = new MsgDTO();
				
				mdto.setRecv_nick(request.getParameter("recv_nick"));
				mdto.setSend_nick(request.getParameter("send_nick"));
				mdto.setMsg_content(request.getParameter("msg_content"));
				
				System.out.println(request.getParameter("recv_nick"));
				System.out.println(request.getParameter("send_nick"));
				System.out.println(request.getParameter("msg_content"));
				
				// DB저장
				MsgDAO mdao = new MsgDAO();
				
				// FAQ작성 메서드 
				mdao.msgWrite(mdto);
				
				
				// 페이지 이동(ActionForward객체)
				ActionForward forward = new ActionForward();
				forward.setPath("./MsgListAction.ms");

				forward.setRedirect(true);
				
				
				
				return forward;
	}

}
