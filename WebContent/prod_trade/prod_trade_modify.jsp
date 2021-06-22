<%@page import="com.prod.db.ProdDAO"%>
<%@page import="java.security.cert.PKIXRevocationChecker.Option"%>
<%@page import="com.prod.db.ProdDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>prod_trade_write</title>

</head>
<body>
	<h1>WebContent/prod_trade/prod_trade_modify.jsp</h1>
	
		<%
		int num = Integer.parseInt(request.getParameter("num"));
		ProdDAO pDAO = new ProdDAO();
		ProdDTO pDTO = pDAO.getProduct(num);
		%>
	
	<fieldset>
		<legend>중고거래 등록수정하기</legend>
			<form action="ProductModifyAction.pr?num=<%=pDTO.getProd_num() %>" method="post" enctype="multipart/form-data">
				<table border="1">
				<!-- switch문으로 작성 -->
					<tr>
						<td>카테고리</td>
						<td>
							<select name="category">
								<option value="0"
								<% if(pDTO.getProd_category() == 0){ %>
									selected
									<%} %>
								>디지털기기</option>
								<option value="1"
								<% if(pDTO.getProd_category() == 1){ %>
									selected
									<%} %>
								>생활가전</option>
								<option value="2"
								<% if(pDTO.getProd_category() == 2){ %>
									selected
									<%} %>
								>가구/인테리어</option>
								<option value="3"
								
								<% if(pDTO.getProd_category() == 3){ %>
									selected
									<%} %>
								>유아용품</option>
								<option value="4"
								<% if(pDTO.getProd_category() == 3){ %>
									selected
									<%} %>
								>생활/가공식품</option>
								<option value="5"
								<% if(pDTO.getProd_category() == 4){ %>
									selected
									<%} %>
								>스포츠/레저</option>
								<option value="6"
								<% if(pDTO.getProd_category() == 5){ %>
									selected
									<%} %>
								>여성잡화/의류</option>
								<option value="7"
								<% if(pDTO.getProd_category() == 6){ %>
									selected
									<%} %>
								>남성잡화/의류</option>
								<option value="8"
								<% if(pDTO.getProd_category() == 7){ %>
									selected
									<%} %>
								>게임/취미</option>
								<option value="9"
								<% if(pDTO.getProd_category() == 8){ %>
									selected
									<%} %>
								>뷰티/미용</option>
								<option value="10"
								<% if(pDTO.getProd_category() == 9){ %>
									selected
									<%} %>
								>반려동물용품</option>
								<option value="11"
								<% if(pDTO.getProd_category() == 10){ %>
									selected
									<%} %>
								>도서/티켓/음반</option>
								<option value="12"
								<% if(pDTO.getProd_category() == 11){ %>
									selected
									<%} %>
								>식물</option>
								<option value="13"
								<% if(pDTO.getProd_category() == 12){ %>
									selected
									<%} %>
								>기타 중고물품</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<td>중고거래 여부</td>
						<td>
							<select name="status">
								<option value="0"
								<% if(pDTO.getProd_status() == 0){ %>
									selected
									<%} %>
								>삽니다</option>
								<option value="1"
								<% if(pDTO.getProd_status() == 0){ %>
									selected
									<%} %>
								>팝니다</option>
								<option value="2"
								<% if(pDTO.getProd_status() == 0){ %>
									selected
									<%} %>
								>무료나눔</option>
							</select>
						</td>
					</tr>
					<tr> 
						<td>작성자</td> <!-- 회원테이블에서 불러옴 -->
						<td>
							<input type="text" name="nick" value=<%=pDTO.getUser_nick() %>>
						</td>
					</tr>
					<tr> 
						<td>글 제목</td>
						<td>
							<input type="text" name="subject" value=<%=pDTO.getProd_sub() %>>
						</td>
					</tr>
					<tr> 
						<td>상품 가격</td>
						<td>
							<input type="number" name="price" value=<%=pDTO.getProd_price() %>>
						</td>
					</tr>
					<tr> 
						<td>상품 이미지1</td>
						<td>
							<input type="file" name="file1" accept="image/*">
						</td>
					</tr>
					<tr> 
						<td>상품 이미지2</td>
						<td>
							<input type="file" name="file2">
						</td>
					</tr>
					<tr> 
						<td>상품 이미지3</td>
						<td>
							<input type="file" name="file3">
						</td>
					</tr>
					<tr> 
						<td>상품 이미지4</td>
						<td>
							<input type="file" name="file4">
						</td>
					</tr>
					<tr> 
						<td>글 내용</td>
						<td>
							<textarea rows="30" cols="60" name="content" ></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="submit" value="수정하기">
							<input type="reset" value="초기화">
						</td>
					</tr>
					
				</table>
			</form>
	</fieldset>
	
	
	
</body>
</html>