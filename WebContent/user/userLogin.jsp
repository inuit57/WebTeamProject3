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
	<h3>로그인</h3>
	<input type="text" id="id" name="id" placeholder="아이디"><br>
	<input type="password" id="pw" name="pw" placeholder="비밀번호"><br>
	<input type="button" value="로그인" onclick="userLogin();"><br>
</body>
</html>