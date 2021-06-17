<%@page import="com.prod.db.ProdDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>prod_trade_list.jsp</title>
</head>
<body>

<h1>WenContent/prod_trade/prod_trade_list.jsp</h1>


<%
	List productList = (List) request.getAttribute("productList");


%>

		<select onchange="if(this.value) location.href=(this.value);" name="category">
					<option value="./ProductList.pr">선택하기</option>
					<option value="./ProductList.pr">전체</option>
					<option value="./ProductList.pr?item=0">디지털기기</option>
					<option value="./ProductList.pr?item=1">생활가전</option>
					<option value="./ProductList.pr?item=2">가구/인테리어</option>
					<option value="./ProductList.pr?item=3">유아용품</option>
					<option value="./ProductList.pr?item=4">생활/가공식품</option>
					<option value="./ProductList.pr?item=5">스포츠/레저</option>
					<option value="./ProductList.pr?item=6">여성잡화/의류</option>
					<option value="./ProductList.pr?item=7">남성잡화/의류</option>
					<option value="./ProductList.pr?item=8">게임/취미</option>
					<option value="./ProductList.pr?item=9">뷰티/미용</option>
					<option value="./ProductList.pr?item=10">반려동물용품</option>
					<option value="./ProductList.pr?item=11">도서/티켓/음반</option>
					<option value="./ProductList.pr?item=12">식물</option>
					<option value="./ProductList.pr?item=13">기타 중고물품</option>
			</select>

	<table border="1">
	
		<%
			int size = productList.size();	
			int col = 5;
			int row = (size/col)+((size%col>0)? 1:0);
			int num = 0;
		
			for(int i=0;i<row;i++){
		%>	
		<!-- 
		<tr>
			<td>
			 업로드 경로검색
			 getServletContext().getRealPath("upload")
				 /Users/hong_j/eclipse-workspace/workspace_jsp/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/WebTeamProject/upload 
			</td>
		</tr>
		-->
		<tr>
			<% for(int j=0;j<col;j++){ 
				ProdDTO pDTO = (ProdDTO)productList.get(num);%>
			<td>
				<%
				 String imgfile = pDTO.getProd_img().split(",")[0];
				 if((imgfile == null) || (imgfile.equals("null"))){
					 imgfile = "product_default.jpeg"; 
				 }
				%>
			
				<img src="./upload/<%=imgfile%>"
					 width="150" height="150"><br>
					 <a href="./ProductDetail.pr"><%=pDTO.getProd_sub() %></a><br>
					 <%=pDTO.getProd_price() %>
			
			</td>
		<%
			num++;
		if (size<=num) break;
		
			} %>
		</tr>
		<% }%>
	</table>
		


</body>
</html>