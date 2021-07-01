package com.inquery.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.inquery.action.ActionForward;
import com.inquery.db.InqueryDAO;

public class InqueryListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			System.out.println("M : InqueryListAction_execute() 호출");

		
		HttpSession session = request.getSession();
		//String nick = (String) session.getAttribute("user_nick");
		
		// 테스트용 닉
		String nick = "홍길정";
		
		ActionForward forward = new ActionForward();
		// 세션정보처리 들고다니는 값이 무엇인지에 따라 값이 달라질 수 있음 id가 nick으로
	/*	if(nick==null){
			forward.setPath("");
			forward.setRedirect(true);
			return forward;
		}*/
			
		InqueryDAO inDAO = new InqueryDAO();
		
		inDAO.getMyInqueryList(nick);
			
		request.setAttribute("myInqueryList", inDAO.getMyInqueryList(nick));
			
		forward.setPath("./inquery/inquery_list.jsp");
		forward.setRedirect(false);	

		
		return forward;
	}

}
