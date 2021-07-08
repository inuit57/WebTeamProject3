<%@page import="com.auction.bid.db.bidDTO"%>
<%@page import="com.auction.bid.db.bidDAO"%>
<%@page import="com.auction.db.AuctionDTO"%>
<%@page import="com.user.db.UserDAO"%>
<%@page import="com.user.db.UserDTO"%>
<%@page import="com.wish.db.WishDTO"%>
<%@page import="com.wish.db.WishDAO"%>
<%@page import="com.prod.db.ProdDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
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
<!-- s<title>auction_detail.jsp</title> --> 
<%@ include file="../inc/top.jsp" %>
</head>

<style>
* {
	margin: 0;
	padding: 0;
}

a.button {
	display: inline-block;
	padding: 10px 20px;
	text-decoration: none;
	color: #fff;
	background: #000;
	margin: 20px;
}

#modal {
	display: none;
	position: fixed;
	width: 100%;
	height: 100%;
	top: 0;
	left: 0;
	background: rgba(0, 0, 0, 0.3);
}

.modal-con {
	display: none;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	max-width: 60%;
	min-height: 30%;
	background: #fff;
}

.modal-con .title {
	font-size: 20px;
	padding: 20px;
}

.modal-con .con {
	font-size: 15px;
	line-height: 1.3;
	padding: 30px;
}

.modal-con .close {
	display: block;
	position: absolute;
	width: 30px;
	height: 30px;
	border-radius: 50%;
	border: 3px solid #000;
	text-align: center;
	line-height: 30px;
	text-decoration: none;
	color: #000;
	font-size: 20px;
	font-weight: bold;
	right: 10px;
	top: 10px;
}

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



</style>
<body>

	<%
	AuctionDTO aDTO = (AuctionDTO)request.getAttribute("Auction");
	
	
	int pageNum = Integer.parseInt(request.getParameter("pageNum").toString());
	
	bidDAO bDAO = new bidDAO(); 
	bidDTO bDTO = new bidDTO();
	UserDAO uDAO = new UserDAO();
	
	%>
	
	
<script>

	function openModal(modalname) {
		
		document.get
		$("#modal").fadeIn(300);
		$("." + modalname).fadeIn(300);
	}
	
	
	function closeModal(modalname){
	
		document.get
		$("#modal").fadeOut(300);
		$("." + modalname).fadeOut(300);
	}
	
	
