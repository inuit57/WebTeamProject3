
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
	// 게시판글쓰기 이동
	// response.sendRedirect("./board_Write.bo");
	
	// 메인페이지
	// response.sendRedirect("./main.bo");
	// 댓글인설트중
	// 일반게시판 목록
	// response.sendRedirect("./board_List.bo");
	%>

	<!--  실행페이지 -->
	<%
		

		// 1:1 문의 게시판 이동
		// response.sendRedirect("./InqueryList.in");

		// 메인페이지 이동

		response.sendRedirect("./Main.do");
		
	  //response.sendRedirect("./FAQAdd.faq");
		
	%>
	
	

</body>

</html>