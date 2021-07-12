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
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript">
	function imgPreview01(event){
		var reader = new FileReader(); 
		reader.onload = function(event){
			var img = document.getElementById("image01"); 
			img.setAttribute("src" , event.target.result)
		};
		
		reader.readAsDataURL(event.target.files[0]); 
	}

	function imgPreview02(event){
		var reader = new FileReader(); 
		reader.onload = function(event){
			var img = document.getElementById("image02"); 
			img.setAttribute("src" , event.target.result)
		};
		
		reader.readAsDataURL(event.target.files[0]); 
	}
	
	function imgPreview03(event){
		var reader = new FileReader(); 
		reader.onload = function(event){
			var img = document.getElementById("image03"); 
			img.setAttribute("src" , event.target.result)
		};
		
		reader.readAsDataURL(event.target.files[0]); 
	}
	
	function imgPreview04(event){
		var reader = new FileReader(); 
		reader.onload = function(event){
			var img = document.getElementById("image04"); 
			img.setAttribute("src" , event.target.result)
		};
		
		reader.readAsDataURL(event.target.files[0]); 
	}
	
	function fileDrop01(){
		var img = document.getElementById("image01");
		
		$("#file1").val("");
		$("#fileName01").val(""); 
		img.setAttribute("src" , "./upload/product_default.jpeg" );
	}
	
	function fileDrop02(){
		var img = document.getElementById("image02");
		
		$("#file2").val("");
		$("#fileName02").val(""); 
		img.setAttribute("src" , "./upload/product_default.jpeg" );
	}
	
	function fileDrop03(){
		var img = document.getElementById("image03");
		
		$("#file3").val("");
		$("#fileName03").val(""); 
		img.setAttribute("src" , "./upload/product_default.jpeg" );
	}
	
	function fileDrop04(){
		var img = document.getElementById("image04");
		
		$("#file4").val("");
		$("#fileName04").val(""); 
		img.setAttribute("src" , "./upload/product_default.jpeg" );
	}
</script>



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
		
		String[] img_list = new String[4]; 
		
		if(pDTO.getProd_img().split(",").length > 0){
			String imgfile = null ;
			for (int i = 0; i < 4 ; i++) {
				if( i < pDTO.getProd_img().split(",").length){
					imgfile = pDTO.getProd_img().split(",")[i];
				}
				if ((imgfile == null) || (imgfile.equals("null"))) {
					img_list[i] = "product_default.jpg";
				}else{
					img_list[i] = imgfile ; 
				}
			}
		}
		%>		
	<fieldset style="margin:auto;  width: 800px;">
		<legend>중고거래 등록수정하기</legend>
			<form action="ProductModifyAction.pr?num=<%=pDTO.getProd_num() %>" method="post" enctype="multipart/form-data"
				name="pdf">
				<input type="hidden" name="user_nick" value=<%=nick%>>
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
					<!-- 이미지 미리보기 추가하기 -->
					
					<tr> 
						<td>상품 이미지1</td>
						<td>
							<input type="file" id ="file1" name="file1" accept="image/*" onchange="imgPreview01(event)" >
						</td>
					</tr>
					<tr> 
						<td>상품 이미지2</td>
						<td>
							<input type="file" id ="file2" name="file2" accept="image/*" onchange="imgPreview02(event)" >
						</td>
					</tr>
					<tr> 
						<td>상품 이미지3</td>
						<td>
							<input type="file" id ="file3" name="file3" accept="image/*" onchange="imgPreview03(event)" >
						</td>
					</tr>
					<tr> 
						<td>상품 이미지4</td>
						<td>
							<input type="file" id ="file4" name="file4" accept="image/*" onchange="imgPreview04(event)" >
						</td>
					</tr>
					<tr>
						<td colspan="4" > 
							<div id="img_list" style="padding-left: 80px; position: relative;">
								<% for (int i= 0 ; i< 4; i++){ %>
									<img id="image0<%=i+1 %>" src="./upload/<%=img_list[i] %>"  width="150" height="150">
									<input type="hidden" id ="fileName0<%=i+1 %>" name="fileName0<%=i+1 %>" value="<%=img_list[i] %>" >
								<%} %>
								<button style=" position: absolute; top: 0px; left : 210px; "type="button" onclick="fileDrop01()">X</button>
								<button style=" position: absolute; top: 0px; left : 360px; " type="button" onclick="fileDrop02()">X</button>
								<button style=" position: absolute; top: 0px; left : 510px; " type="button" onclick="fileDrop03()">X</button>
								<button style=" position: absolute; top: 0px; left : 670px; " type="button" onclick="fileDrop04()">X</button>
							</div>
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