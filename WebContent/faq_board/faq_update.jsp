<%@page import="com.faq.db.FAQDTO"%>
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
	request.setCharacterEncoding("UTF-8");
	
	FAQDTO fdto = (FAQDTO) request.getAttribute("fdto");
%>

<h3>자주묻는질문</h3> 
	<form action="./FAQUpdateAction.faq" method="post" >
		<input type="hidden" name="faq_idx" value="<%=fdto.getFaq_idx() %>">  
		<table border="1">
	         <tr>
	           <td>카테고리</td>
	           <td>
	             <select name="faq_cate">
	               <option value="etc"
	               	<%if(fdto.getFaq_cate().equals("etc")){ %>
	               		selected
	               	<%} %>
	               	>기타</option>
	               <option value="oper"
	               	<%if(fdto.getFaq_cate().equals("oper")){ %>
	               		selected
	               	<%} %>
	               	>운영정책</option>
	               <option value="uid"
	               	<%if(fdto.getFaq_cate().equals("etcuid")){ %>
	               		selected
	               	<%} %>
	               	>계정/인증</option>
	               <option value="sell"
	               	<%if(fdto.getFaq_cate().equals("sell")){ %>
	               		selected
	               	<%} %>
	               	>구매/판매</option>
	               <option value="proc"
	               	<%if(fdto.getFaq_cate().equals("proc")){ %>
	               		selected
	               	<%} %>
	               	>거래 품목</option>
	             </select>
	           </td>
	         </tr>
	         
	         <tr>
	           <td>제목</td>
	           <td>
	             <input type="text" name="faq_sub" value="<%=fdto.getFaq_sub()%>">
	           </td>           
	         </tr>
	         <tr>
	           <td>내용</td>
	           <td>
	             <input type="text" name="faq_content" value="<%=fdto.getFaq_content()%>">
	           </td>
	         </tr>
	         
	         <tr>
	         	<td>첨부파일</td>
	           <td>
	             <input type="file" name="faq_file">
	           </td>
	         <tr>
	         <tr>
	          <td colspan="2">
	            <input type="submit" value="등록">
	          </td>
	        </tr>
	       </table>     
	
	</form>
	
	

</body>
</html>