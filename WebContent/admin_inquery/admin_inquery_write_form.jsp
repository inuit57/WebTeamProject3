<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>WebContent/admin_inquery/admin_inquery_write_form.jsp</h1>
	<%
	 int num = Integer.parseInt(request.getParameter("num"));
	%>
	
	

	<form action="./InqueryAdminWriteAction.ai" method="post" enctype="multipart/form-data">
		<input type="hidden" name="num" value="<%=num%>">
		글쓴이 : <input type="text" name="name"> <br>
		제목 : <input type="text" name="subject"><br>
		내용 : <textarea rows="10" cols="30" name="content"></textarea><br>
		이미지 : <input type="file" name="img" accept="image/*">
			<hr>
			
			<input type="submit" value="글쓰기"> 
		</form>	
	



</body>
</html>