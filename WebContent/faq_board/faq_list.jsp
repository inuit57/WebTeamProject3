<%@page import="com.faq.db.FAQDTO"%>
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

 <%
    List faqList = (List) request.getAttribute("faqList");
 
 	FAQDTO fdto = null;
  %>
  
  

	<h3>자주묻는질문</h3> 
	
	<input type="text" name="faq_search" placeholder="검색어를 입력해주세요">
    <input type="button" onclick="faqSearch" id="searchBtn" style="margin-left:-30px;" value="검색"> 
    <br><br>
    <a href="./FAQ.faq">전체 | </a>
    <a href="./FAQ.faq?faq_cate=oper">운영정책 | </a>
    <a href="./FAQ.faq?faq_cate=uid">계정,인증 | </a>
    <a href="./FAQ.faq?faq_cate=sell">구매,판매 | </a>
    <a href="./FAQ.faq?faq_cate=proc">거래 품목 | </a>
	<a href="./FAQ.faq?faq_cate=etc">기타</a>
    <hr>
	<br>
	
	<% 
		for(int i=0; i<faqList.size();i++){
			fdto = (FAQDTO) faqList.get(i);
		%>
		<div>
			<img src="./img/faq_q.png">
			<h2><%=fdto.getFaq_sub() %></h2>
			<br>
			<img src="./img/faq_a.png">
			<h6><%=fdto.getFaq_content() %></h6>
		</div>
		
		<%	
			
		}
	%>
	
	
	<button type="button" onclick="location.href='./FAQAdd.faq'">글쓰기</button>
	
	
</body>
</html>