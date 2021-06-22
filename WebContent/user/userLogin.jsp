<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="jquery/jquery-3.6.0.js"></script>
<script type="text/javascript" src="./user/userLoginJS/userLogin.js"></script>
<title>Insert title here</title>
</head>
<body>
	<% String error = request.getParameter("error"); %>
	<h3>로그인</h3>
	<form action="./UserLoginAction.us">
	<input type="text" id="id" name="id" placeholder="아이디"><br>
	<input type="password" id="pw" name="pw" placeholder="비밀번호"><br>
	<input type="submit" value="로그인"><br>
	</form>
	<%if(error != null && error.equals("1")) {%>
	<label>아이디 또는 비밀번호 오류 입니다.</label>
	<%} else {} %>
</body>
</html>