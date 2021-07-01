package com.auction.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.auction.db.AuctionDAO;
import com.auction.db.AuctionDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class AuctionRegisterAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, 
								 HttpServletResponse response) throws Exception {

		System.out.println("PR Action 페이지");
		
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
		
		//ProdDTO 객체 생성 후 전달된 정보 저장 
		AuctionDTO aDTO = new AuctionDTO();
		aDTO.setAuct_status(Integer.parseInt(multi.getParameter("status")));
		aDTO.setUser_nick(multi.getParameter("nick"));
		aDTO.setAuct_sub(multi.getParameter("auct_sub"));
		aDTO.setAuct_price(Integer.parseInt(multi.getParameter("auct_price")));
		aDTO.setAuct_content(multi.getParameter("auct_content"));
		
		String image
			= multi.getFilesystemName("file1")+","
			+ multi.getFilesystemName("file2")+","
			+ multi.getFilesystemName("file3")+","
			+ multi.getFilesystemName("file4");
		
		aDTO.setAuct_img(image);
		
		
		//중고거래 글 등록 DAO객체 생성
		//insertProduct()
	 	AuctionDAO aDAO = new AuctionDAO();
	
		aDAO.insertAuction(aDTO);
		
	
		//페이지 이동하기
		ActionForward forward = new ActionForward();
		forward.setPath("./AuctionList.ac");
		forward.setRedirect(true);
		
		return forward;
	}

}
