package com.prod.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.prod.db.ProdDAO;

public class ProductDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, 
								 HttpServletResponse response) throws Exception {
		
		System.out.println("상품삭제!!!!");
		
		int num = Integer.parseInt(request.getParameter("num"));
		
		ProdDAO pDAO = new ProdDAO();
		pDAO.deleteProduct(num);
		
		// 추가 작업 필요 
		// 상품 구매 요청을 보낸 사람들 + 찜목록에 저장한 사람들에게 
		// 쪽지로 상품이 삭제되었음을 알리는 쪽지를 자동으로 발송하기 
		// == insert로 넣어주기 
		
		
		ActionForward forward = new ActionForward();
		forward.setPath("./ProductList.pr");
		forward.setRedirect(true);
		
		return forward;
	}

}
