package com.admin.inquery.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.inquery.db.AdminInqueryDAO;
import com.inquery.db.InqueryDTO;
import com.msg.db.MsgDAO;
import com.msg.db.MsgDTO;


public class InqueryAdminWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			System.out.println("M : InqueryAdminWriteAction_execute() 호출");
		
		// 관리자 제어
			
			request.setCharacterEncoding("utf-8");

			
			
			InqueryDTO inDTO = new InqueryDTO();
			
			inDTO.setInq_num(Integer.parseInt(request.getParameter("num")));
			 inDTO.setUser_nickname(request.getParameter("name"));
			inDTO.setInq_sub(request.getParameter("subject"));
			inDTO.setInq_content(request.getParameter("content"));
				
			int num  = Integer.parseInt(request.getParameter("num"));
			
			
			AdminInqueryDAO aiDAO = new AdminInqueryDAO();
			
			String name = aiDAO.getUsernick(num);
			
			aiDAO.adminReWrite(inDTO);
			
			aiDAO.adminCheckUpdate(inDTO);
			
			MsgDTO mDTO = new MsgDTO();
			
			mDTO.setSend_nick("admin");
			mDTO.setRecv_nick(name);
			mDTO.setMsg_content("1:1 문의사항 답변이 추가되었습니다!");
			
			MsgDAO mDAO = new MsgDAO();
			
			mDAO.msgWrite(mDTO);
			
			ActionForward forward = new ActionForward();
			
			forward.setPath("./InqueryAdminList.ai");
			forward.setRedirect(true);
		
		
		
		return forward;
	}

}
