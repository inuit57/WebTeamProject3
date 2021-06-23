package com.prod.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.prod.db.ProdDAO;
import com.prod.db.ProdDTO;

public class ProductRegisterAction implements Action {

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
		ProdDTO pDTO = new ProdDTO();
		pDTO.setProd_category(Integer.parseInt(multi.getParameter("category")));
		pDTO.setProd_status(Integer.parseInt(multi.getParameter("status")));
		pDTO.setUser_nick(multi.getParameter("nick"));
		pDTO.setProd_sub(multi.getParameter("subject"));
		pDTO.setProd_price(Integer.parseInt(multi.getParameter("price")));
		pDTO.setProd_content(multi.getParameter("content"));
		
		String image
			= multi.getFilesystemName("file1")+","
			+ multi.getFilesystemName("file2")+","
			+ multi.getFilesystemName("file3")+","
			+ multi.getFilesystemName("file4");
		
		pDTO.setProd_img(image);
		
		//중고거래 글 등록 DAO객체 생성
		//insertProduct()
		ProdDAO pDAO = new ProdDAO();
	

			
		pDAO.insertProduct(pDTO);
		
	
		//페이지 이동하기
		ActionForward forward = new ActionForward();
		forward.setPath("./ProductList.pr?");
		forward.setRedirect(true);
		
		return forward;
	}

}
