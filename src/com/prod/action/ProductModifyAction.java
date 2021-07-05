package com.prod.action;

import java.io.File;

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
		ProdDAO pDAO = new ProdDAO(); 
		
		pDTO.setProd_category(Integer.parseInt(multi.getParameter("category")));
		pDTO.setProd_status(Integer.parseInt(multi.getParameter("status")));
		pDTO.setUser_nickname(multi.getParameter("user_nickname"));
		pDTO.setProd_sub(multi.getParameter("prod_sub"));
		pDTO.setProd_price(Integer.parseInt(multi.getParameter("prod_price")));
		pDTO.setProd_content(multi.getParameter("content"));
		pDTO.setProd_num(num);
		
		//파일, 글내용 받아오기
		//기존 파일명과 비교해서 처리를 먼저 수행할 것. 
		
		String fileNames[] = new String[4] ; 
		ProdDTO old_pDTO = pDAO.getProduct(num); 
		String imgNames[] = old_pDTO.getProd_img().split(","); 
		
		for(int i=0 ; i< 4; i++){
			fileNames[i] = multi.getParameter("fileName0"+(i+1)); 
			if(fileNames[i] == null) {
				fileNames[i] = ""; 
			}
		}
		
		String image =""; 
		int null_cnt = 0 ; 
		
		for(int i = 0 ; i< 4 ; i++){
			 System.out.println("fileName : " + fileNames[i]);
			 System.out.println("imgName : " + imgNames[i]);
			 if( !fileNames[i].equals(imgNames[i])){
				 File fp = new File(realpath + "\\" +imgNames[i]); 
				 if(fp.exists()){
					 fp.delete();
				 }
				 if( multi.getFilesystemName("file"+(i+1)) != null){
					 image += (multi.getFilesystemName("file"+(i+1))+",");
				 }else{
					 null_cnt ++ ; 
				 }
			 }else{
				 image += (fileNames[i] +",");  
			 }
		}
		
		for(int i = 0 ; i < null_cnt ; i++){
			image += "null," ; 
		}
//		String image
//			= multi.getFilesystemName("file1")+","
//			+ multi.getFilesystemName("file2")+","
//			+ multi.getFilesystemName("file3")+","
//			+ multi.getFilesystemName("file4");
		
		pDTO.setProd_img(image);
		
		
		pDAO.getProductUpdate(pDTO);
		//페이지 이동 
		ActionForward forward = new ActionForward();
		forward.setPath("./ProductList.pr");
		forward.setRedirect(true);
		
		return forward;
	}

}
