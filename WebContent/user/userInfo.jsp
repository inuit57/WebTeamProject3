<%@page import="com.user.db.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ include file="../inc/top.jsp" %> --%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="jquery/jquery-3.6.0.js"></script>
<script type="text/javascript" src="./user/userInfoJS/userInfo.js"></script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>

<script type="text/javascript">

function file_upload(){
	$('#img_upload').click();
}
</script>

<link href="css/userInfo.css" rel="stylesheet">
<title>회원 정보</title>
</head>
<body>

	<% 
	//String user_nick = (String)session.getAttribute("user_nick"); 
	
	UserDTO udto = (UserDTO)session.getAttribute("udto"); 
	
	String m = request.getParameter("m");
	
	String user_picture = udto.getUser_picture(); 
	
	%>

	<!-- ------------------------test---------------------------- -->
	<div>
	<div class="container">
		<ul class="tab_title">
			<li class="on">마이페이지</li>
			<li>회원정보 수정</li>
			<li>비밀번호 변경</li>
			<li>계좌정보 변경</li>
			<li>회원 탈퇴</li>
		</ul>
		<div class="tab_cont">
			<div class="on">
					<%
						if (user_picture == null || user_picture.equals("")) {
					%>
					<img alt="" src="./img/default_image.png" id="image">
					<%
						} else {
					%>
					<img alt="" src="./upload/<%=user_picture%>" id="image">
					<%
						}
					%><br>
<!-- 					<label>프로필 사진 변경</label><br><input type="file" name="user_picture"><br> -->
					<table border="1px solid black" >
					<tr>
						<td>아이디</td>
						<td><%=udto.getUser_id()%></td>
					</tr>
					<tr>
						<td>닉네임</td>
						<td><%=udto.getUser_nickname()%></td>
					</tr>
					<tr>
						<td>전화번호</td>
						<td><%=udto.getUser_phone()%></td>
					</tr>
					<tr>
						<td>주소</td>
						<td><%=udto.getUser_address()%></td>
					</tr>
					<tr>
						<td>상세주소</td>
						<td><%=udto.getUser_addressPlus()%></td>
					</tr>
					</table>
				<a href="./MyPageBoardList.bo">내가 쓴 글</a><br>
				<a href="./MyPageProductList.pr">나의 상품</a><br>
				<a href="./MyPageInqueryList.in">나의 문의</a><br>
			</div>
			<div>
				<form action="./UserInfoEditAction.us" method="post" onsubmit="return Infocheck()" enctype="multipart/form-data">
					<label>아이디</label><input type="text" name="user_id"
						readonly="readonly" value="<%=udto.getUser_id()%>"><br>
					<label>닉네임</label><input type="text" id="user_nick"
						name="user_nick" onkeyup="checkNick();"
						value="<%=udto.getUser_nickname()%>"><label
						id="nickname_error" class="error"></label><br> <label>전화번호</label><input
						type="text" id="user_phone" name="user_phone"
						onkeyup="checkPhone()" value="<%=udto.getUser_phone()%>"
						oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"><label
						id="phone_error" class="error"></label>
					<br> <label>주소</label><input type="text" class="address"
						id="user_address" name="user_address" onkeyup="addressCheck();"
						value="<%=udto.getUser_address()%>" readonly="readonly">
					<button id="address_find" onclick="findAddr()">주소 찾기</button>
					<br> <label>상세주소</label><input type="text"
						id="user_address_plus" class="address" name="user_address_plus"
						onkeyup="addressCheck();" value="<%=udto.getUser_addressPlus()%>"><label
						id="address_error" class="error"></label><br>  <label>가입
						날짜</label><input type="text" name="user_join_date"
						value="<%=udto.getUser_joindate()%>" readonly="readonly"><br>
					<!-- 		<input type="button" value="회원정보 수정하기" onclick="aaa();"><label id="infoChange_text"></label><br> -->
					<input type="submit" value="회원정보 수정하기">
				</form>
			</div>
			<div>
				<form action="./UserPasswordEditAction.us" method="post"
					onsubmit="return checkPw()">
					<label>현재 비밀번호</label><input type="password" id="pw" name="pw"><br>
					<label>변경 비밀번호</label><input type="password" id="new_pw"
						name="new_pw"><br> <label>변경 비밀번호 확인</label><input
						type="password" id="new_pw_check" name="new_pw_check"><br>
					<label id="pw_error" class="error"></label><br> <input
						type="submit" value="비밀번호 변경하기">
					<%
						if (m != null) {
							if (m.equals("1")) {

								session.invalidate();
								response.sendRedirect("./Main.do");

							} else if (m.equals("2")) {
					%>
					<label>변경 비밀번호가 틀립니다.</label>
					<%
						} else if (m.equals("3")) {
					%>
					<label>비밀번호가 틀립니다.</label>
					<%
						}
						}
					%>
				</form>
			</div>
			<div>
				<label>은행 이름 :</label><label><%=udto.getUser_bankName()%></label><br>
				<label>계좌 번호 :</label><label><%=udto.getUser_bankAccount()%></label><br>

				<form action="./UserBankChangeAction.us" method="post"
					onsubmit="return check()">
					<select id="bankname" name="bankname">
						<option value="none">은행을 선택 하세요.</option>
						<option value="카카오뱅크">카카오뱅크</option>
						<option value="국민은행">국민은행</option>
						<option value="우리은행">우리은행</option>
						<option value="부산은행">부산은행</option>
						<option value="농협">농협</option>
						<option value="기업은행">기업은행</option>
						<option value="하나은행">하나은행</option>
						<option value="한국시티은행">한국시티은행</option>
					</select><br> <label>계좌 번호</label><input type="text" id="bankaccount"
						name="bankaccount"
						oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"><br>
					<input type="submit" value="계좌 정보 저장">
				</form>
			</div>
			<div>
				<form action="./UserDeleteAction.us" method="post">
					<input type="submit" value="회원탈퇴">
				</form>
			</div>
			</div>
		</div>
	</div>
	<!-- ------------------------test---------------------------- -->


</body>
</html>

<%-- <%@ include file="../inc/footer.jsp" %> --%>