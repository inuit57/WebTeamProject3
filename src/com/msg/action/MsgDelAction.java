package com.msg.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.msg.db.MsgDAO;

public class MsgDelAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

				// 한글처리
				request.setCharacterEncoding("UTF-8");
				
				// 전달된 정보(파라미터 저장)
				String[] msg_idx = request.getParameterValues("msg_idx");
				
				// DB저장
				MsgDAO mdao = new MsgDAO();
				
				
				// FAQ삭제 메서드 
				for (int i = 0; i < msg_idx.length; i++) {
					mdao.msgDel(msg_idx[i]);
				}
				
				// 페이지 이동(ActionForward객체)
				ActionForward forward = new ActionForward();
				forward.setPath("./MsgListAction.ms");
				forward.setRedirect(true);
				
				
				
				return forward;
	}

}
