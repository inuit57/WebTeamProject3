<%@page import="com.prod.db.ProdDTO"%>
<%@page import="com.wish.db.WishDTO"%>
<%@page import="com.prod.db.ProdDAO"%>
<%@page import="com.wish.db.WishDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../inc/top.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style>
  table {
    width: 100%;
    border: 1px solid #444444;
    text-align: center;
  }
  th, td {
    border: 1px solid #444444;
  }
</style>

</head>
<body>


<%
	String nick = (String) session.getAttribute("user_nick"); 	

	WishDAO wDAO = new WishDAO(); 
	List<WishDTO> wishList = (List<WishDTO>)request.getAttribute("wList"); 
	
	ProdDAO pDAO = new ProdDAO(); 
	ProdDTO pDTO ; 
%>

<!-- <h1> 나의 찜목록 </h1> -->
<div class="container">
<div style="margin:auto;  width: 800px; ">
<table border="1"  >
	<tr>
		<th>상품사진</th>
		<th>글제목</th>
		<th>판매자</th>
		<th>가격</th>
		<th>찜목록시간</th>
<!-- 		<th>선택</th> -->
	</tr>
	<% for(int i = 0 ; i< wishList.size() ; i++){ 
		pDTO = (ProdDTO)pDAO.getProduct(wishList.get(i).getProd_num());
		
		 String imgfile = pDTO.getProd_img().split(",")[0];
		 
		 if((imgfile == null) || (imgfile.equals("null"))){
			 imgfile = "product_default.jpg"; 
		 }
	%>	
	<tr>
		<td>
		<img src="./upload/<%=imgfile%>"
					 width="150" height="150">
		</td>
		<td><%=pDTO.getProd_sub() %></td> <!--  글 제목 -->
		<td><%=pDTO.getUser_nickname() %></td> <!--  글 작성자 -->
		<td><%=pDTO.getProd_price() %>원 </td> <!--  가격 -->
		<td><%=wishList.get(i).getWish_date() %></td> <!--  찜한 시간 -->
 	</tr>
	<%} %>
</table>
</div>
</div>

</body>
</html>
<%@ include file="../inc/footer.jsp" %>