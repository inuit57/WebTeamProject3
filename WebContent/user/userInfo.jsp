<%@page import="com.user.db.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% UserDTO udto = (UserDTO)session.getAttribute("udto"); 
	
	String m = request.getParameter("m");
	
	%>
	<h3>마이 페이지</h3>
	<fieldset>
	<legend>회원 정보</legend>
	<form action="./UserInfoEditAction.us" method="post">
	<label>아이디</label><input type="text" name="user_id" readonly="readonly" value="<%=udto.getUser_id()%>"><br>
	<label>전화번호</label><input type="text" name="user_phone" value="<%=udto.getUser_phone() %>" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"><br>
	<label>주소</label><input type="text" name="user_address" value="<%=udto.getUser_address()%>"><br>
	<label>상세주소</label><input type="text" name="user_address_plus" value="<%=udto.getUser_addressPlus()%>"><br>
	<label>프로필 사진</label><input type="text" name="user_picture" value="<%=udto.getUser_picture()%>"><br>
	<label>가입 날짜</label><input type="text" name="user_join_date" value="<%=udto.getUser_joindate()%>" readonly="readonly"><br>
	<input type="submit" value="회원정보 변경">
	</form>
	</fieldset>
	<hr>
	<fieldset>
	<legend>비밀번호 변경</legend>
	<form action="./UserPasswordEditAction.us" method="post">
	<label>현재 비밀번호</label><input type="password" name="pw"><br>
	<label>변경 비밀번호</label><input type="password" name="new_pw"><br>
	<label>변경 비밀번호 확인</label><input type="password" name="new_pw_check"><br>
	<input type="submit" value="비밀번호 변경">
	
	
	<%
	if(m != null) {
		if(m.equals("1")) {
			
			session.invalidate();
			response.sendRedirect("./Main.do");
			
		} else if(m.equals("2")) {
			%>
			<label>변경 비밀번호가 틀립니다.</label>
			<%
		} else if(m.equals("3")) {
			%>
			<label>비밀번호가 틀립니다.</label>
			<%
		}
	}
	
	%>
	</form>
	</fieldset>
	<form action="./UserDeleteAction.us" method="post">
	<input type="submit" value="회원탈퇴">
	</form>
	<a href="./MyPageBoardList.bo">내가 쓴 글</a><br>
	<a href="./MyPageProductList.pr">나의 상품</a><br>
	<a href="./MyPageInqueryList.in">나의 문의</a><br>
	
</body>
</html>