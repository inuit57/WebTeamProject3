<%@page import="com.user.db.UserDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원정보 조회</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="./css/admin.css">
<%@ include file="../../inc/top.jsp" %>
<style type="text/css">
input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: auto;

}

</style>

<style>
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  -webkit-appearance:auto;
}

</style>
<script type="text/javascript">

$(function(){
	
	$('.useryn').click(function(){
				
		$.ajax({
			 url: "./AdminUserActive.au", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소 
			 data:{user_nick:$(this).attr('value')},
			 success:function(){
				 location.reload();
			 } 					
			});
	
	});
	
	$(".levelbt").on("click",function(){
 		//클릭한 <input>을 $(this)로 선택해서 가져와서 

		
		$.ajax({
			url:"./AdminUserGrade.au",
			data:{user_nick:$(this).val(),user_grade:$(this).prev().attr("value")},
			success:function(){
				alert('회원 등급이 변경되었습니다.');
			}
			
	});
});
	
	
		$('.li1').click(function(){
			// 왼쪽 사이드 메뉴바 토글
			$(this).next().fadeToggle('slow',function(){
				
			})
			
		});

	
});


</script>



</head>
<body>

	<br>
	

<%
	List auList = (List)request.getAttribute("auList");
	
	int cnt = Integer.parseInt(request.getAttribute("cnt").toString());
	int pageSize = Integer.parseInt(request.getAttribute("pageSize").toString());
	int pageNum = Integer.parseInt(request.getAttribute("pageNum").toString());
	
	
	
	int currentPage = pageNum;
	
	
	int startRow = (currentPage-1)*pageSize+1;
	
	// 끝행 계산하기
	// 1p -> 10번, 2p -> 20번,... => 일반화
	int endRow = currentPage*pageSize;
	
	int auth = (int)request.getAttribute("auth");
	
	
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

	<div class="ad-content0 table-responsive">
	<h1 style="text-align: center;"> 회원 정보 관리</h1>
	<br>
		<table class="table table-sm table-hover" border="1">
			<thead class="table-dark">
				<tr>
					<th>닉네임</th>
					<th>아이디</th>
					<th>가입날짜</th>
					<th>코인</th>
					<th>연락처</th>
					<th>주소</th>
					<th>주소plus</th>
					<th>은행명</th>
					<th>은행계좌번호</th>
					<th>회원/관리자</th>
					<th>회원등급</th>
					<th>탈퇴여부</th>
					
				</tr>
			</thead>

<%
for(int i=0;i<auList.size();i++){
	UserDTO uDTO = (UserDTO)auList.get(i);
%>



<tr>
<td><%=uDTO.getUser_nickname() %></td>
<td><%=uDTO.getUser_id() %></td>
<td><%=uDTO.getUser_joindate() %></td>
<td><%=uDTO.getUser_coin() %></td>
<td><%=uDTO.getUser_phone() %></td>

<%
if(uDTO.getUser_address()==null){	
%>
<td></td>
<%}else{ %>
<td><%=uDTO.getUser_address() %></td>
<%
}
if(uDTO.getUser_addressPlus()==null){
%>
<td></td>
<%}else{ %>
<td><%=uDTO.getUser_addressPlus() %></td>
<%
}
if(uDTO.getUser_bankName()==null){
%>
<td></td>
<%}else{ %>
<td><%=uDTO.getUser_bankName() %></td>
<%
}
if(uDTO.getUser_bankAccount()==null){
%>
<td></td>
<%}else{ %>
<td><%=uDTO.getUser_bankAccount() %></td>
<%
} 
%>
<%
if(uDTO.getUser_auth()==2){
%>
<td>관리자 </td>
<%
}else{
%>
<td>회원 </td>
<%
}
%>
<td>

<input type="number" min="1" max="3" id="u_grade" name="u_grade" value="<%=uDTO.getUser_grade()%>">
<button class="levelbt btn btn-outline-success" id="levelbt" type="button" value="<%=uDTO.getUser_nickname()%>">변경</button>
</td>
<%
if(uDTO.getUser_use_yn()==1){
%>
<td>활성화&nbsp;<button class="useryn btn btn-outline-danger" id="useryn" type="button" value="<%=uDTO.getUser_nickname()%>">X</button></td>
<%
}else{
%>
<td>비활성화(탈퇴)&nbsp;<button class="useryn btn btn-outline-success" id="useryn" type="button" value="<%=uDTO.getUser_nickname()%>">O</button></td>
<%
} 
%>


</tr>


<%
}
%>

