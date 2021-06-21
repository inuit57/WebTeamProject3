package com.faq.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faq.db.FAQDAO;
import com.faq.db.FAQDTO;

public class FAQUpdateFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		//  한글처리 
		request.setCharacterEncoding("UTF-8");

		// 전달된 파라미터값 idx저장
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		FAQDAO fdao = new FAQDAO();
		FAQDTO fdto = fdao.getFAQ(idx);
		
		request.setAttribute("fdto", fdto);
		
		// 페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./faq_board/faq_update.jsp");
		forward.setRedirect(false);		
		
		return forward;
	}

}
