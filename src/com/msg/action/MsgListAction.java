package com.msg.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.msg.db.MsgDAO;

public class MsgListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("M : MsgListAction() 호출 ");

		// 한글처리 
		request.setCharacterEncoding("utf-8");
		// 전달된 정보(파라미터 저장)
		HttpSession session = request.getSession();
		String user_nick = (String) session.getAttribute("user_nick");
		String msgTag = request.getParameter("tag");
		System.out.println(msgTag);
		
		
		if(msgTag == null){
			msgTag = "recv";
		}
		// 디비 처리 객체 DAO 생성
		MsgDAO mdao = new MsgDAO();
		
		// 정보 저장 -> 영역 저장
		request.setAttribute("msgList", mdao.getMsgList(msgTag, user_nick));
		request.setAttribute("msgTag", msgTag);
		
		// 페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./msg/msg_list.jsp");
		forward.setRedirect(false);
		return forward;
		
	}

}
