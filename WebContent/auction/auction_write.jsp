<%@page import="com.user.db.UserDAO"%>
<%@page import="com.prod.db.ProdDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../inc/top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>auction_write</title>

<script src="./jq/jquery-3.6.0.js"></script>
</head>
<body>

<div class="container" >
<br><br>
<!-- 	<h1>WebContent/prod_trade/prod_trade_write.jsp</h1> -->
	
	<%
	String nick = (String)session.getAttribute("user_nick");

	// 수정 필요
//	if(nick == null){
//		response.sendRedirect("./Login/LoginForm.jsp");
//	}
	

	%>
	<fieldset style="margin:auto;  width: 800px;">
		<legend>경매상품 등록하기</legend>
			<form action="./AuctionRegisterAction.ac" method="post" enctype="multipart/form-data"
				name="pdf">
				<input type="hidden" name="nick" value=<%=nick%>>
				
				<table border="1"   class="table" >
					
					<tr>
						<td>중고거래 여부</td>
						<td>
							<select name="status" required="required" id="auctstatus">
								<option value="0" selected="selected">팝니다</option>
								<option value="1" id="tradeCompl">거래완료</option>
							</select>
						</td>
					</tr>
					<tr> 
						<td>글 제목</td>
						<td id="auctsub">
							<input type="text" name="auct_sub" id="asub" placeholder="제목을 입력하세요." >
						</td>
					</tr>
					<tr> 
						<td>상품 가격</td>
						<td>
							<input type="number" name="auct_price" id="price" placeholder="가격을 입력하세요.">
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
							<textarea rows="30" cols="60" name="auct_content"
								id="acontent"
								placeholder="상품정보를 입력하세요."></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="right">
							<input type="submit" id="auct_save" value="글쓰기">
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
		$("#auct_save").click(function(){
			
			var auct_sub = document.getElementById("asub").value;
			var auct_price = document.getElementById("price").value;
			var auct_content = document.getElementById("acontent").value;
			
			if(auct_sub == ""){
				alert("제목을 입력하세요.");
				return false;
				
			}
			if(auct_price == ""){
				alert("가격을 입력하세요.");
				return false;
			}
			
			if(auct_content == "" || auct_content == null || auct_content == '&nbsp;' || auct_content == '<br>' || auct_content == '<br/>' || auct_content == '<p>&nbsp;</p>'){
				alert("본문을 입력하세요."); 
				
				return false; 
			} 
			
			
			document.fr.submit();
			
		});
	});
	
	$(document).ready(function(){
		$("#auctstatus").on('change',function(){
			
			if(this.value  == 1){
				$("#price").val(0);
				$("#price").attr('readonly',true);
			}else{
				$("#price").val("");
				$("#price").attr('readonly',false);
			}
			
			if(this.value == 1){
				$("#asub").val('판매완료');
				$("#asub").attr('readonly',true);

			}else{
				$("#asub").val("");
				$("#asub").attr('readonly',false);
				
			}
			
			
		});
	
	});
</script>
</html>
<%@ include file="../inc/footer.jsp" %>