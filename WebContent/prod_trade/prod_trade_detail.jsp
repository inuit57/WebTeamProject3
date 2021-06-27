<%@page import="com.user.db.UserDAO"%>
<%@page import="com.user.db.UserDTO"%>
<%@page import="com.wish.db.WishDTO"%>
<%@page import="com.wish.db.WishDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.prod.db.ProdDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>


<meta charset="UTF-8">
<title>Insert title here</title>
<script src="./jq/jquery-3.6.0.js"></script>

</head>
<body>
	<h1>WebContent/prod_trade/prod_trade_detail.jsp</h1>

	<%
	ProdDTO pDTO = (ProdDTO) request.getAttribute("product");
	String nick = (String)session.getAttribute("user_nick");
	WishDTO wDTO = new WishDTO();
	
	
	WishDAO wDAO = new WishDAO();
	int pageNum = Integer.parseInt(request.getParameter("pageNum").toString());
	
	//int wishCount = (int)request.getAttribute("wishCount");
	
	%>

	<a href="./main.bo">메인</a>
	
	<!-- 신고폼 -->
	
	<form action="./declarationProd.decl" method="post" onsubmit="return confirm('이 글을 신고하시겠습니까?')">
		
		<input type="submit" value="신고하기">
		<input type="hidden" name="prod_num" value="<%=pDTO.getProd_num()%>">
		<!-- 신고 당하는 글 작성자 -->
		<input type="hidden" name="decl_writer" value="<%=pDTO.getUser_nick()%>">
		<input type="hidden" name="board_sub" value="<%=pDTO.getProd_sub()%>">
		<input type="hidden" name="board_type" value="1">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
	
	</form>
	
	<!-- 신고폼 -->
	
	
	
	<form action="#" method="post" name="pfr">
	<input type="hidden" name="nick" value=<%=nick%>>
	
		<table border="1">
			<tr>
				<td width="400">
					 <!-- <img src="./upload/" width="400" height="400"> -->
					<div id="carousel-example-generic" class="carousel slide"
						data-ride="carousel">
						<!-- Indicators -->
						<ol class="carousel-indicators">
							<li data-target="#carousel-example-generic" data-slide-to="0"
								class="active"></li>
							<li data-target="#carousel-example-generic" data-slide-to="1"></li>
							<li data-target="#carousel-example-generic" data-slide-to="2"></li>
						</ol>

						<!-- Wrapper for slides -->
						<div class="carousel-inner" role="listbox">
							<div class="item active">
								<img src="./upload/<%=pDTO.getProd_img().split(",")[0]%>" class="d-block w-100" alt="..."
									style="width: 400px; height: 400px;"> 
									
								<div class="carousel-caption">...</div>
							</div>
			
							<% 
					
							for (int i = 1; i < pDTO.getProd_img().split(",").length ; i++) {
								String imgfile = pDTO.getProd_img().split(",")[i];
								if ((imgfile == null) || (imgfile.equals("null"))) {
									imgfile = "product_default.jpeg";
								}
							%>
							
							<div class="item">
								<img src="./upload/<%=imgfile %>" class="d-block w-100" alt="..."
									style="width: 400px; height: 400px;">
								<div class="carousel-caption">...</div>
							</div>
							<%} %>
						</div>

						<!-- Controls -->
						<a class="left carousel-control" href="#carousel-example-generic"
							role="button" data-slide="prev"> <span
							class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
							<span class="sr-only">Previous</span>
						</a> <a class="right carousel-control"
							href="#carousel-example-generic" role="button" data-slide="next">
							<span class="glyphicon glyphicon-chevron-right"
							aria-hidden="true"></span> <span class="sr-only">Next</span>
						</a>
					</div>
	
				</td>
				<td width="400">
					<h4><%=pDTO.getProd_num()%></h4>
					<h2><%=pDTO.getProd_sub()%></h2>
					<h1><%=pDTO.getProd_price()%></h1>
					<h3><%=pDTO.getUser_nick()%></h3>
					<hr> 신고하기, 찜 (넣어야 할 기능), 위치
					<hr> <%
					 String category = "";
					
					 switch (pDTO.getProd_category()) {
					 case 0:
					 	category = "디지털기기";
					 	break;
					 case 1:
					 	category = "생활가전";
					 	break;
					 case 2:
					 	category = "가구/인테리어";
					 	break;
					 case 3:
					 	category = "유아용품";
					 	break;
					 case 4:
					 	category = "생활/가공식품";
					 	break;
					 case 5:
					 	category = "스포츠/레저";
					 	break;
					 case 6:
					 	category = "여성잡화/의류";
					 	break;
					 case 7:
					 	category = "남성잡화/의류";
					 	break;
					 case 8:
					 	category = "게임/취미";
					 	break;
					 case 9:
					 	category = "뷰티/미용";
					 	break;
					 case 10:
					 	category = "반려동물용품";
					 	break;
					 case 11:
					 	category = "도서/티켓/음반";
					 	break;
					 case 12:
					 	category = "식물";
					 	break;
					 case 13:
					 	category = "기타 중고물품";
					 	break;
					 }
					
					 String status = "";
					
					 switch (pDTO.getProd_status()) {
					 case 0:
					 	status = "삽니다";
					 	break;
					 case 1:
					 	status = "팝니다";
					 	break;
					 case 2:
					 	status = "무료나눔";
					 	break;
					 }
					 %>
										<ul>
						<li>카테고리 : <%=category%></li>
						<li>거래여부 : <%=status%></li>
						<li>조회수 : <%=pDTO.getProd_count() == 0 ? 1 : pDTO.getProd_count()%></li>
						<small><li>작성시간 : <%=pDTO.getProd_date()%></li></small>
					</ul> 
					
					찜 횟수 &nbsp; 
					<c:if test="<%=wDAO.favoriteCheck(pDTO.getProd_num(), nick) == 0%>">
						<span id="favorite"  style="color:red;">♡</span>
					</c:if>
					
					<c:if test="<%=wDAO.favoriteCheck(pDTO.getProd_num(), nick) == 1%>">
						<span id="favorite" style="color:red;">♥</span>
					</c:if>
					<span id="wish__Count"> <%=wDAO.wishCount(pDTO.getProd_num()) %> </span>
					
					
					<!-- 관리자만 사용가능한 메뉴 생성 -->
	
					
					<input type="button" id="btnLike" value="찜하기" class="form-control"> 
					<input type="button" value="구매하기" class="form-control"> 
					<input type="button" value="채팅하기" class="form-control">
					

				</td>
			</tr>
			<tr>
				<td colspan="2" height="400">
					<h1>상세정보</h1> <%=pDTO.getProd_content()%>

				</td>
			</tr>

		</table>

		<input type="button" value="수정하기"
			onclick="location.href='./ProductModify.pr?num=<%=pDTO.getProd_num()%>'">

		<input type="button" value="삭제하기"
			onclick="location.href='./ProductDeleteAction.pr?num=<%=pDTO.getProd_num()%>'">


	</form>



<!--  		if(user_nick == null){
				alert("로그인 후 이용 가능합니다.");
				location.href='./UserLogin.us' 
			} -->
			



</body>

<script type="text/javascript">
	$(document).ready(function(){
		
		var user_nick = document.getElementById("nick");
			
		$(".hide").hide();
		$("#btnLike").click(function(){
			
			
			$.ajax({
				
				url:"favoriteProdAction.fp",
				data:{
					prod_num: <%=pDTO.getProd_num()%>,
					user_nick: '<%=nick%>'
				},
				type:"post",
				datatype: "json",
				success : function(data){
					
					// 찜목록 버튼 눌렀을 때 동작 
					// 기본에 있으니까 빼고 하트 비우는 거.
					if(data.check == 1){
						$("#favorite").text("♡");
						$("#wish__Count").html(data.count);
						//$("wishCount").text(data.count);
						
					}else{
						// 기존에 없으니까 하트 채우기 
						$("#favorite").text("♥");
						//$("wishCount").text("133423");
						$("#wish__Count").html(data.count);
					}
				}

					
				
			})
			
			
		});
		
		
	});




</script>


</html>