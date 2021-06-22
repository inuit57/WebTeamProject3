<%@page import="com.prod.db.ProdDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>WebContent/prod_trade/prod_trade_detail.jsp</h1>

<%
	ProdDTO pDTO = (ProdDTO) request.getAttribute("product");
	

%>
	
	
	<form action="#" method="post" name="pfr">
	
		<table border="1">
			<tr>
				<td width="400">
				
				<%
				 String imgfile = pDTO.getProd_img().split(",")[0];
				 if((imgfile == null) || (imgfile.equals("null"))){
					 imgfile = "product_default.jpeg"; 
				 }
				%>
				  	
				<img src="./upload/<%=imgfile%>" width="400" height="400">
					
				</td>
				<td width="400">
					<h4><%=pDTO.getProd_num() %></h4>
					<h2><%=pDTO.getProd_sub() %></h2>
					<h1><%=pDTO.getProd_price() %></h1>
					<h3><%=pDTO.getUser_nick() %></h3>
					<hr>
					 신고하기, 찜 (넣어야 할 기능), 위치 <hr>
					<%
						String category = "";
					
						switch(pDTO.getProd_category()){
							case 0: category="디지털기기"; break;
							case 1: category="생활가전"; break;
							case 2: category="가구/인테리어"; break;
							case 3: category="유아용품"; break;
							case 4: category="생활/가공식품"; break;
							case 5: category="스포츠/레저"; break;
							case 6: category="여성잡화/의류"; break;
							case 7: category="남성잡화/의류"; break;
							case 8: category="게임/취미"; break;
							case 9: category="뷰티/미용"; break;
							case 10: category="반려동물용품"; break;
							case 11: category="도서/티켓/음반"; break;
							case 12: category="식물"; break;
							case 13: category="기타 중고물품"; break;						
						}
					
						String status = "";
						
						switch(pDTO.getProd_status()){
							case 0: status="삽니다"; break;
							case 1: status="팝니다"; break;
							case 2: status="무료나눔"; break;
						}
						
					%>
					<ul>
						<li>카테고리 : <%=category %></li>
						<li>거래여부 : <%=status %></li> 
						<li>조회수 : <%=pDTO.getProd_count() %></li>
						<small><li>작성시간 : <%=pDTO.getProd_date() %></li></small>
					</ul>
					
					<input type="button" value="찜하기">
					<input type="button" value="구매하기">
					<input type="button" value="채팅하기">
					
				</td>
			</tr>
			<tr>
				<td colspan="2" height="400">
					<h1>상세정보</h1>
					<%=pDTO.getProd_content() %>
					
				</td>
			</tr>
		
		</table>
	
		<input type="button" value="수정하기"
				onclick="location.href='./ProductModify.pr?num=<%=pDTO.getProd_num()%>'">
			
		<input type="button" value="삭제하기"
				onclick="location.href='./ProductDeleteAction.pr?num=<%=pDTO.getProd_num()%>'">
		
		
	</form>
	
	
	
	


</body>
</html>