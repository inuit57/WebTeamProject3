package com.faq.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faq.db.FAQDAO;
import com.faq.db.FAQDTO;

public class FAQAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {


		// 한글처리
		request.setCharacterEncoding("UTF-8");
		
		// 전달된 정보(파라미터 저장)
		FAQDTO fdto = new FAQDTO();
		fdto.setFaq_cate(request.getParameter("faq_cate"));
		fdto.setUser_nick("admin");
		fdto.setFaq_sub(request.getParameter("faq_sub"));
		fdto.setFaq_content(request.getParameter("faq_content"));
		fdto.setFaq_file(request.getParameter("faq_file"));
		
		// DB저장
		FAQDAO fdao = new FAQDAO();
		
		// FAQ작성 메서드 
		fdao.faqWrite(fdto);
		
		
		// 페이지 이동(ActionForward객체)
		ActionForward forward = new ActionForward();
		forward.setPath("./FAQ.faq");

		forward.setRedirect(true);
		
		
		
		return forward;
		
		
		
	}
	
	
	
	
	
	
	
	

}
