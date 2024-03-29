<%@page import="com.prod.db.ProdDAO"%>
<%@page import="com.user.db.UserDAO"%>
<%@page import="com.user.db.UserDTO"%>
<%@page import="com.wish.db.WishDTO"%>
<%@page import="com.wish.db.WishDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="com.prod.db.ProdDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
 <!-- 합쳐지고 최소화된 최신 CSS --> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
 <!-- 부가적인 테마 --> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
 <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>


<meta charset="UTF-8">
<!-- <script src="./jq/jquery-3.6.0.js"></script> -->
<%@ include file="../inc/top.jsp" %>

</head>
<style>
 
table{

border-right:none;
border-left:none;
border-top:none;
border-bottom:none;

}
 #t1{
	
	margin: 10px; padding: 30px

}

#u1{
	padding: 10px;
}


li>a:link, li>a:visited {
color: #59ab6e;

}

#seller:link, #seller:visited {
color: #59ab6e;
}


</style>


<body>
	<%
	ProdDTO pDTO = (ProdDTO) request.getAttribute("product");
	String nick = (String)session.getAttribute("user_nick");
	WishDTO wDTO = new WishDTO();
	WishDAO wDAO = new WishDAO();
	UserDAO uDAO = new UserDAO(); 
	ProdDAO pDAO = new ProdDAO(); 
	
	int pageNum = Integer.parseInt(request.getParameter("pageNum").toString());
	//int wishCount = (int)request.getAttribute("wishCount");
	%>

	<div class="container" >
	<br><br>

	<!-- 신고폼 -->	
	
	
	<div style="margin:auto;  width: 800px; ">
	<button onclick="location.href='./ProductList.pr'"
		class="btn btn-success btn-lg" style="float: left;
									   margin-right: 10px;">목록으로</button>
	<% if(user_nick != null){ %>
	
	<form name="declareForm" action="./declaration_prod.decl" method="post" 
		  onsubmit="return confirm('이 글을 신고하시겠습니까?')"
		  style="float:left;">

		<input type="submit" value="신고하기" class="btn btn-danger" 
			   style="width: 120px; height: 48px;">
		<input type="hidden" name="prod_num" value="<%=pDTO.getProd_num()%>">
		<!-- 신고 당하는 글 작성자 -->
		<input type="hidden" name="decl_writer" value="<%=pDTO.getUser_nickname()%>">
		<input type="hidden" name="board_sub" value="<%=pDTO.getProd_sub()%>">
		<input type="hidden" name="board_type" value="1">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
	</form>
	<%} %>
	</div>
	
<!-- 	<form action="#" method="post" name="pfr"> -->
<%-- 		<input type="hidden" name="nick" value=<%=nick%>> --%>
	
	<div style="margin:auto;  width: 800px; ">	
		<table border="1" class="table" style="height: 500px; frame= void;">

<%
	String[] temp = pDTO.getProd_img().split(",");
	int not_null_cnt =0 ; 
	for(int i = 0 ; i< temp.length ; i++){
		System.out.println(temp[i]); 
		if(!temp[i].equals("null") && temp[i] != null ){
			not_null_cnt++; 
		}
	}
	System.out.println("not null cnt : " +  not_null_cnt);
%>

			<tr>
				<td width="400">
					 <!-- <img src="./upload/" width="400" height="400"> -->
					<div id="carousel-example-generic" class="carousel slide"
						data-ride="carousel">
						<!-- Indicators -->
						<ol class="carousel-indicators">
							<li data-target="#carousel-example-generic" data-slide-to="0"
								class="active"></li>
							<% for(int i =1 ; i < not_null_cnt ; i++){ %>
								<li data-target="#carousel-example-generic" data-slide-to="<%=i%>"></li>
							<%} %>
<!-- 							<li data-target="#carousel-example-generic" data-slide-to="2"></li> -->
<!-- 							<li data-target="#carousel-example-generic" data-slide-to="3"></li> -->
						</ol>

						<!-- Wrapper for slides -->
						<div class="carousel-inner" role="listbox">
							<div class="item active">
							
							<%
							String img0 = pDTO.getProd_img().split(",")[0] ; 
							if ( img0 == null || img0.equals("null")){
								img0 = "product_default.jpg";
							}
							%>
								<img src="./upload/<%=img0%>" class="d-block w-100" alt="..."
									style="width: 400px; height: 400px;"> 
									
								<div class="carousel-caption">...</div>
							</div>
			
							<% 
							if(pDTO.getProd_img().split(",").length > 1){
								for (int i = 1; i < pDTO.getProd_img().split(",").length ; i++) {
									String imgfile = pDTO.getProd_img().split(",")[i];
									if ((imgfile == null) || (imgfile.equals("null"))) {
										imgfile = "product_default.jpg";
									}else{
							%>
										<div class="item">
											<img src="./upload/<%=imgfile %>" class="d-block w-100" alt="..."
												style="width: 400px; height: 400px;">
											<div class="carousel-caption">...</div>
										</div>
							<%
									}
								} //for
							} //if
							%>
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
				<td width="400" id="t1">


