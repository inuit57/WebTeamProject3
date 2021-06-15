<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="WEB-INF/lib/jquery-3.6.0.js"></script>
<script type="text/javascript" src="./user/userCheckJS/UserCheck.js"></script>
<title></title>
</head>
<body>
	<form action="./UserJoinAction.us" method="post">
	
	<label>아이디 : </label><input type="text" name="id" id="id"><br>
	<label>닉네임 : </label><input type="text" name="nickname" id="nickname"><br>
	<label>비밀번호 : </label><input type="password" name="pw" id="pw"><br>
	<label>비밀번호 확인 : </label><input type="password" id="pw_check"><br>
	<label>전화번호 : </label><input type="text" name="phone" id="phone"><br>
	<label>주소 : </label><input type="text" name="address" id="address"><br>
	<label>상세주소 : </label><input type="text" name="address_plus" id="address_plus"><br>
	<input type="submit" value="가입하기">
	</form>
</body>
</html>