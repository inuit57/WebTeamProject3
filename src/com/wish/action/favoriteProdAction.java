package com.wish.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.prod.db.ProdDTO;
import com.wish.db.WishDAO;
import com.wish.db.WishDTO;

public class favoriteProdAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, 
								 HttpServletResponse response) throws Exception {

		
		WishDTO wDTO = new WishDTO();
		
		int num = Integer.parseInt(request.getParameter("prod_num"));
		
		//int num = Integer.parseInt(request.getParameter("num"));
		
		String nick = request.getParameter("user_nick");
		
		
		WishDAO wDAO = new WishDAO();
		
		//찜이 눌렸는지 안눌렸는지 조회
		int data = wDAO.favoriteCheck(num, nick);
		request.setAttribute("check", data);
		

		
		
		System.out.println("-------"+data);
		
		if(data == 1) { //이미 찜을 눌렀다면 삭제
			wDAO.favoriteDelete(num, nick);
		}else {//그게 아니라면 찜 눌리기 data == 0
			wDAO.favoriteInsert(num, nick);
		}
		
		//상품 찜 횟수
		int count = wDAO.wishCount(num);
		request.setAttribute("wishCount", count);
		System.out.println("count : " + count);
		response.setContentType("application/x-json; charset=UTF-8");
		//response.setContentType("text/html; charset=utf-8");
	    PrintWriter out = response.getWriter();
	      
	      JSONObject obj = new JSONObject();
	      obj.put("check", data);
	      obj.put("count", count);

			
	      //request.setAttribute("json", json); 
			
		
	     //out.print(data);
	     out.print(obj);
	     out.close();
		
		
		
		return null;
	}

}
