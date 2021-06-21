package com.board.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.board.db.boardDAO;
import com.board.db.boardDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardWriteAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("M : BoardWrite_execute() 호출");
		
		// 파일업로드
		// upload 폴더생성
		// request.getRealPath("/upload"); <- 가능은하나 권장하지않음
		ServletContext ctx = request.getServletContext();
		String realpath = ctx.getRealPath("/upload");
		
		int maxSize = 5 * 1024 * 1024;
		
		MultipartRequest multi = new MultipartRequest(request, realpath, maxSize,"UTF-8",new DefaultFileRenamePolicy());
		
		System.out.println("M : 파일업로드 완료");
		
		
		// 나머지 전달정보를 DB에 저장
		
		// boardDTO 객체를 생성후 전달된 정보를 저장
		boardDTO bDTO = new boardDTO();
		
		bDTO.setBoard_ip(request.getRemoteAddr());
		
		bDTO.setBoard_area(multi.getParameter("board_area"));
		bDTO.setUser_nick(multi.getParameter("user_nick"));
		bDTO.setBoard_sub(multi.getParameter("board_sub"));
		bDTO.setBoard_content(multi.getParameter("board_content"));
		bDTO.setBoard_file(multi.getFilesystemName("board_file"));
		
		boardDAO bDAO = new boardDAO();
		bDAO.insertBoard(bDTO);
		
		// 페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./board_List.bo");
		forward.setRedirect(true);

		return forward;
	}

}
