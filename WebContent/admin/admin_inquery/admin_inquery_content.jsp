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

		<div id="col-lg-3">
			
				<h1 class="h2 pb-4">관리자 게시판</h1>
						
			<ul class="list-unstyled templatemo-accordion">
			<li  class="pb-3">
			<a class="collapsed d-flex justify-content-between h3 text-decoration-none" href="#">
				회원목록 조회
				<i class="fa fa-fw fa-chevron-circle-down mt-1"></i>
                        </a>
				 	<ul id="collapseTwo" class="collapse list-unstyled pl-3">
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
				 	<ul id="collapseTwo" class="collapse list-unstyled pl-3">
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
				 	<ul id="collapseTwo" class="collapse list-unstyled pl-3">				 		
				 	<li><a  class="text-decoration-none" href="./decl_prod_list.decl?state=0">상품게시판</a></li>	
				 	<li><a  class="text-decoration-none" href="./decl_normal_list.decl?state=1">일반게시판</a></li>
				 	</ul>	
					</li>
			</ul>		
				
		</div>
		
<div class="ad-content0">
<br>
<h1> 1:1문의 상세페이지</h1>
<br>
	
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