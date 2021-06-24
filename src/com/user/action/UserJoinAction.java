package com.user.action;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.user.db.UserDAO;
import com.user.db.UserDTO;

public class UserJoinAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//DTO 만들어서 데이터 집어넣기
		UserDTO udto = new UserDTO();
		
		udto.setUser_id(request.getParameter("id"));
		udto.setUser_nickname(request.getParameter("nickname"));
		udto.setUser_pw(request.getParameter("pw"));
		udto.setUser_joindate(new Timestamp(System.currentTimeMillis()));
		udto.setUser_coin(0);
		udto.setUser_phone(request.getParameter("phone"));
		udto.setUser_address(request.getParameter("address"));
		udto.setUser_addressPlus(request.getParameter("address_plus"));
		udto.setUser_bankName("");
		udto.setUser_bankAccount("");
		udto.setUser_picture("default_image.png");
		udto.setUser_auth(0);
		udto.setUser_grade(1);
		udto.setUser_use_yn(0);
		
		//DAO를 이용한 DB 처리(INSERT)
		UserDAO udao = new UserDAO();
		udao.insertUser(udto);
		
		//페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./Main.do");
		forward.setRedirect(true);
		
		return forward;
	}
	
}
