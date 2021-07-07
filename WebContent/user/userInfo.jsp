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

<link rel="stylesheet" href="./assets/css/bootstrap.min.css">

<script type="text/javascript">

function file_upload(){
	$('#img_upload').click();
}

function imgPreview(event){
	var reader = new FileReader(); 
	reader.onload = function(event){
		var img = document.getElementById("image2"); 
		img.setAttribute("src" , event.target.result)
	};

	reader.readAsDataURL(event.target.files[0]); 
}

function myBoard(){
	self.close();
	window.opener.location.href="./MyPageBoardList.bo";
}

function myProduct(){
	self.close();
	window.opener.location.href="./MyPageProductList.pr";
}

function myInquery(){
	self.close();
	window.opener.location.href="./MyPageInqueryList.in";
}

function myWish(){
	self.close();
	// 찜목록 페이지로 이동되는 동작 추가 필요 
	window.opener.location.href="./favoriteListAction.fp";
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
	
	String onClose = request.getParameter("onClose");
	
	if("1".equals(onClose)){
	%>
	<script type="text/javascript">
		self.close(); 
	</script>
	<%} %>
	<!-- ------------------------test---------------------------- -->
	<div class="container">
		<br><br>
		<ul class="tab_title">
			<li class="on">마이페이지</li>
			<li>회원정보 수정</li>
			<li>비밀번호 변경</li>
			<li>계좌정보 변경</li>
			<li>회원 탈퇴</li>
		</ul>
		
		<div class="tab_cont" >
			
			<div class="on" >
		
					<%
						if (user_picture == null || user_picture.equals("")) {
					%>
					<img alt="" src="./img/default_image.png" id="image" style="margin-top: 30px;">
					<%
						} else {
					%>
					<img alt="" src="./upload/<%=user_picture%>" id="image" style="margin-top: 30px;">
					<%
						}
					%><br><br>
<!-- 					<label>프로필 사진 변경</label><br><input type="file" name="user_picture"><br> -->

<!-- 마이페이지 탭 -->
					<table class="table" >
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
						<% 
						if(udto.getUser_address()==null){
						%>
						<td></td>
						<%
						}else{
						%>
						<td><%=udto.getUser_address()%></td>
						<%
						}
						%>
					</tr>
					<tr>
						<td>상세주소</td>
						<%if(udto.getUser_addressPlus()==null){ %>
						<td></td>
						<%
						}else{
						%>
						<td><%=udto.getUser_addressPlus()%></td>
						<%
						}
						%>
					</tr>

				</table>
					
				<button type="button" onclick="myBoard()" class="btn btn-outline-success" style="margin-right: 30px;">내가 쓴글 </button>
				<button type="button" onclick="myProduct()" class="btn btn-outline-success" style="margin-right: 30px;">나의 상품</button>
				<button type="button" onclick="myInquery()" class="btn btn-outline-success" style="margin-right: 30px;">나의 문의</button>

			</div>
			
			<!-- 회원정보 수정 -->
			<div>
					<%
						if (user_picture == null || user_picture.equals("")) {
					%>
					<img alt="" src="./img/default_image.png" id="image2" onclick="file_upload()" style="width: 150px;height: 150px;border: 5px solid #59AB6E;">
					<%
						} else {
					%>
					<img alt="" src="./upload/<%=user_picture%>" id="image2" onclick="file_upload()" style="width: 150px;height: 150px;	border: 5px solid #59AB6E;">
					<%
						}
					%><br>
					<button id="img_edit_btn" style=" position: absolute; top: 40px; left : 350px;" onclick="file_upload()">수정</button>
					
					
				<form action="./UserInfoEditAction.us" method="post" onsubmit="return Infocheck()" enctype="multipart/form-data">
					<input type="file" id="img_upload" style="display:none;" accept="image/*" name="user_picture" onchange="imgPreview(event)" >
					<br>
				
						
						
					<input type="text" class="form-control" name="user_id" value="<%=udto.getUser_id()%>" readonly> 
					
						<input type="text" class="form-control" id="user_nick" name="user_nick" 
						value="<%=udto.getUser_nickname()%>" onkeyup="checkNick();" > 
						
						<label id="nickname_error" class="error"></label><br> 
						<input type="text" class="form-control" id="user_phone" name="user_phone" 
						onkeyup="checkPhone()" value="<%=udto.getUser_phone()%>"
						oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"> 
						
						<label id="phone_error" class="error"></label>
					<br> 
						
						<%
						if(udto.getUser_address()==null){
						%>
						
					<input type="text" class="form-control address" name="user_address" onkeyup="addressCheck();"
						id="user_address" value="주소" readonly style="display: inline-block;"> 
						
						<% 
						}else{
						%>
					<input type="text" class="form-control address" name="user_address" onkeyup="addressCheck();"
						id="user_address" value="<%=udto.getUser_address()%>" readonly style="display: inline-block;"> 
						<%
						} 
						%>
				
						<%
						if(udto.getUser_addressPlus()==null){
						%>		
					 	
						<input type="text"
						id="user_address_plus" class="form-control address" name="user_address_plus"
						onkeyup="addressCheck();" value="상세주소"  style="display: inline-block;">
						<% 
						}else{
						%>					 	
						<input type="text"
						id="user_address_plus" class="form-control address" name="user_address_plus"
						onkeyup="addressCheck();" value="<%=udto.getUser_addressPlus()%>"  style="display: inline-block;">
						<%
						}
						%>	<br>					
						<label id="address_error" class="error"></label> <br>
										
					<button id="address_find" onclick="findAddr()" class="btn btn-outline-success">주소 찾기</button><br><br>
						<input type="text" name="user_join_date" class="form-control"
						value="<%=udto.getUser_joindate()%>" readonly="readonly"><br>
					<!-- 		<input type="button" value="회원정보 수정하기" onclick="aaa();"><label id="infoChange_text"></label><br> -->
					<input type="submit" class="btn btn-outline-success" value="회원정보 수정 하기">
				</form>
			</div>
			<div>
			<br><br>
			
			<!-- 비밀번호 변경 탭 -->
			
				<form action="./UserPasswordEditAction.us" method="post"
					onsubmit="return checkPw()">
					
					<input type="password" class="form-control password"  id="pw" name="pw" placeholder="현재 비밀번호 입력">
					<input type="password" class="form-control password"  id="new_pw" name="new_pw" placeholder="변경할 비밀번호 입력">
					<input type="password" class="form-control password"  id="new_pw_check" name="new_pw_check" placeholder="변경할 비밀번호 확인">
					<label id="pw_error" class="error"></label><br> 
					<input class="btn btn-outline-success" type="submit" value="비밀번호 변경하기">

					
			
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
			
			
			<!-- 은행계좌 변경 탭 -->
			
			<div>
				<br>
				<%if(udto.getUser_bankName()==null){ %>				
				<input type="text" class="form-control password bank"  id="bankname" name="bankname" value="은행명" readonly>
				<%}else{ %>
				<input type="text" class="form-control password bank"  id="bankname" name="bankname" value="<%=udto.getUser_bankName()%>" readonly>
				<%} %>
				<%if(udto.getUser_bankAccount()==null){ %>
				<input type="text" class="form-control password bank"  id="banknumber" name="banknumber" value="계좌번호" readonly>
				<%}else{ %>
				<input type="text" class="form-control password bank"  id="banknumber" name="banknumber" value="<%=udto.getUser_bankAccount()%>" readonly>
				<%} %>
				<form action="./UserBankChangeAction.us" method="post"
					onsubmit="return check()">
					<select class="form-select bank" id="bankname" name="bankname">
						<option value="none">은행을 선택 하세요.</option>
						<option value="카카오뱅크">카카오뱅크</option>
						<option value="국민은행">국민은행</option>
						<option value="우리은행">우리은행</option>
						<option value="부산은행">부산은행</option>
						<option value="농협">농협</option>
						<option value="기업은행">기업은행</option>
						<option value="하나은행">하나은행</option>
						<option value="한국시티은행">한국시티은행</option>
						</select><br> 
						
				<input type="text" class="form-control password bank"  id="bankaccount" name="bankaccount" 
					 oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" placeholder="계좌번호를 입력하세요">
										
				<input class="btn btn-outline-success" type="submit" value="계좌 정보 저장">					
				</form>
			</div>
			<div>
			<br><br>
			
			
			<!-- 회원 탈퇴 탭 -->
				
				<button type="button" class="btn btn-outline-danger" onclick="deleteUser();">회원탈퇴 </button>
				
			</div>
			</div>
		</div>
	<!-- ------------------------test---------------------------- -->


</body>
</html>

<%-- <%@ include file="../inc/footer.jsp" %> --%>