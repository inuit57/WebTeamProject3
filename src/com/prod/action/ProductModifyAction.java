package com.prod.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.prod.db.ProdDAO;
import com.prod.db.ProdDTO;

public class ProductModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, 
								 HttpServletResponse response) throws Exception {

		System.out.println("상품정보 수정 페이지");
		
		
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
		
		int num = Integer.parseInt(multi.getParameter("num"));
		
		ProdDTO pDTO = new ProdDTO();
		
		
		pDTO.setProd_category(Integer.parseInt(multi.getParameter("category")));
		pDTO.setProd_status(Integer.parseInt(multi.getParameter("status")));
		pDTO.setUser_nick(multi.getParameter("nick"));
		pDTO.setProd_sub(multi.getParameter("prod_sub"));
		pDTO.setProd_price(Integer.parseInt(multi.getParameter("prod_price")));
		pDTO.setProd_content(multi.getParameter("content"));
		pDTO.setProd_num(num);
		
		//파일, 글내용 받아오기
		String image
			= multi.getFilesystemName("file1")+","
			+ multi.getFilesystemName("file2")+","
			+ multi.getFilesystemName("file3")+","
			+ multi.getFilesystemName("file4");
		
		pDTO.setProd_img(image);
		
		//수정 DAO 
		ProdDAO pDAO = new ProdDAO();
		
		pDAO.getProductUpdate(pDTO);
		//페이지 이동 
		ActionForward forward = new ActionForward();
		forward.setPath("./ProductList.pr");
		forward.setRedirect(true);
		
		return forward;
	}

}
