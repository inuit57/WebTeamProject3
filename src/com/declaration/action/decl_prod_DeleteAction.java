package com.declaration.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.declaration.db.declarationDAO;
import com.prod.db.ProdDAO;

public class decl_prod_DeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("prodDeleteAction_execute() 호출");
		
		int num = Integer.parseInt(request.getParameter("num"));
		int state = Integer.parseInt(request.getParameter("state"));
		
		ProdDAO pDAO = new ProdDAO();
		pDAO.deleteProduct(num);
		
		declarationDAO dcDAO = new declarationDAO();
		// 해당글삭제하기 를 하면 상품 DB에서 삭제하고 신고목록 DB에서도 지우기
		// - 신고게시판에서는 지우지 않는걸로 변경
		// dcDAO.decl_prod_delete(num);
		
		// 관리자가 신고된 글 삭제시 처리상태를 1(처리중)에서 2(처리완료)로 변경
		dcDAO.decl_state_prod_update(num);
		
		// 페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("decl_prod_list.decl?state="+state);
		forward.setRedirect(true);
		
		return forward;
	}

}
