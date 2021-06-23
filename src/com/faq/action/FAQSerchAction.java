package com.faq.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faq.db.FAQDAO;
//import com.sun.xml.internal.bind.v2.schemagen.xmlschema.List;

public class FAQSerchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 한글처리
		request.setCharacterEncoding("utf-8");
		
		String keyword = request.getParameter("faq_search");
		
		FAQDAO fdao = new FAQDAO();
		
		request.setAttribute("faqList", fdao.getSearchList(keyword));
		
		ActionForward forward = new ActionForward();
		forward.setPath("./faq_board/faq_list.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
