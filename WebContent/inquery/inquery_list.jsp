<%@page import="com.inquery.db.InqueryDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
		<h1>WebContent/inquery/inquery_list</h1>
	<%
	 List miList =(List)request.getAttribute("myInqueryList");
	
	%>
	
	<table>
		<tr>
			<td>글 번호</td>
			<td>닉네임</td>
			<td>제목</td>
			<td>날짜</td>
		</tr>
		
		<%
		for(int i=0;i<miList.size();i++){
			InqueryDTO inDTO = (InqueryDTO) miList.get(i);
		%>
		
		<tr>
			<td><%=inDTO.getInq_num() %></td>
			<td><%=inDTO.getUser_nick() %></td>
			<td><a href="./InqueryContent.in?num=<%=inDTO.getInq_num()%>"><%=inDTO.getInq_sub() %></a></td>	
			<td><%=inDTO.getInq_date() %></td>
		</tr>
		<%
		}
		%>
	</table>
	
	
	
	
	
	
	
	
	<a href="./InqueryWrite.in"> 글쓰기</a>
	<hr>
	
	<a href="./FAQ.faq"> FAQ게시판 </a>
	
	
</body>
</html>