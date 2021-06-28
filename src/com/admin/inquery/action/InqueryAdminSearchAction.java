package com.admin.inquery.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.inquery.db.AdminInqueryDAO;

public class InqueryAdminSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("M : InqueryAdminSearchAction_execute() 실행");
		
		request.setCharacterEncoding("utf-8");
		
		String sk = request.getParameter("sk");
		String sv = request.getParameter("sv");
		
		AdminInqueryDAO aiDAO = new AdminInqueryDAO();
		
		int cnt = aiDAO. adminInqueryCount(sk,sv);
		
		System.out.println(sk+sv);
		
		int pageSize = 10;
		
		// 현재 페이지가 몇페이지 인지 확인
		String pageNum = request.getParameter("pageNum");
		
		
		if(pageNum == null){
			pageNum = "1";
		}
		
		// 페이지별 시작행 계산하기
		// 1p -> 1번, 2p -> 11번, 3p -> 21번, ... => 일반화
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage-1)*pageSize+1;
		
		// 끝행 계산하기
		// 1p -> 10번, 2p -> 20번,... => 일반화
		int endRow = currentPage*pageSize;
		
		System.out.println("startRow@@@@@@@@@@@"+startRow);
		System.out.println("pageSize@@@@@@@@@@@@@@@@"+pageSize);
				
		/////////////////////////////////////////////////////////////
	
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("cnt", cnt);
		request.setAttribute("sk", sk);
		request.setAttribute("sv", sv);
		
		//aiDAO.inquerySearchList(sk,sv);
	
		
		request.setAttribute("aiList",aiDAO.inquerySearchList(sk,sv,startRow,pageSize));
		
		ActionForward forward = new ActionForward();
		
		forward.setPath("./admin_inquery/admin_inquery_search.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
