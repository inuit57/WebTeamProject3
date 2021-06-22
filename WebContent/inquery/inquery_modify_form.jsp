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
	<h1>WebContent/inquery/inquery_modify_form.jsp</h1>

<%
	InqueryDTO inDTO = (InqueryDTO) request.getAttribute("inDTO");
	
%>




	<form action="./InqueryModify.in" method="post" enctype="multipart/form-data">
		글 번호 : <input type="text" name="num" value="<%=inDTO.getInq_num() %>" readonly><br>
		글쓴이 : <input type="text" name="name" value="<%=inDTO.getUser_nick() %>" readonly> <br>
		제목 : <input type="text" name="subject" value="<%=inDTO.getInq_sub()%>"><br>
		내용 : <textarea rows="10" cols="30" name="content"><%=inDTO.getInq_content() %></textarea><br>
		이미지 : <input type="file" name="img" accept="image/*">
			<hr>
			
			<input type="submit" value="수정하기"> 
		</form>	
	



</body>
</html>