</script>
	<div class="container" >
	
		<div style="margin:auto;  width: 800px; ">	
		<table border="1" class="table" style="height: 500px; frame= void;">
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
							
							<%
							String img0 = aDTO.getAuct_img().split(",")[0] ; 
							if ( img0 == null || img0.equals("null")){
								img0 = "product_default.jpg";
							}
							%>
								<img src="./upload/<%=img0%>" class="d-block w-100" alt="..."
									style="width: 400px; height: 400px;"> 
									
								<div class="carousel-caption">...</div>
							</div>
			
							<% 
							if(aDTO.getAuct_img().split(",").length > 1){
								for (int i = 1; i < aDTO.getAuct_img().split(",").length ; i++) {
									String imgfile = aDTO.getAuct_img().split(",")[i];
									if ((imgfile == null) || (imgfile.equals("null"))) {
										imgfile = "product_default.jpg";
									}
							%>
							
							<div class="item">
								<img src="./upload/<%=imgfile %>" class="d-block w-100" alt="..."
									style="width: 400px; height: 400px;">
								<div class="carousel-caption">...</div>
							</div>
							
							<%
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
					<h2><%=aDTO.getAuct_sub()%></h2>
					<h1><span id="maxPrice">
						최고가 : <fmt:formatNumber value="<%=bDAO.getMaxPrice(aDTO.getAuct_num())%>" pattern="#,###,###"/>원</span></h1>
					<h1 id="auct_price">
						최저가 : <fmt:formatNumber value="<%=aDTO.getAuct_price()%>" pattern="#,###,###"/>원</h1>
					
					<hr> <%
					 
					 String status = "";
					
					 switch (aDTO.getAuct_status()) {
					 case 0:
					 	status = "팝니다";
					 	break;
					 case 1:
					 	status = "판매완료";
					 	break;
					 }
					 %>
					<br><br>
					<ul id="u1">
						
						<li>거래여부 : <%=status%></li>
						<li>조회수 : <%=aDTO.getAuct_count() == 0 ? 1 : aDTO.getAuct_count()%></li>
						<li>작성시간 : <%=aDTO.getAuct_date()%></li>
					</ul> 
					
				
					
					<!-- 관리자만 사용가능한 메뉴 생성 -->
					<% if(user_nick != null){ 
						 if ( !aDTO.getUser_nick().equals(user_nick) ){
						%>
					
					<c:if test="<%=bDAO.bidCheck(aDTO.getAuct_num(), user_nick) == 0%>">
						
							<input type="button" value="입찰하기" class="btn btn-success" id="bidbutton"
	 							   onclick="openModal('modal1');">
			
					</c:if>
					
					<c:if test="<%=bDAO.bidCheck(aDTO.getAuct_num(), user_nick) == 1%>">
						
							<input type="button" value="입찰완료" class="btn btn-danger" id="bidbutton"
								style="color:red;" disabled="disabled">
					</c:if>		
						
						<input type="button" value="채팅하기" class="btn btn-info" >
						
					<%}
					}%>
				</td>
			</tr>
			<tr>
				<td colspan="2" height="400" style="vertical-align: top">
					<h1>상세정보</h1> <%=aDTO.getAuct_content()%>
				</td>
			</tr>
		</table>
		<div style="margin:auto;  width: 800px; ">
		<% if ( aDTO.getUser_nick().equals(user_nick) ){ %>
			<input type="button" value="수정하기" class="btn btn-light"
				onclick="location.href='./AuctionModify.ac?num=<%=aDTO.getAuct_num()%>'">
		<%}%>
		<% if( aDTO.getUser_nick().equals(user_nick) || uDAO.isAdmin(user_nick)){   %>
			<input type="button" value="삭제하기" class="btn btn-light"
			onclick="location.href='./AuctionDeleteAction.ac?num=<%=aDTO.getAuct_num()%>'">
		<%} %>
		</div>
	</div>	
<!-- 	</form> -->
<!--  		if(user_nick == null){
				alert("로그인 후 이용 가능합니다.");
				location.href='./UserLogin.us' 
			} -->
	</div>
	

	<div id="modal">
	<div class="modal-con modal1">
		<a href="javascript:;" class="close" onclick="closeModal('modal1');">X</a>
		<p class="title">입찰하기</p>
		<div class="con">
				<input type="hidden" value="<%=user_nick %>" name="user_nick">
				<input type="number" name="bidprice" id="bidprice" placeholder="가격을 입력해주세요.">
				
				<input type="button" value="입찰하기" id="bidsave">
		</div>
	</div>
</div>

<br>



<%@ include file="../inc/footer.jsp" %>
</body>


<script type="text/javascript">
	
	$(document).ready(function(){
		
		
		
		
		$("#bidsave").click(function(){
			
			var bidprice = document.getElementById("bidprice").value;
			var auct_price = document.getElementById("auct_price");
			
			if(bidprice < auct_price){
				alert("최저 입찰가보다 적게 입력할 수 없습니다.");
				return false;
			}
			
			if(bidprice == ""){
				alert("입찰가를 입력하세요.");
				return false;
				
			}
			
			
			
			$.ajax({
				
				url:"AuctBidAction.ab",
				data:{
					bidprice: $("#bidprice").val(),
					user_nick: "<%=user_nick%>",
					auct_num: <%=aDTO.getAuct_num()%>
					
				},
				type:"post",
				datatype: "json",
				success: function(data){
					
					if(data.check == 0){
						$("#bidbutton").css("color","red");
						$("#bidbutton").val("입찰완료");
						$("#bidbutton").attr('disabled', true);
						$("#modal").hide();
						$("#maxPrice").html(data.maxPrice);
					}else{
						alert("입찰이 불가능합니다.");
						$("#bidbutton").css("color","red");
						$("#bidbutton").val("입찰완료");
						$("#bidbutton").attr('disabled', true);
						$("#modal").hide();
					}
					
				}
				
			})
			
		});
		
		
	});


	



</script>



