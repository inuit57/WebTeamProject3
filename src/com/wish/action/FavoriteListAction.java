package com.wish.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.wish.db.WishDAO;
import com.wish.db.WishDTO;

public class FavoriteListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ActionForward forward = new ActionForward(); 
		HttpSession session = request.getSession(); 
		
		String user_nick = (String)session.getAttribute("user_nick");
		
		if(user_nick == null){ 
			forward.setPath("./UserLogin.us");
			forward.setRedirect(true);
			return forward ; 
		}
		
		WishDAO wDAO = new WishDAO(); 
		
		List<WishDTO> wList = wDAO.wishList(user_nick); 
		
		request.setAttribute("wList", wList);
		
		forward.setPath("./prod_trade/mypage_wish_list.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
