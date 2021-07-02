<%@page import="com.user.db.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="./user/userInfoJS/userInfo.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href="css/userInfo.css" rel="stylesheet">
<title>회원 정보 수정</title>
</head>
<body>

	<% 
	//String user_nick = (String)session.getAttribute("user_nick"); 
	
	UserDTO udto = (UserDTO)session.getAttribute("udto"); 
	
	String m = request.getParameter("m");
	
	String user_picture = udto.getUser_picture(); 
	
	%>

	
	%>
	</form>
	</fieldset>
	<hr>
	<fieldset>
	<legend>현재 계좌정보</legend>
	<label>은행 이름 :</label><label><%=udto.getUser_bankName() %></label><br>
	<label>계좌 번호 :</label><label><%=udto.getUser_bankAccount() %></label><br>
	</fieldset>
	<hr>
	<fieldset>
	<legend>계좌 정보 변경하기</legend>
	<form action="./UserBankChangeAction.us" method="post" onsubmit="return check()">
	<select id="bankname" name="bankname">
		<option value="none" >은행을 선택 하세요.</option>
		<option value="카카오뱅크">카카오뱅크</option>
		<option value="국민은행">국민은행</option>
		<option value="우리은행">우리은행</option>
		<option value="부산은행">부산은행</option>
		<option value="농협">농협</option>
		<option value="기업은행">기업은행</option>
		<option value="하나은행">하나은행</option>
		<option value="한국시티은행">한국시티은행</option>
	</select><br>
	<label>계좌 번호</label><input type="text" id="bankaccount" name="bankaccount" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"><br>
	<input type="submit" value="계좌 정보 저장">
	</form>
	</fieldset>
	<hr>
	<form action="./UserDeleteAction.us" method="post">
		<input type="submit" value="회원탈퇴">
	</form>
	</div>
	
</body>
</html>

<%@ include file="../inc/footer.jsp" %>