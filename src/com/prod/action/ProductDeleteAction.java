package com.prod.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.msg.db.MsgDAO;
import com.prod.db.ProdDAO;
import com.wish.db.WishDAO;

public class ProductDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, 
								 HttpServletResponse response) throws Exception {
		
		System.out.println("상품삭제!!!!");
		
		int num = Integer.parseInt(request.getParameter("num"));
		
		ProdDAO pDAO = new ProdDAO();
		WishDAO wDAO = new WishDAO(); 
		MsgDAO msgDAO = new MsgDAO(); 
		
		pDAO.deleteProduct(num);

		//쪽지 발송
		List<String> memberList = wDAO.getWishMembers(num); 
		msgDAO.msgWrite(memberList);
		
		wDAO.favoriteDelete(num); //찜목록에서도 삭제
		
		ActionForward forward = new ActionForward();
		forward.setPath("./ProductList.pr");
		forward.setRedirect(true);
		
		return forward;
	}

}
