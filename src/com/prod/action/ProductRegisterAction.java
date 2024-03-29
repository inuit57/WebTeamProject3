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
		pDTO.setUser_nickname(multi.getParameter("nick")); // form에 nick으로 되어있습니다!!! 고치지 마세요!!!!! 
		pDTO.setProd_sub(multi.getParameter("prod_sub"));
		pDTO.setProd_price(Integer.parseInt(multi.getParameter("prod_price")));
		pDTO.setProd_content(multi.getParameter("prod_content"));
		
		String image =""; 
		int null_cnt = 0 ; 
		
		for(int i = 1; i<=4 ; i++){
			String imgName = multi.getFilesystemName("file"+i); 
			if(imgName == null){
				null_cnt ++; 
			}else{
				image+= (multi.getFilesystemName("file"+i)+","); 
			}
		}
		
		for(int i = 0 ; i< null_cnt; i++){
			image +=("null,"); 
		}
//		String image
//			= multi.getFilesystemName("file1")+","
//			+ multi.getFilesystemName("file2")+","
//			+ multi.getFilesystemName("file3")+","
//			+ multi.getFilesystemName("file4");
		
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
