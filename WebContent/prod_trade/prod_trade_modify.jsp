<%@page import="com.prod.db.ProdDAO"%>
<%@page import="java.security.cert.PKIXRevocationChecker.Option"%>
<%@page import="com.prod.db.ProdDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../inc/top.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>prod_trade_write</title>
<script src="./jq/jquery-3.6.0.js"></script>
</head>
<body>
<!-- 	<h1>WebContent/prod_trade/prod_trade_modify.jsp</h1> -->
	
	<div class="container" >
	<br><br>
		<%
		String nick = (String)session.getAttribute("user_nick");
		int num = Integer.parseInt(request.getParameter("num"));
		ProdDAO pDAO = new ProdDAO();
		ProdDTO pDTO = pDAO.getProduct(num);
		%>
	<fieldset style="margin:auto;  width: 800px;">
		<legend>중고거래 등록수정하기</legend>
			<form action="ProductModifyAction.pr?num=<%=pDTO.getProd_num() %>" method="post" enctype="multipart/form-data"
				name="pdf">
				<input type="hidden" name="nick" value=<%=nick%>>
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
							<select name="status" required="required" id="statusFree">
								<option value="0"
								<% if(pDTO.getProd_status() == 0){ %>
									selected
									<%} %>
								>삽니다</option>
								<option value="1"
								<% if(pDTO.getProd_status() == 1){ %>
									selected
									<%} %>
								>팝니다</option>
								<option value="2" id="free"
								<% if(pDTO.getProd_status() == 2){ %>
									selected
									<%} %>
								>무료나눔</option>
								<option value="3" id="tradeCompl"
								<% if(pDTO.getProd_status() == 3){ %>
									selected
									<%} %>
								>거래완료</option>
							</select>
						</td>
					</tr>
					<tr> 
						<td>글 제목</td>
						<td>
							<input type="text" name="prod_sub" id="psub" value=<%=pDTO.getProd_sub() %>>
						</td>
					</tr>
					<tr> 
						<td>상품 가격</td>
						<td>
							<input type="number" name="prod_price" id="price" value=<%=pDTO.getProd_price() %>>
						</td>
					</tr>
					<tr> 
						<td>상품 이미지1</td>
						<td>
							<input type="file" name="file1" accept="image/*" 
							value="<%= (pDTO.getProd_img()==null) ? "" : pDTO.getProd_img() %>">
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
							<textarea rows="30" cols="60" name="content" name="prod_content"
								id="pcontent"><%=pDTO.getProd_content() %></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="submit" id="prod_update" value="수정하기">
							<input type="reset" value="초기화">
						</td>
					</tr>
				</table>
			</form>
	</fieldset>
</div>	
</body>

<script type="text/javascript">
	
	$(function(){
		$("#prod_update").click(function(){
			
			var prod_sub = document.getElementById("psub").value;
			var prod_price = document.getElementById("price").value;
			var prod_content = document.getElementById("pcontent").value;
			
			if(prod_sub == ""){
				alert("제목을 입력하세요.");
				return false;
				
			}
			if(prod_price == ""){
				alert("가격을 입력하세요.");
				return false;
			}
			
			if(prod_content == "" || prod_content == null || prod_content == '&nbsp;' || prod_content == '<br>' || content == '<br/>' || prod_content == '<p>&nbsp;</p>'){
				alert("본문을 입력하세요."); 
				
				return false; 
			} 
			document.fr.submit();
		});
	});
	$(document).ready(function(){
		$("#statusFree").on('change',function(){
			if(this.value  == 2 || this.value == 3){
				$("#price").val(0);
				$("#price").attr('readonly',true);
			}else{
				$("#price").val("");
				$("#price").attr('readonly',false);
			}
			if(this.value == 3){
				$("#psub").val('판매완료');
				$("#psub").attr('readonly',true);
				
			}else{
				$("#psub").val("");
				$("#psub").attr('readonly',false);
			}
		});
	});
</script>
</html>