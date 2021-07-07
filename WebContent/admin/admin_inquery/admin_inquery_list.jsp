<%@page import="com.inquery.db.InqueryDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>1:1문의 게시판(관리자)</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="./assets/css/bootstrap.min.css">
<link rel="stylesheet" href="./css/admin.css">



<script type="text/javascript">

	function modify(){
		return confirm("수정하시겠습니까?");
	}
	
	function deleteIn(){
		return confirm("삭제하시겠습니까?");
	}
	

</script>

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
		<h1 style="text-align: center;">1:1 문의 게시판 관리</h1>
	<%
	 List aiList =(List)request.getAttribute("aiList");
	
	//request.setAttribute("pageSize", pageSize);
	//request.setAttribute("pageNum", pageNum);

		int cnt = Integer.parseInt(request.getAttribute("cnt").toString());
		int pageSize = Integer.parseInt(request.getAttribute("pageSize").toString());
		int pageNum = Integer.parseInt(request.getAttribute("pageNum").toString());
	

		
		int currentPage = pageNum;
	
		
		int startRow = (currentPage-1)*pageSize+1;
		
		// 끝행 계산하기
		// 1p -> 10번, 2p -> 20번,... => 일반화
		int endRow = currentPage*pageSize;
		
		String check = (String)request.getAttribute("check");
		
		
	%>
	
		
		<div id="ad-sidebar">
			
					<a href="./AdminBoard.ap">관리자 게시판	</a>
						
			<ul>
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
				 	<li><a href="./decl_prod_list.decl?state=0">상품게시판</a></li>	
				 	<li><a href="./decl_normal_list.decl?state=1">일반게시판</a></li>
				 	</ul>	
				 </div>
							
			</ul>		
				
		</div>
		
		
  <div class="ad-content0 table-responsive">
		<table class="table table-sm table-hover" border="1">
		  <thead class="table-dark">
			<tr>
				<td>글 번호</td>
				<td>닉네임</td>
				<td>제목</td>
				<td>날짜</td>
				<td>수정/삭제</td>
			</tr>
		 </thead>
		<%
		for(int i=0;i<aiList.size();i++){
			InqueryDTO inDTO = (InqueryDTO) aiList.get(i);
		%>
		
		<tr>
			<td><%=inDTO.getInq_num() %></td>
			<td><%=inDTO.getUser_nickname()%></td>
			<td><a href="./InqueryAdminContent.ai?num=<%=inDTO.getInq_num()%>">
				<%
				if(inDTO.getInq_lev()==1){
				%>
				( <%=inDTO.getInq_ref()%>번글 답글)
				
				<%} %>
			
			<%
			if(inDTO.getInq_check().equals("1") && inDTO.getInq_lev()==0){
			%>
			(답변완료)
			<%} %>
				<%=inDTO.getInq_sub() %></a></td>
			<td><%=inDTO.getInq_date() %></td>
			<td>
			
			
				<a href="./InqueryAdminModifyForm.ai?num=<%=inDTO.getInq_num()%>" 
					onclick="return modify();">수정</a>/ 
				<a href="./InqueryAdminDelete.ai?num=<%=inDTO.getInq_num()%>" 
				 	onclick="return deleteIn();">삭제</a>
			</td>
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
			
			if(endPage > pageCount){
				endPage = pageCount;
			}
			
		// 이전 (해당 페이지블럭의 첫번째 페이지 호출)
		if(startPage > pageBlock){
			
			%>
			<a href="./InqueryAdminList.ai?pageNum=<%=startPage-pageBlock%>&check=<%=check%>">[이전]</a>

			<% 
			}			
		

		// 숫자 1....5
		for(int i = startPage;i<=endPage;i++){
			
			%>
			<a href="./InqueryAdminList.ai?pageNum=<%=i%>&check=<%=check%>">[<%=i %>]</a>
			<% 
		}
		
		// 다음 (기존의 페이지 블럭보다 페이지의 수가 많을때)
		if(endPage < pageCount){			
			%>
			<a href="./InqueryAdminList.ai?pageNum=<%=startPage+pageBlock%>&check=<%=check%>">[다음]</a>
			<% 
			}}
		/////////////////////////////////////////////////////////////	
		%>
	
	
	<br>
	

	
	
	
	<br>
	
	
	<form action="./InqueryAdminSearch.ai" method="post">
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
	
	
	<a href="./InqueryAdminList.ai">전체</a>
	<a href="./InqueryAdminList.ai?check=0">답변 요청글</a>
	<a href="./InqueryAdminList.ai?check=1">답변 완료글</a>
	
	
	
	</div>
	
</body>
<div class="footer">
<%@ include file="../../inc/footer.jsp" %>
</div>
</html>