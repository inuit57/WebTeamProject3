<%@page import="com.inquery.db.InqueryDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>1:1문의 글 내용</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="./assets/css/bootstrap.min.css">
<link rel="stylesheet" href="./css/admin.css">

<script type="text/javascript">
$(function(){
	
	
	
	
		$('.li1').click(function(){
			// 왼쪽 사이드 메뉴바 토글
			$(this).next().fadeToggle('slow',function(){
				
			})
			
		});

	
});


</script>




<%@ include file="../../inc/top.jsp" %>

</head>
<body>


<%
	InqueryDTO inDTO =(InqueryDTO) request.getAttribute("inDTO");

%>
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
				 	<li><a href="./decl_prod_list.decl">상품게시판 신고내역</a></li>	
				 	<li><a href="./decl_normal_list.decl">일반게시판 신고내역</a></li>
				 	</ul>	
				 </div>
							
			</ul>		
				
		</div>
		
<div class="ad-content0">
  		<table class="table" border="1">
   		
			<tr>
				<td>글번호</td>
				<td><%=inDTO.getInq_num()%></td>
				<td>작성일</td>
				<td><%=inDTO.getInq_date()%></td>

			</tr>
			<tr>
				<td>글쓴이</td>
				<td colspan="3"><%=inDTO.getUser_nickname()%></td>
			</tr>
			<tr>
				<td>글 제목</td>
				<td colspan="3"><%=inDTO.getInq_sub()%></td>
			</tr>
			
		
			<tr>
				<td>글 내용</td>
				<td colspan="3"><%=inDTO.getInq_content() %></td>
			</tr>
			
			
		</table>

<%
	if(!inDTO.getInq_check().equals("1")){
%>

	<button class="btn btn-outline-success" type="button" onclick="location.href='./InqueryAdminWriteFormAction.ai?num=<%=inDTO.getInq_num()%>'">답변달기</button>
<%} %>
</div>

</body>
<div class="footer">
<%@ include file="../../inc/footer.jsp" %>
</div>
</html>