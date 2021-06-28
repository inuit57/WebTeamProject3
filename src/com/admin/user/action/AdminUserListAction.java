package com.admin.user.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.user.db.AdminUserDAO;

public class AdminUserListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ActionForward forward = new ActionForward();
		
		AdminUserDAO auDAO = new AdminUserDAO();

		
		int cnt = auDAO.adminUserCount();
		
		int pageSize = 5;
		
		String pageNum = request.getParameter("pageNum");
		
		if(pageNum==null) {
			pageNum = "1";
		}
		
		// 페이지별 시작행 계산하기
				// 1p -> 1번, 2p -> 11번, 3p -> 21번, ... => 일반화
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage-1)*pageSize+1;
		
		// 끝행 계산하기
		// 1p -> 10번, 2p -> 20번,... => 일반화
		int endRow = currentPage*pageSize;
		
		
		////////////////////////////////////////////////
		
		String auth_s = request.getParameter("auth");
		
		int auth = 0 ;
		if(auth_s!=null){
			auth =Integer.parseInt(request.getParameter("auth"));
		}
		System.out.println("@#@@@@@@@@@@@@@@@@@"+auth);
		
		List auList = new ArrayList();
		
		System.out.println("@@@@@@@@@@@@@@@"+auth);
		
		if(auth_s!=null){
			
			auList = auDAO.getAdminUserList(auth,startRow,pageSize);
			cnt = auDAO.adminUserCount(auth);
			System.out.println("@@@@@@@@@@@@@@@1111111"+auth_s);
			
		}else{
			
			auList = auDAO.getAdminUserList(startRow,pageSize);			
			System.out.println("@@@@@@@@@@@@@@@22222222"+auth_s);
		}
		

		
		
		request.setAttribute("auList",auList);
		
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("cnt", cnt);
		request.setAttribute("auth", auth);
		
		
		forward.setPath("./admin/admin_user/admin_user_all.jsp");
		forward.setRedirect(false);
		
		
		return forward;
	}

}
