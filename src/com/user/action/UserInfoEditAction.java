package com.user.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.user.db.UserDAO;
import com.user.db.UserDTO;

public class UserInfoEditAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//파일업로드 폴더
		ServletContext ctx = request.getServletContext();
		String realpath = ctx.getRealPath("/upload");
		
		int maxSize = 5 * 1024 * 1024;
		
		MultipartRequest multi
			= new MultipartRequest(
						request,
						realpath,
						maxSize,
						"UTF-8",
						new DefaultFileRenamePolicy()
					);
		
		System.out.println(realpath);
		
		UserDTO udto = new UserDTO();

		String nick = multi.getParameter("user_nick"); 
		
		// 닉네임 변경 시 session에 저장된 정보도 변경하기 
		HttpSession session = request.getSession(); 
		session.setAttribute("user_nick", nick);
		
		udto.setUser_id(multi.getParameter("user_id"));
		udto.setUser_nickname(nick);
		udto.setUser_phone(multi.getParameter("user_phone"));
		udto.setUser_address(multi.getParameter("user_address"));
		udto.setUser_addressPlus(multi.getParameter("user_address_plus"));
		udto.setUser_picture(multi.getFilesystemName("user_picture"));
		
		System.out.println("Picture name : " + multi.getFilesystemName("user_picture"));
		
		UserDAO udao = new UserDAO();
		
		udao.userInfoEdit(udto);
		
		ActionForward forward = new ActionForward();
		forward.setPath("./Main.do");
		forward.setRedirect(true);
		
		

		
		return forward;
	}

}
