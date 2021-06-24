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
<title>일반 게시판</title>
</head>
<body>

<%

	boardDAO bDAO = new boardDAO();
	int cnt = bDAO.getBoardCount();

	List boardList = (List)request.getAttribute("boardList");
	int pageNum = Integer.parseInt(request.getAttribute("pageNum").toString());
	int pageSize = Integer.parseInt(request.getAttribute("pageSize").toString());
	int currentPage = Integer.parseInt(request.getAttribute("currentPage").toString());
	
%>
	<h1>내가 쓴 글 목록</h1>
<!-- 	<input type="button" value="글쓰기" onclick="location.href='./board_Write.bo'"> -->
	<table border="1">
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>작성자</td>
			<td>작성일</td>
			<td>조회수</td>
		</tr>
	<%
		for(int i = 0; i < boardList.size(); i++){
			boardDTO dto = (boardDTO)boardList.get(i);
	%>	
		<tr>
			<td><%=dto.getBoard_num() %></td>
			<td>
				<a href="board_content.bo?board_num=<%=dto.getBoard_num()%>&pageNum=<%=pageNum%>"><%=dto.getBoard_sub() %></a>
			</td>
			<td><%=dto.getUser_nick() %></td>
			<td><%=dto.getBoard_date() %></td>
			<td><%=dto.getBoard_count() %></td>
		</tr>
	<%
		}
	%>	
	</table>
	
		<%
		/////////////////////////////////////////////////////////
		// 페이징 처리 - 하단부 페이지 링크
		
		if(cnt != 0){ // 글이 있을때 표시
			
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
				<a href="board_List.bo?pageNum=<%=startPage - pageBlock%>">[이전]</a>
				<%
			}
			
			
			
			// 숫자 1...5
			for(int i = startPage; i <= endPage; i++){
				%>
					<a href="board_List.bo?pageNum=<%=i%>" >[<%=i %>]</a>				
				<%
			}
			
			// 다음 (기존의 페이지 블럭보다 페이지의 수가 많을때)
			if(endPage < pageCount){
				%>
				<a href="board_List.bo?pageNum=<%=startPage + pageBlock%>">[다음]</a>
				<%
			}
			
		}
		
		/////////////////////////////////////////////////////////
	%>
	
</body>
</html>