</table>
<%
		/////////////////////////////////////////////////////////////
		// 페이징 처리 - 하단부 페이지 링크
		
		if(cnt != 0){ // 글이 있을때 표시
		
		// 전체 페이지수 계산
		// ex) 총 50개 -> 한 페이지당 10개씩 출력, 5개
		// 	      총 57개 -> 한 페이지당 10개씩 출력, 6개
		int pageCount = cnt/pageSize+(cnt % pageSize == 0? 0:1);
		
		// 한 화면에 보여줄 페이지 번호의 개수(페이지 블럭)
		int pageBlock = 5;
		
		// 페이지 블럭의 시작페이지 번호
		// ex) 1~10페이지 : 1, 11~20 페이지 : 11, 21~30 페이지 : 21
		int startPage = ((currentPage-1)/pageBlock)*pageBlock + 1;
		
		// 페이지 블럭의 끝 페이지 번호
		int endPage = startPage+pageBlock-1;
		
		String url = request.getRequestURI().toString();
		
		
		
		if( auth == 0 ){
			url = "./AdminUserList.au?pageNum=";
		}else{
			url = "./AdminUserList.au?auth="+auth+ "&pageNum=";
			
		}
		
		if(endPage > pageCount){
			endPage = pageCount;
		}
		
		// 이전 (해당 페이지블럭의 첫번째 페이지 호출)
		if(startPage > pageBlock){
		%>
		
		
		
<%-- 		<a href="<%=url%>&pageNum=<%=startPage-pageBlock%>">[이전]</a> --%>
		<a href="<%=url%><%=startPage-pageBlock%>">[이전]</a>
		<% 
		}
		
		
		
		
		// if( url.indexOf("auth") > 0 ){
			
		//}
		// 숫자 1....5
		for(int i = startPage;i<=endPage;i++){
			
		%> 
	
<%-- 		<a href="<%=url %>&pageNum=<%=i%>">[<%=i %>]</a> --%>
		<a href="<%=url %><%=i%>">[<%=i %>]</a>
		<% 
		}
		
		// 다음 (기존의 페이지 블럭보다 페이지의 수가 많을때)
		if(endPage < pageCount){
		%>
	
<%-- 		<a href="<%=url %>&pageNum=<%=startPage+pageBlock%>">[다음]</a> --%>
		<a href="<%=url %><%=startPage+pageBlock%>">[다음]</a>
		<%
		
		}
		
		
		}	
		/////////////////////////////////////////////////////////////	

%>


<br>


	<br>
	
	
	<form action="./AdminUserSearch.au" method="post">
	<div class="search01">
			<select style="width:100px;" class="form-select" name="sk">
				<option value="user_nickname">닉네임 </option>
				<option value="user_id">아이디 </option>
			</select>
			<input style="width:300px;" type="text" class="form-control" name="sv">
			<input type="submit" class="btn btn-outline-success" value="검색">		
		</div>
		</form>
	<br>
	
	<a href="./AdminUserList.au">전체</a>
	<a href="./AdminUserList.au?auth=1">일반회원</a>
	<a href="./AdminUserList.au?auth=2">관리자</a>

</div>	

</body>
<div class="footer">
<%@ include file="../../inc/footer.jsp" %>
</div>
</html>