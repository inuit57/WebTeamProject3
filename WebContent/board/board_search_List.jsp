<%@page import="java.util.ArrayList"%>
<%@page import="com.board.db.boardDAO"%>
<%@page import="com.board.db.boardDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/> 
<!-- 헤더파일들어가는 곳 -->	
<!-- 	<h1> 게시글 검색 내역 </h1> -->
<div class="container">
<br><br>
<%
	// 세션제어
	String user_nick = (String)session.getAttribute("user_nick");
%>	
<%-- 	<%=user_nick %>님 환영합니다. --%>
<%	
	boardDAO bDAO = new boardDAO();
	// 전달된 정보저장
	List boList = (List)request.getAttribute("boList");
	String sk =(String) request.getAttribute("sk");
	String[] sv =(String[]) request.getAttribute("sv");

	//int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	int pageNum = Integer.parseInt(request.getAttribute("pageNum").toString());
	int pageSize = Integer.parseInt(request.getAttribute("pageSize").toString());
	int cnt = Integer.parseInt(request.getAttribute("cnt").toString());
	
	 int currentPage = pageNum;
	 
	 int startRow = (currentPage-1)*pageSize+1;
	   
	 // 끝행 계산하기
	 // 1p -> 10번, 2p -> 20번,... => 일반화
	 int endRow = currentPage*pageSize;
	 
	 ArrayList al = (ArrayList)bDAO.boardSearch(sk, sv);
	 int al_size = al.size();

%>
<div style="margin:auto;  width: 800px;">
<div align="right">
<input type="button" value="전체목록으로" onclick="location.href='board_List.bo?page_num=<%=pageNum%>'">
<input type="button" value="글쓰기" onclick="location.href='./board_Write.bo'">
</div>
	<table  class="table table-bordered" border="1" >
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>작성자</td>
			<td>작성일</td>
			<td>조회수</td>
		</tr>
	<%
		for(int i = 0; i < pageSize; i++){
			int index = (pageNum-1)*pageSize + i;
			if(index >= al_size) break;
			boardDTO bDTO = (boardDTO)boList.get(index);
	%>	
		<tr>
			<td><%=bDTO.getBoard_num() %></td>
			<td>
				<a href="board_content.bo?board_num=<%=bDTO.getBoard_num()%>&pageNum=<%=pageNum%>"><%=bDTO.getBoard_sub() %></a>
			</td>
			<td><%=bDTO.getUser_nickname() %></td>
			<td><%=bDTO.getBoard_date() %></td>
			<td><%=bDTO.getBoard_count() %></td>
		</tr>
	<%
		}
	%>	
	</table>
	
	<div align="center">
	<%
		/////////////////////////////////////////////////////////
		// 페이징 처리 - 하단부 페이지 링크
		if(cnt != 0){ // 글이 있을때 표시
			%>
			<hr>
			<%
			// 전체 페이지수 계산
			// ex) 	총50개 -> 한페이지당 10개씩 출력, 5개
			//		총57개 -> 한페이지당 10개씩 출력, 6개
			int pageCount = cnt/pageSize + (cnt % pageSize == 0? 0 : 1);
			
			// 한 화면에 보여줄 페이지 번호의 개수 (페이지 블럭)
			int pageBlock = 2;
			
			// 페이지블럭의 시작페이지 번호
			// ex) 	1~10 페이지 : 1, 11~20 페이지 : 11, 21~30페이지 : 21
			int startPage = ((currentPage-1) / pageBlock) * pageBlock + 1;
			
			// 페이지블럭의 끝페이지 번호
			int endPage = startPage + pageBlock -1;
			
			if(endPage > pageCount) {
				endPage = pageCount;
			}
			
			// 이전(해당 페이지블럭의 첫번째 페이지 호출)
			if(startPage > pageBlock){
				%>
				<a href="BoardSearchAction.bo?pageNum=<%=startPage - pageBlock%>&sk=<%=sk%>&sv=<%=sv%>" >[이전]</a>
				<%
			}
			// 숫자 1...5
			for(int i = startPage; i <= endPage; i++){
				%>
					<a href="BoardSearchAction.bo?pageNum=<%=i%>&sk=<%=sk%>&sv=<%=sv%>">[<%=i %>]</a>				
				<%
			}
			
			// 다음 (기존의 페이지 블럭보다 페이지의 수가 많을때)
			if(endPage < pageCount){
				%>
				<a href="BoardSearchAction.bo?pageNum=<%=startPage + pageBlock%>&sk=<%=sk%>&sv=<%=sv%>">[다음]</a>
				<%
			}
			
		}
		/////////////////////////////////////////////////////////
	%>
		<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@검색@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
		   <form action="./BoardSearchAction.bo" method="post">
         		<select name="sk">
            		<option value="user_nickname">작성자</option>
            		<option value="board_sub">글 제목</option>
         		</select>
         		<input type="text" name="sv">
         		<input type="submit" value="검색">  
         		<input type="hidden" name="pageNum" value="<%=pageNum%>">
	      		
      		</form>
			<br>
		<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@검색@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
		</div>
	</div>
</div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/footer.jsp"/> 
<!-- 푸터 들어가는 곳 -->
</body>
</html>