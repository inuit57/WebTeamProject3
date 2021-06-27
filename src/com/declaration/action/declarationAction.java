package com.declaration.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

import com.declaration.db.declarationDAO;
import com.declaration.db.declarationDTO;

public class declarationAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("M : declarationAction_execute() 호출");
		
		request.setCharacterEncoding("utf-8");
		
		// 신고 후 게시글로 돌아가기 위해 게시글번호, 페이지번호 받기
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		System.out.println(board_num);
		System.out.println(pageNum);
		// DTO객체생성
		declarationDTO dcDTO = new declarationDTO();
		
		// DTO객체에 전달받은 신고내용 저장
		dcDTO.setBoard_type(Integer.parseInt(request.getParameter("board_type")));
		dcDTO.setBoard_num(Integer.parseInt(request.getParameter("board_num")));
		// 신고를 하는사람
		dcDTO.setUser_nick(request.getParameter("user_nick"));
		dcDTO.setDecl_reason(Integer.parseInt(request.getParameter("decl_reason"))); // 신고사유
		dcDTO.setDecl_content(request.getParameter("decl_content")); // 기타내용
		dcDTO.setDecl_writer(request.getParameter("decl_writer")); // 신고글 작성자
		
		
		declarationDAO dcDAO = new declarationDAO();
		dcDAO.declWrite(dcDTO);
		
		
		// 페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./board_content.bo?board_num="+board_num + "&pageNum="+pageNum);
		forward.setRedirect(true);
		
		return forward;
	}

}
