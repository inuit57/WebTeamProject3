<%@page import="com.inquery.db.InqueryDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="./css/admin.css">
<%@ include file="../inc/top.jsp" %>

<title>1:1 문의 내역</title>

<style>

.cont1{
	 width: 85%;
    padding: 20px;
    margin-bottom: 20px;
    float:right;  
    overflow: hidden;
    height: 1000px;
    text-align: center;
}

button{
	clear:both;
	float:right;
}

.cont1 a{
	text-decoration: none;
	color:black;
}

.cont1 a:hover{
	background-color: green;
	color:white;
}



</style>


</head>
<body>	
	
		<h1 style="text-align: center; margin-top:2%;">나의 1:1 문의</h1>
	<%
	 List miList =(List)request.getAttribute("myInqueryList");	
	%>
	<div class="cont1 table-responsive">
	<table class="table table-sm table-hover">
	 <thead class="table-dark">
		<tr>
			<td>글 번호</td>
			<td>닉네임</td>
			<td>제목</td>
			<td>날짜</td>
		</tr>
		</thead>
		<%
		for(int i=0;i<miList.size();i++){
			InqueryDTO inDTO = (InqueryDTO) miList.get(i);
			System.out.println(inDTO.getUser_nickname()+"@@@@@@@@@@@@@@@@");
		%>
		
		<tr>
			<td><%=inDTO.getInq_num() %></td>
			<td><%=inDTO.getUser_nickname() %></td>
			<td><a href="./InqueryContent.in?num=<%=inDTO.getInq_num()%>"><%=inDTO.getInq_sub() %></a></td>	
			<td><%=inDTO.getInq_date() %></td>
		</tr>
		<%
		}
		%>
	</table>

	<button class="btn btn-outline-success" type="button" onclick="location.href='./InqueryWrite.in'">글쓰기</button>
	
	<!-- <a href="./InqueryWrite.in"> 글쓰기</a> -->
	
	
	
	</div>
	
</body>
<div class="footer">
<%@ include file="../inc/footer.jsp" %>
</div>
</html>