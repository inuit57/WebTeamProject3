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
		
		udto.setId(request.getParameter("id"));
		udto.setNickname(request.getParameter("nickname"));
		udto.setPw(request.getParameter("pw"));
		udto.setJoindate(new Timestamp(System.currentTimeMillis()));
		udto.setCoin(0);
		udto.setPhone(request.getParameter("phone"));
		udto.setAddress(request.getParameter("address"));
		udto.setAddressPlus(request.getParameter("address_plus"));
		udto.setBankName("");
		udto.setBankAccount("");
		udto.setPicture("default_image.png");
		udto.setAuth(0);
		udto.setGrade(1);
		udto.setUse_yn(0);
		
		//DAO를 이용한 DB 처리(INSERT)
		UserDAO udao = new UserDAO();
		udao.insertUser(udto);
		
		//페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./index.us");
		forward.setRedirect(true);
		
		return forward;
	}
	
}
