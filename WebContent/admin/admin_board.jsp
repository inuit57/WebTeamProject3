<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="./css/admin.css">

<%@ include file="../inc/top.jsp" %>


</head>
<body>


<script type="text/javascript">
$(document).ready(function(){
	$.ajax({
	    url: "./AdminUserListSample.au", // 유저정보게시판 샘플 
	    method: "GET",   // HTTP 요청 메소드(GET, POST 등)
	   success:function(data){
		   $(".ad-content1").html(data);		   
			   }
			});
	
	$.ajax({
	    url: "./declarationListSample.decl", // 신고게시판 샘플 추가 필요
	    method: "GET",   // HTTP 요청 메소드(GET, POST 등)
	   success:function(data){
		   $(".ad-content2").html(data);		   
			   }
			});
	
	$.ajax({
	    url: "./InqueryAdminListSample.ai", // 1:1 문의 게시판 관리자용 샘플
	    method: "GET",   // HTTP 요청 메소드(GET, POST 등)
	   success:function(data){
		   $(".ad-content3").html(data);		   
			   }
			});
	
			
	$('.li1').click(function(){
		// 왼쪽 사이드 메뉴바 토글
		$(this).next().fadeToggle('slow',function(){
			
		})
		
	});
	

	
});
</script>
	
	<br>

	
		
		<div id="col-lg-3">
			
				<h1 class="h2 pb-4">관리자 게시판</h1>
						
			<ul class="list-unstyled templatemo-accordion">
			<li  class="pb-3">
			<a class="collapsed d-flex justify-content-between h3 text-decoration-none" href="#">
				회원목록 조회
				<i class="fa fa-fw fa-chevron-circle-down mt-1"></i>
                        </a>
				 	<ul>
					<li><a class="text-decoration-none" href="./AdminUserList.au">전체</a></li>
					<li><a class="text-decoration-none" href="./AdminUserList.au?auth=1">일반회원</a></li>
					<li><a class="text-decoration-none" href="./AdminUserList.au?auth=2">관리자</a></li>
					</ul>
					</li>				
				<li class="pb-3">
				<a class="collapsed d-flex justify-content-between h3 text-decoration-none" href="#">
				1:1 문의 내역조회
				 <i class="pull-right fa fa-fw fa-chevron-circle-down mt-1"></i>
                        </a>
				 	<ul >
					<li><a class="text-decoration-none" href="./InqueryAdminList.ai">전체</a></li>
					<li><a class="text-decoration-none" href="./InqueryAdminList.ai?check=0">답변 요청글</a></li>
					<li><a class="text-decoration-none" href="./InqueryAdminList.ai?check=1">답변 완료글</a></li>
					</ul>
				</li>
											
				<li class="pb-3">
				<a class="collapsed d-flex justify-content-between h3 text-decoration-none" href="#">
				신고내역 조회
				<i class="pull-right fa fa-fw fa-chevron-circle-down mt-1"></i>
                        </a>
				 	<ul>				 		
				 	<li><a  class="text-decoration-none" href="./decl_prod_list.decl?state=0">상품게시판</a></li>	
				 	<li><a  class="text-decoration-none" href="./decl_normal_list.decl?state=1">일반게시판</a></li>
				 	</ul>	
					</li>
			</ul>		
				
		</div>
		

	
	
	<div class="ad-content1">
	</div>

	<div class="ad-content2">
	</div>
	<div class="ad-content3">
	</div>

	
	 
	


</body>
<div class="footer">
<%@ include file="../inc/footer.jsp" %>
</div>
</html>