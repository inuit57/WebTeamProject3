<%@page import="com.declaration.db.declarationDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>신고목록 게시판</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
</head>
<body>
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/> 
<!-- 헤더파일들어가는 곳 -->
<div align="center" style="margin-top: 2%; margin-bottom: 2%">	
	<input type="button" class="btn btn-light" value="상품게시판 신고목록 보기" onclick="location.href='decl_prod_list.decl?state=0'">
	<input type="button" class="btn btn-light" value="일반게시판 신고목록 보기" onclick="location.href='decl_normal_list.decl?state=0'">
</div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/footer.jsp"/> 
<!-- 푸터 들어가는 곳 -->		
</body>
</html>