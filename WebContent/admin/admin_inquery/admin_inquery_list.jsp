<%@page import="com.inquery.db.InqueryDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

	function modify(){
		return confirm("수정하시겠습니까?");
	}
	
	function deleteIn(){
		return confirm("삭제하시겠습니까?");
	}
	

</script>

</head>
<body>
		<h1>WebContent/admin_inquery/admin_inquery_list</h1>
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
	
	<table border="1">
		<tr>
			<td>글 번호</td>
			<td>닉네임</td>
			<td>제목</td>
			<td>날짜</td>
			<td>수정/삭제</td>
		</tr>
		
		<%
		for(int i=0;i<aiList.size();i++){
			InqueryDTO inDTO = (InqueryDTO) aiList.get(i);
		%>
		
		<tr>
			<td><%=inDTO.getInq_num() %></td>
			<td><%=inDTO.getUser_nick()%></td>
			<td><a href="./InqueryAdminContent.ai?num=<%=inDTO.getInq_num()%>">
				<%
				if(inDTO.getInq_lev()==1){
				%>
				( <%=inDTO.getInq_ref()%>번글 답글)
				
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
	

	
	
	<a href="./InqueryAdminList.ai">전체</a>
	<a href="./InqueryAdminList.ai?check=0">답변 요청글</a>
	<a href="./InqueryAdminList.ai?check=1">답변 완료글</a>
	<br>
	
	
	<form action="./InqueryAdminSearch.ai" method="post">
			<select name="sk">
				<option value="user_nick">작성자</option>
				<option value="inq_sub">글 제목</option>
			</select>
			<input type="text" name="sv">
			<input type="submit" value="검색">		
		</form>
	
	
	
	
	<hr>
	
	<a href="./FAQ.faq"> FAQ게시판 </a>
	
	
</body>
</html>