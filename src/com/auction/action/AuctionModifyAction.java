package com.auction.action;

import java.io.File;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.auction.db.AuctionDAO;
import com.auction.db.AuctionDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.auction.action.ActionForward;


public class AuctionModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, 
								 HttpServletResponse response) throws Exception {
	
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
		
		AuctionDTO aDTO = new AuctionDTO();
		AuctionDAO aDAO = new AuctionDAO(); 
		
		aDTO.setAuct_status(Integer.parseInt(multi.getParameter("status")));
		aDTO.setUser_nick(multi.getParameter("nick"));
		aDTO.setAuct_sub(multi.getParameter("auct_sub"));
		aDTO.setAuct_price(Integer.parseInt(multi.getParameter("auct_price")));
		aDTO.setAuct_content(multi.getParameter("content"));
		aDTO.setAuct_num(num);
		
		
		String fileNames[] = new String[4]; 
		
		AuctionDTO old_aDTO = aDAO.getAuction(num); //수정하기 전 게시글 
		
		String imgNames[] = old_aDTO.getAuct_img().split(","); //수정하기 전 게시글 이미지 
		
		for(int i=0 ; i< 4; i++){
			fileNames[i] = multi.getParameter("fileName0"+(i+1)); 
			if(fileNames[i] == null) {
				fileNames[i] = ""; 
			}
		}
		
		String image =""; 
		int null_cnt = 0 ; 
		
		for(int i = 0 ; i< 4 ; i++){
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

		aDTO.setAuct_img(image);
		
		
		aDAO.getAuctionUpdate(aDTO);
		
		
		//페이지 이동 
		ActionForward forward = new ActionForward();
		forward.setPath("./AuctionList.ac");
		forward.setRedirect(true);
		
		return forward;

	}

}
