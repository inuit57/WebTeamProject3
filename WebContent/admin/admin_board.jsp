<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<style type="text/css">
 #ad-sidebar {
        width: 15%;
        padding: 20px;
        margin-bottom: 20px;
        float: left;
        border: 1px solid #bcbcbc;
      }
  #ad-sidebar li {
  	list-style: none;
  	text-decoration: none;
  }
  
  #ad-sidebar .li1 {
  	font-weight: bold !important;
  }
  
   #ad-sidebar li a:VISITED {
   	font-weight: bold !important;
   	color: black;
   }
  

  
 .li-1{
 	display: none;
 }

.li1:hover{
	background-color: green;
	cursor: pointer;
}

.li-1 li:hover{
	background-color: green;
	cursor: pointer;
}

#ad-sidebar a {
	text-decoration: none;
	color:black;
}

     
 .ad-content1 {
    width: 85%;
    padding: 20px;
    margin-bottom: 20px;
    float:none;
  
    overflow: hidden;
    height: 400px;
  }
  
  .innerContent {
  	width: 100%;
  }
  
  
 .ad-content2 {
 	clear:both;
 	margin-left:15%;
    width: 40%;
    padding: 20px;
    margin-bottom: 20px;
    float:left;
   
    overflow: hidden;
    height: 500px;
    
  }
  
 .ad-content3 {
 	
    width: 40%;
    padding: 20px;
    margin-bottom: 20px;
    float:right;
 
    overflow: hidden;
    height: 500px;
    
  }
  
 .footer {
 	clear:both;
 } 
  



</style>


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
	    url: "./InqueryAdminListSample.ai", // 1:1 문의 게시판 관리자용 샘플
	    method: "GET",   // HTTP 요청 메소드(GET, POST 등)
	   success:function(data){
		   $(".ad-content3").html(data);		   
			   }
			});
	
	$.ajax({
	    url: "./declarationListSample.decl", // 신고게시판 샘플 추가 필요
	    method: "GET",   // HTTP 요청 메소드(GET, POST 등)
	   success:function(data){
		   $(".ad-content2").html(data);		   
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

	
	<div class="container-fluid">	
	<h1 style="text-align: center;">관리자 게시판</h1>
		<div id="ad-sidebar">
			
			<ul>
				<li><a href="./AdminBoard.ap">관리자 게시판</a>	</li>				
				<li class="li1">회원목록 조회</li>
				 <div class="li-1">
				 	<ul>
					<li><a href="./AdminUserList.au">전체</a></li>
					<li><a href="./AdminUserList.au?auth=1">일반회원</a></li>
					<li><a href="./AdminUserList.au?auth=2">관리자</a></li>
					</ul>
				 </div>					
				<li class="li1">1:1 문의 내역조회</li>
				 <div class="li-1">
				 	<ul>
					<li><a href="./InqueryAdminList.ai">전체</a></li>
					<li><a href="./InqueryAdminList.ai?check=0">답변 요청글</a></li>
					<li><a href="./InqueryAdminList.ai?check=1">답변 완료글</a></li>
					</ul>
				 </div>								
				<li class="li1">신고내역 조회</li>
				 <div class="li-1">
				 	<ul>
				 	<li><a href="./declarationList.decl">전체</a></li>	
				 	<li><a href="./decl_prod_list.decl">상품게시판</a></li>	
				 	<li><a href="./decl_normal_list.decl">일반게시판</a></li>
				 	</ul>	
				 </div>
							
			</ul>		
				
		</div>
	
	
	<div class="ad-content1">
	</div>

	<div class="ad-content2">
	</div>
	<div class="ad-content3">
	</div>

	</div>
	
	


</body>
<div class="footer">
<%@ include file="../inc/footer.jsp" %>
</div>
</html>