package com.admin.inquery.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.inquery.db.AdminInqueryDAO;

public class InqueryAdminListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			System.out.println("M : InqueryAdminListAction_execute() 호출");
		
		
		ActionForward forward = new ActionForward();
		
		AdminInqueryDAO aiDAO = new AdminInqueryDAO();
		
		String check = request.getParameter("check");
		
		int cnt = aiDAO. adminInqueryCount();
		
		//////////////////////////////////////////////////////////////
		// 게시판 페이징 처리 : DB에서 원하는 만큼만 글 가져오기
		
		// 한 페이지당 보여줄 글의 개수
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
				
		/////////////////////////////////////////////////////////////
	
		// 디비에 저장된 모든 글 정보를 가져오기
		System.out.println("startRow@@@@@@@@@@@"+startRow);
		System.out.println("pageSize@@@@@@@@@@@@@@@@"+pageSize);
				
		
		List aiList = new ArrayList();
						
		if( (check == null) || (check.equals("null")) ) {
		
		aiList = aiDAO.getAdminInqueryList(startRow,pageSize);

		}else {

		aiList = aiDAO.getAdminInqueryList(check,startRow,pageSize);
		cnt =  aiDAO. adminInqueryCount(check);
		request.setAttribute("check", check);
		
		}
		
		
		request.setAttribute("aiList", aiList);		
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("cnt", cnt);

		
		
		// "./admin_inquery/admin_inquery_list.jsp"
		forward.setPath("./admin/admin_inquery/admin_inquery_list.jsp");
		forward.setRedirect(false);
	
		return forward;
	}

}
