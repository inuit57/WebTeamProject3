<%@page import="com.inquery.db.InqueryDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>


<%
	InqueryDTO inDTO =(InqueryDTO) request.getAttribute("inDTO");

%>
  
  <table border="1">
			<tr>
				<td>글번호</td>
				<td><%=inDTO.getInq_num()%></td>
				<td>작성일</td>
				<td><%=inDTO.getInq_date()%></td>

			</tr>
			<tr>
				<td>글쓴이</td>
				<td colspan="3"><%=inDTO.getUser_nick()%></td>
			</tr>
			<tr>
				<td>글 제목</td>
				<td colspan="3"><%=inDTO.getInq_sub()%></td>
			</tr>
			<tr>
				<td>이미지</td>
				<td colspan="3">
					<img src="">
				</td>				
			</tr>
		
			<tr>
				<td>글 내용</td>
				<td colspan="3"><%=inDTO.getInq_content() %></td>
			</tr>
			
			
		</table>

<%
	if(!inDTO.getInq_check().equals("1")){
%>

	<a href="./InqueryAdminWriteFormAction.ai?num=<%=inDTO.getInq_num()%>"> 답변달기</a>
<%} %>


</body>
</html>