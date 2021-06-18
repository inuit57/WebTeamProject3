package com.faq.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faq.db.FAQDAO;

public class FAQListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("M : FAQListtAction_execute() 호출 ");

		// 한글처리 
		request.setCharacterEncoding("utf-8");
		// 파라미터를 처리
		String faq_cate = request.getParameter("tag");
		
		if(faq_cate == null){
			faq_cate = "all";
		}
		
		// 디비 처리 객체 DAO 생성
		FAQDAO fdao = new FAQDAO();
		
		// 정보 저장 -> 영역 저장
		request.setAttribute("faqList", fdao.getFAQList(faq_cate));
		
		// 페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./faq_board/faq_list.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
