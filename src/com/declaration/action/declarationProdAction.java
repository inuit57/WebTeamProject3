package com.declaration.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

import com.declaration.db.declarationDAO;
import com.declaration.db.declarationDTO;

public class declarationProdAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("M : declarationAction_execute() 호출");
		
		request.setCharacterEncoding("utf-8");
		
		// 신고 후 게시글로 돌아가기 위해 게시글번호, 페이지번호 받기
		int prod_num = Integer.parseInt(request.getParameter("prod_num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		// DTO객체생성
		declarationDTO dcDTO = new declarationDTO();
		
		// DTO객체에 전달받은 신고내용 저장
		dcDTO.setBoard_type(Integer.parseInt(request.getParameter("board_type")));
		dcDTO.setBoard_num(Integer.parseInt(request.getParameter("prod_num")));
		// 신고를 하는사람
		dcDTO.setUser_nickname(request.getParameter("user_nickname"));
		dcDTO.setBoard_sub(request.getParameter("board_sub"));
		dcDTO.setDecl_reason(Integer.parseInt(request.getParameter("decl_reason"))); // 신고사유
		dcDTO.setDecl_content(request.getParameter("decl_content")); // 기타내용
		dcDTO.setDecl_writer(request.getParameter("decl_writer")); // 신고글 작성자
		dcDTO.setBoard_sub(request.getParameter("board_sub"));
		dcDTO.setDecl_state(Integer.parseInt(request.getParameter("decl_state")));
		
		declarationDAO dcDAO = new declarationDAO();
		int result = dcDAO.declWrite(dcDTO);
		
		if (result == 1){
	          response.setContentType("text/html; charset=utf-8");
	          PrintWriter out = response.getWriter();
	          
	          out.print("<script>");
	          out.print("alert('신고가 접수되었습니다.');");
	          out.print("location.href='./ProductDetail.pr?num="+prod_num + "&pageNum="+ pageNum +"'");
	          out.print("</script>");
	          
	          out.close();
	          return null;
	       }
		
		
//		// 페이지 이동
//		ActionForward forward = new ActionForward();
//		forward.setPath("./ProductDetail.pr?num="+prod_num + "&pageNum="+pageNum);
//		forward.setRedirect(true);
		
		return null;
	}

}
