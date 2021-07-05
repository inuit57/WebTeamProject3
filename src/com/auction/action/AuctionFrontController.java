package com.auction.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.ac")
public class AuctionFrontController extends HttpServlet{
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//가상주소 전체 가져오기
		String requestURI = request.getRequestURI();
		
		//프로젝트명 가져오기
		String contextPath = request.getContextPath();
		
		//필요한 가상주소 생성
		String command = requestURI.substring(contextPath.length());
		System.out.println("페이지 주소 파싱완료");
		
		/***************************** 페이지 주소 파싱 ******************************/
		
		/***************************** 페이지 주소 연결 ******************************/
		Action action = null;
		ActionForward forward = null;
		

		if(command.equals("/AuctionRegister.ac")) {
			
			forward = new ActionForward();
			forward.setPath("./auction/auction_write.jsp");
			forward.setRedirect(false);
			
		}else if(command.equals("/AuctionRegisterAction.ac")){
			
			//AuctionRegisterAction 객체 만들기 (경매게시판 글 쓰기)
			action = new AuctionRegisterAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if(command.equals("/AuctionList.ac")) {
			
			///AuctionListAction 객체
			action = new AuctionListAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if(command.equals("/AuctionDetail.ac")) {
			
			//AuctionDetailAction 객체
			action = new AuctionDetailAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if(command.equals("/AuctionDeleteAction.ac")) {
			
			//AuctionDeleteAction 객체
			action = new AuctionDeleteAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if(command.equals("/AuctionModify.ac")) {
			
			forward = new ActionForward();
			forward.setPath("./auction/auction_modify.jsp");
			forward.setRedirect(false);
			
		}else if(command.equals("/AuctionModifyAction.ac")) {
			
			//AuctionModifyAction 객체
			action = new AuctionModifyAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		
		
		
		
		
		
		/***************************** 페이지 주소 이동 ******************************/
		
		if(forward != null) {
			if(forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			}else {
				RequestDispatcher dis = request.getRequestDispatcher(forward.getPath());
				dis.forward(request, response);
			}
		}
		System.out.println("페이지이동xxxxx");
		
	}
	
	@Override
	protected void doGet(HttpServletRequest request , HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	

}
