<%@page import="com.board.db.boardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>일반게시판 글수정</title>
</head>
<body>

<%
	// 세션제어
	
	// 전달된 정보저장
	boardDTO bDTO = (boardDTO)request.getAttribute("bDTO");
	String pageNum = request.getParameter("pageNum");
%>

	<fieldset>
		<form action="./BoardModifyAction.bo?board_num=<%=bDTO.getBoard_num() %>&pageNum=<%=pageNum %>" method="post">
			제목 : <input type="text" name="board_sub" value="<%=bDTO.getBoard_sub()%>" > <br>
			지역 :
				<select name="board_area" >
					<option value="서울"
					<%if(bDTO.getBoard_area().equals("서울")){ %>selected<%} %>
					>서울</option>
					<option value="경기"
					<%if(bDTO.getBoard_area().equals("경기")){ %>selected<%} %>
					>경기</option>
					<option value="대전"
					<%if(bDTO.getBoard_area().equals("대전")){ %>selected<%} %>
					>대전</option>
					<option value="부산"
					<%if(bDTO.getBoard_area().equals("부산")){ %>selected<%} %>
					>부산</option>
					<option value="울산"
					<%if(bDTO.getBoard_area().equals("울산")){ %>selected<%} %>
					>울산</option>
					<option value="대구"
					<%if(bDTO.getBoard_area().equals("대구")){ %>selected<%} %>
					>대구</option>
					<option value="광주"
					<%if(bDTO.getBoard_area().equals("광주")){ %>selected<%} %>
					>광주</option>
					<option value="강원도"
					<%if(bDTO.getBoard_area().equals("강원도")){ %>selected<%} %>
					>강원도</option>
					<option value="인천"
					<%if(bDTO.getBoard_area().equals("인천")){ %>selected<%} %>
					>인천</option>
			   </select> <br>
			<a>내용</a>  <br>
			<textarea rows="10" cols="105" name="board_content"><%=bDTO.getBoard_content() %></textarea>
			<hr>
			<input type="submit" value="수정저장하기" >
		</form>
	</fieldset>
	
	
</body>
</html>