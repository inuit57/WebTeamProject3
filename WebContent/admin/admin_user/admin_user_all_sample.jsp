<%@page import="com.user.db.UserDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="./assets/css/bootstrap.min.css">
<style>
    

.table td{
	font-size:18px;
	margin: 0;
}

.table a{
	text-decoration: none;
	color: black;
	transition: all 0.5s;
}

.table a:hover{
	color:white;
	background-color: green;
}
    
</style>

</head>
<body>
<%
	List auList = (List)request.getAttribute("auList");		
	
%>

	<h2 style="text-align: center;"> 회원 정보 관리</h2>


	<div class="ad-content1 innerContent table-responsive user">
	


		<table class="table table-sm table-hover" border="1"  style="text-align: center;">
		<thead class="table-dark">
				<tr>					
					<td>닉네임</td>
					<td>아이디</td>
					<td>가입날짜</td>
					<td>코인</td>
					<td>연락처</td>			
					<td>회원/관리자</td>
					<td>회원등급</td>
					<td>탈퇴여부</td>
					
				</tr>
		</thead>

<%
for(int i=0;i<auList.size();i++){
	UserDTO uDTO = (UserDTO)auList.get(i);

%>
<tr>

<td><%=uDTO.getUser_nickname() %></td>
<td><%=uDTO.getUser_id() %></td>
<td><%=uDTO.getUser_joindate() %></td>
<td><%=uDTO.getUser_coin() %></td>
<td><%=uDTO.getUser_phone() %></td>


<%
if(uDTO.getUser_auth()==2){
%>
<td>관리자 </td>
<%
}else{
%>
<td>회원 </td>
<%
}
%>
<td><%=uDTO.getUser_grade() %></td>

<%
if(uDTO.getUser_use_yn()==1){
%>
<td>활성화</td>
<%
}else{
%>
<td>비활성화(탈퇴)</td>
<%
} 
%>

</tr>
<%
}
%>

</table>
</div>
</body>

</html>