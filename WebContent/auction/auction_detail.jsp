<%@page import="com.auction.bid.db.bidDTO"%>
<%@page import="com.auction.bid.db.bidDAO"%>
<%@page import="com.auction.db.AuctionDTO"%>
<%@page import="com.user.db.UserDAO"%>
<%@page import="com.user.db.UserDTO"%>
<%@page import="com.wish.db.WishDTO"%>
<%@page import="com.wish.db.WishDAO"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.prod.db.ProdDTO"%>
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
</style>
<body>

	<%
	String user_nick = (String)session.getAttribute("user_nick");
	AuctionDTO aDTO = (AuctionDTO)request.getAttribute("Auction");
	
	
	int pageNum = Integer.parseInt(request.getParameter("pageNum").toString());
	
	bidDAO bDAO = new bidDAO(); 
	bidDTO bDTO = new bidDTO();
	
	%>
	
	
<script>

	function openModal(modalname) {
		document.get
		$("#modal").fadeIn(300);
		$("." + modalname).fadeIn(300);
	}

	$(document).ready(function() {

		$("#modal, .close").on('click', function() {
			$("#modal").fadeOut(300);
			$(".modal-con").fadeOut(300);
		});

	});
</script>
	
	
	
	<form action="#" method="post" name="afr">
	<input type="hidden" name="nick" value=<%=user_nick%>>
	
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
								<img src="./upload/<%=aDTO.getAuct_img().split(",")[0]%>" class="d-block w-100" alt="..."
									style="width: 400px; height: 400px;"> 
									
								<div class="carousel-caption">...</div>
							</div>
			
							<% 
					
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
					<h4><%=aDTO.getAuct_num()%></h4>
					<h2><%=aDTO.getAuct_sub()%></h2>
					<h1><%=aDTO.getAuct_price()%></h1>
				<h1><span id="maxPrice"><%=bDAO.getMaxPrice(bDTO.getAuct_num())%></span></h1>
					<h3><%=aDTO.getUser_nick()%></h3>
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
										<ul>
						
						<li>거래여부 : <%=status%></li>
						<li>조회수 : <%=aDTO.getAuct_count() == 0 ? 1 : aDTO.getAuct_count()%></li>
						<small><li>작성시간 : <%=aDTO.getAuct_date()%></li></small>
					</ul> 
					
					<!-- 관리자만 사용가능한 메뉴 생성 -->
					<div id="wrap">
 						<input type="button" value="입찰하기" class="form-control" id="bidbutton"
 							   onclick="openModal('modal1');">
					</div>
					
					<input type="button" value="채팅하기" class="form-control">
					

				</td>
			</tr>
			<tr>
				<td colspan="2" height="400">
					<h1>상세정보</h1> <%=aDTO.getAuct_content()%>

				</td>
			</tr>

		</table>

		<input type="button" value="삭제하기"
			onclick="location.href='./AuctionDeleteAction.pr?num=<%=aDTO.getAuct_num()%>'">


	</form>



	<div id="modal"></div>
	<div class="modal-con modal1">
		<a href="javascript:;" class="close">X</a>
		<p class="title">입찰하기</p>
		<div class="con">
				<input type="hidden" value="<%=user_nick %>" name="user_nick">
				<input type="number" name="bidprice" id="bidprice" placeholder="가격을 입력해주세요.">
				
				<input type="button" value="입찰하기" id="bidsave">
		</div>
	</div>






	<%-- <%@ include file="../inc/footer.jsp" %> --%>
</body>


<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("#bidsave").click(function(){
			
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
						$("#modal").hide();
						$("#maxPrice").html(data.maxPrice);
					}
					
				}
				
			})
			
		});
		
		
		
		
	});





</script>



