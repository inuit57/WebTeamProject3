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
  }
     
 .ad-content1 {
    width: 85%;
    padding: 20px;
    margin-bottom: 20px;
    float:right;
    border: 1px solid red;
    overflow: hidden;
    height: 400px;
  }
  
 .ad-content2 {
 	clear:both;
 	margin-left:15%;
    width: 40%;
    padding: 20px;
    margin-bottom: 20px;
    float:left;
    border: 1px solid red;
    overflow: hidden;
    height: 400px;
    
  }
  
 .ad-content3 {
 	clear:both;
 	margin-left:15%;
    width: 40%;
    padding: 20px;
    margin-bottom: 20px;
    float:left;
    border: 1px solid red;
    overflow: hidden;
    height: 400px;
    
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
	    url: "./AdminUserListSample.au", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소 
	    method: "GET",   // HTTP 요청 메소드(GET, POST 등)
	   success:function(data){
		   $(".ad-content1").html(data);		   
			   }
			});
	
	$.ajax({
	    url: "./InqueryAdminListSample.ai", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소 
	    method: "GET",   // HTTP 요청 메소드(GET, POST 등)
	   success:function(data){
		   $(".ad-content3").html(data);		   
			   }
			});
	
	$.ajax({
	    url: "./declarationList.decl", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소 
	    method: "GET",   // HTTP 요청 메소드(GET, POST 등)
	   success:function(data){
		   $(".ad-content2").html(data);		   
			   }
			});
			

	
	
});
</script>


	<h1 style="text-align: center;">관리자 게시판</h1>
	
	<div class="container-fluid">	
		<div id="ad-sidebar">
			
			<ul>
				<li><a href="./AdminBoard.ap">관리자 게시판</a>
				<li><a href="./AdminUserList.au">회원 목록 조회</a></li>
				<li><a href="./InqueryAdminList.ai">1:1 문의 내역조회</a>	</li>				
				<li><a href="./declarationList.decl">신고내역 조회</a></li>				
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
>>>>>>> refs/heads/develop
</html>