<%-- 					<h4>글 번호 : <%=pDTO.getProd_num()%></h4> --%>
					<h1 class="h2"> <%=pDTO.getProd_sub()%></h1>
					<p class="h3 py-2" style="color: #59ab6e;"><fmt:formatNumber value="${product.prod_price}" pattern="#,###,###"/>원</p>
					
					 <ul class="list-inline">
                                <li class="list-inline-item">
                                    <h5>판매자:</h5>
                                </li>
                                <li class="list-inline-item">
                                    <p class="text-muted">
                                    <strong>
										<a id="seller" href="./ProductList.pr?search_type=seller&search_text=<%=pDTO.getUser_nickname()%>"><%=pDTO.getUser_nickname()%></a>
                                    </strong></p>
                                </li>
                            </ul>
					
				<br>
					
			 <%
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
					 case 3:
						 status ="판매완료"; 
						 break;
					 }
					 %>
					 <ul class="list-unstyled pb-3">
                                <li>카테고리 : <a href="./ProductList.pr?item=<%=pDTO.getProd_category()%>"><%=category%></a></li>
                                <li>거래여부 : <%=status%></li>
                                <li>조회수 : <%=pDTO.getProd_count() == 0 ? 1 : pDTO.getProd_count()%></li>
                                <li><h3 style="margin-top: 10px;font-size: 1.0vw; color: #59ab6e;
									float: left"><%=pDAO.timeForToday(pDTO.getProd_num())%></h3></li>
                            </ul>
					
					<br>
					찜 횟수 &nbsp; 
					<c:if test="<%=wDAO.favoriteCheck(pDTO.getProd_num(), nick) == 0%>">
						<span id="favorite"  style="color:red;">♡</span>
					</c:if>
					
					<c:if test="<%=wDAO.favoriteCheck(pDTO.getProd_num(), nick) == 1%>">
						<span id="favorite" style="color:red;">♥</span>
					</c:if>
					<span id="wish__Count"> <%=wDAO.wishCount(pDTO.getProd_num()) %> </span>
					
					<br>
					
					<% if(user_nick != null){ %>

						<% if(!user_nick.equals(pDTO.getUser_nickname())){ %>
							<input type="button" id="btnLike" value="찜하기" 
									class="services-icon-wap btn4321"
									style="float:left; margin-right: 10px;
										   margin-top: 10px;"> 
						<%} %>
						<!-- 채팅하기로 통합  -->
<!-- 						<input type="button" value="구매요청" class="form-control" >  -->
						<form action="" method="post" name="chatform" 
							  style="float:left; margin-top: 10px; width:350px;">
						<input type="hidden" name="prod_num" value="<%=pDTO.getProd_num()%>">
						<input type="hidden" name="user_nick" value="<%=session.getAttribute("user_nick")%>" >
						<input type="hidden" name="seller" value="<%=pDTO.getUser_nickname()%>">
						<input type="button" value="채팅하기" class="services-icon-wap btn4321" onclick="openWindowChat();" >
						</form>
					<%}%>
				</td>
			</tr>
			<tr>
				<td colspan="2" height="400" style="vertical-align: top">
					<h1>상세정보</h1> <%=pDTO.getProd_content()%>
				</td>
			</tr>
		</table>
		<br>
		<div style="margin:auto;  width: 800px; ">
		<% if ( pDTO.getUser_nickname().equals(user_nick) ){ %>
			<input type="button" value="수정하기" class="btn btn-light"
				onclick="location.href='./ProductModify.pr?num=<%=pDTO.getProd_num()%>'">
			<!-- 로직 처리 필요 -->
			<input type="button" value="판매완료" class="btn btn-light"
				onclick="location.href='./ProductSellComplete.pr?num=<%=pDTO.getProd_num()%>' ">
				
		<%}%>

		<% if( pDTO.getUser_nickname().equals(user_nick) || uDAO.isAdmin(user_nick)){   %>
			<input type="button" value="삭제하기" class="btn btn-light"
				onclick="location.href='./ProductDeleteAction.pr?num=<%=pDTO.getProd_num()%>'">
		<%} %>
		</div>
<!-- 	</form> -->
<!--  		if(user_nick == null){
				alert("로그인 후 이용 가능합니다.");
				location.href='./UserLogin.us' 
		
			} -->
			</div>
	</div>
	<br>
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
	function openWindowChat() {
		window.open("","Chat","width=430,height=800,top=150,left=500");
		document.chatform.target = "Chat";
		document.chatform.action = "./ChatAction.ch";
		document.chatform.submit();
	}
</script>

</html>

<%@ include file="../inc/footer.jsp" %>
