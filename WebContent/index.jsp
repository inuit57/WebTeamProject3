
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="jquery/jquery-3.6.0.js"></script>
<script type="text/javascript" src="./user/userLoginJS/userLogin.js"></script>
<title></title>
</head>
<body>
	<h1>Market</h1>
	<a href="./main.bo">메인</a><br>
	
	
	<%if(session.getAttribute("id") != null) { %>
	<%=session.getAttribute("nick") %>님 어서오세요.<br>
		<a href="./UserInfoAction.us">마이 페이지</a><br>
		<a href="./UserLogoutAction.us">로그아웃</a><br>
	<%} else { %>
		<a href="./UserLogin.us">로그인</a><br>
		<a href="./UserJoin.us">회원가입</a><br>
	<%} %>
	
	
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
		// 1:1 문의 게시판 admin 이동
		// response.sendRedirect("./InqueryAdminList.ai");

		// 메인페이지 이동

		 //response.sendRedirect("./InqueryList.in");


		//response.sendRedirect("./Main.do");
		
	  //response.sendRedirect("./FAQAdd.faq");
		
	%>

</body>

</html>