package com.prod.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.pr")
public class ProductRegisterFrontController extends HttpServlet{
	
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
		

		if(command.equals("/ProductTrade.pr")) {

			forward = new ActionForward();
			forward.setPath("./prod_trade.jsp");
			forward.setRedirect(false);
			
		}else if(command.equals("/ProductRegister.pr")) {
			System.out.println("중고거래 등록 게시판");
			
			forward = new ActionForward();
			forward.setPath("./prod_trade/prod_trade_write.jsp");
			forward.setRedirect(false);
			
		}else if(command.equals("/ProductRegisterAction.pr")) {
			
			//ProductRegisterAction()객체 생성
			action = new ProductRegisterAction();
			
			try {
				forward = action.execute(request, response);
				//forward에 담아주어야 페이지 이동가능한
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if(command.equals("/ProductList.pr")) {
			
			//ProductListAction()객체 생성
			action = new ProductListAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if(command.equals("/ProductDetail.pr")) {
			
			//ProductDetailAction()객체 생성
			action = new ProductDetailAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if(command.equals("/ProductModify.pr")) {
			
			forward = new ActionForward();
			forward.setPath("./prod_trade/prod_trade_modify.jsp");
			forward.setRedirect(false);
		
		}else if(command.equals("/ProductModifyAction.pr")){
			
			//ProductModifyAcition()객체 생성
			action = new ProductModifyAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if(command.equals("/ProductDeleteAction.pr")) {
			
			//ProductDeleteAction()객체 생성
			action = new ProductDeleteAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		} else if(command.equals("/MyPageProductList.pr")) {
			//MyPageProductListAction()객체 생성
			action = new MyPageProductListAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/ProductSellComplete.pr")){
			action = new ProductSellCompleteAction();
			
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
