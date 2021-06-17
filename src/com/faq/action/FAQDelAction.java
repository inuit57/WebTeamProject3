package com.faq.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faq.db.FAQDAO;
import com.faq.db.FAQDTO;

public class FAQDelAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 한글처리
		request.setCharacterEncoding("UTF-8");
		
		// 전달된 정보(파라미터 저장)
		String idx = request.getParameter("faq_idx");
		
		// DB저장
		FAQDAO fdao = new FAQDAO();
		
		// FAQ삭제 메서드 
		fdao.faqDel(idx);
		
		
		// 페이지 이동(ActionForward객체)
		ActionForward forward = new ActionForward();
		forward.setPath("./FAQ.faq");
		forward.setRedirect(true);
		
		
		
		return forward;
		
	}

}
