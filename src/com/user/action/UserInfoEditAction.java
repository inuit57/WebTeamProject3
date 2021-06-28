package com.user.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.user.db.UserDAO;
import com.user.db.UserDTO;

public class UserInfoEditAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		UserDTO udto = new UserDTO();
		
		udto.setUser_id(request.getParameter("user_id"));
		udto.setUser_phone(request.getParameter("user_phone"));
		udto.setUser_address(request.getParameter("user_address"));
		udto.setUser_addressPlus(request.getParameter("user_address_plus"));
		udto.setUser_picture(request.getParameter("user_picture"));
		
		UserDAO udao = new UserDAO();
		
		udao.userInfoEdit(udto);
		
		ActionForward forward = new ActionForward();
		forward.setPath("./Main.do");
		forward.setRedirect(true);
		
		return forward;
	}

}
