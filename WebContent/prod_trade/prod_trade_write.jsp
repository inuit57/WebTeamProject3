<%@page import="com.prod.db.ProdDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>prod_trade_write</title>

<script src="./jq/jquery-3.6.0.js"></script>
</head>
<body>
	<h1>WebContent/prod_trade/prod_trade_write.jsp</h1>
	
	
	<fieldset>
		<legend>중고거래 등록하기</legend>
			<form action="./ProductRegisterAction.pr" method="post" enctype="multipart/form-data"
				name="pdf">
				<table border="1">
				<!-- switch문으로 작성 -->
					<tr>
						<td>카테고리</td>
						<td>
							<select name="category" required="required">
								<option value="0">디지털기기</option>
								<option value="1">생활가전</option>
								<option value="2">가구/인테리어</option>
								<option value="3">유아용품</option>
								<option value="4">생활/가공식품</option>
								<option value="5">스포츠/레저</option>
								<option value="6">여성잡화/의류</option>
								<option value="7">남성잡화/의류</option>
								<option value="8">게임/취미</option>
								<option value="9">뷰티/미용</option>
								<option value="10">반려동물용품</option>
								<option value="11">도서/티켓/음반</option>
								<option value="12">식물</option>
								<option value="13">기타 중고물품</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<td>중고거래 여부</td>
						<td>
							<select name="status" required="required">
								<option value="0">삽니다</option>
								<option value="1">팝니다</option>
								<option value="2" id="free">무료나눔</option>
							</select>
						</td>
					</tr>
					<tr> 
						<td>작성자</td> <!-- 회원테이블에서 불러옴 -->
						<td>
							<input type="text" name="nick" placeholder="작성자를 입력하세요.">
						</td>
					</tr>
					<tr> 
						<td>글 제목</td>
						<td id="pdsub">
							<input type="text" name="prod_sub" id="psub" placeholder="제목을 입력하세요." >
						</td>
					</tr>
					<tr> 
						<td>상품 가격</td>
						<td>
							<input type="number" name="prod_price" id="price" placeholder="가격을 입력하세요." required="required">
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
							<textarea rows="30" cols="60" name="prod_content"
								id="pcontent"
								placeholder="상품정보를 입력하세요."></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="submit" id="prod_save" value="글쓰기">
							<input type="reset" value="초기화">
						</td>
					</tr>
					
				</table>
			</form>
	</fieldset>
	
</body>

<script type="text/javascript">
	
	$(function(){
		$("#prod_save").click(function(){
			
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
</script>
</html>