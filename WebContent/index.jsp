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
	<a href="./UserLogin.us">로그인</a><br>
	<a href="./UserJoin.us">회원가입</a><br>
	
	<%if(session.getAttribute("id") != null) { %>
	<%=session.getAttribute("id") %>
	<a href="./UserInfoAction.us">유저 정보</a>
	<a href="./UserLogoutAction.us">로그아웃</a>
	<%} %>
</body>
</html>