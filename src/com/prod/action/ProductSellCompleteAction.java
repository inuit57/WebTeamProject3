package com.prod.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.msg.db.MsgDAO;
import com.prod.db.ProdDAO;
import com.wish.db.WishDAO;

public class ProductSellCompleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, 
								 HttpServletResponse response) throws Exception {

		System.out.println("상품 판매 완료 처리");
		
		int prod_num = Integer.parseInt(request.getParameter("num")); 
		
		ProdDAO pDAO = new ProdDAO(); 
		WishDAO wDAO = new WishDAO(); 
		MsgDAO msgDAO = new MsgDAO(); 
		
		// 3: 판매완료 
		pDAO.updateStatus(prod_num, 3);
		
		// 찜목록에 해당 상품 찜한 사람들 가져오기 
		List<String> memberList = wDAO.getWishMembers(prod_num); 
		String prod_sub = pDAO.getProduct(prod_num).getProd_sub(); 
		
		// 시스템 메시지 보내주기 
		msgDAO.msgWrite(memberList , prod_sub); 
		
		// 찜목록에서 해당 상품 삭제 
		wDAO.favoriteDelete(prod_num);
		
		
		//페이지 이동 
		ActionForward forward = new ActionForward();
		forward.setPath("./ProductList.pr");
		forward.setRedirect(true);
		
		return forward;
	}

}
