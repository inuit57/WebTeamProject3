<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
 #ad-sidebar {
        width: 260px;
        padding: 20px;
        margin-bottom: 20px;
        left;
        border: 1px solid #bcbcbc;
      }
     
 #ad-content {
    width: 580px;
    padding: 20px;
    margin-bottom: 20px;
    float: left;
    border: 1px solid #bcbcbc;
  }

</style>


<%@ include file="../inc/top.jsp" %>
</head>
<body>
	
	<h1>admin/admin_board</h1>
	
	<div class="container-fluid">	
		<div id="ad-sidebar">
			<ul>	
				<a href="./AdminUserList.au">회원 목록 조회</a>				
			</ul>		
			
			<ul>	
				<a href="./InqueryAdminList.ai">1:1 문의 내역조회</a>				
			</ul>
			
			<ul>
				<a href="#">신고내역 조회</a>				
			</ul>		
		</div>
	
	
	<div class="ad-content">
		
	
	
	</div>

	</div>
	
	


</body>
<%@ include file="../inc/footer.jsp" %>
</html>