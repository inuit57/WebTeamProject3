<%@page import="com.board.db.boardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>일반게시판 내용</title>

</head>
<body>

<%
	// 세션제어
//	String user_id = (String) session.getAttribute("user_id");	
	
	// 전달된 정보저장
	boardDTO bDTO = (boardDTO)request.getAttribute("bDTO");
	String pageNum = request.getParameter("pageNum");
	
%>
	<input type="button" value="신고하기" style="margin-left: 500px;"> <br>
	<table border="1" style="width: 600px;">
		<tr>
			<th>글번호</th>
			<td><%=bDTO.getBoard_num() %></td>
			<th>조회수</th>
			<td><%=bDTO.getBoard_count() %></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><%=bDTO.getUser_nick() %></td>
			<th>작성일</th>
			<td><%=bDTO.getBoard_date().substring(0, 10)%></td>
		</tr>
		<tr>
			<th>지역</th>
			<td colspan="3"><%=bDTO.getBoard_area() %></td>
		</tr>
		<tr>
			<th>제목</th>
			<td colspan="3"><%=bDTO.getBoard_sub() %></td>
		</tr>
		<tr>
			<th class="td1">첨부파일</th>
			<td colspan="3"><%=bDTO.getBoard_file() %></td>
		</tr>
		<tr>
			<th colspan="4">글내용</th>
		</tr>
		<tr>
			<td colspan="4" rowspan="2"  style="height: 200px;"><%=bDTO.getBoard_content() %></td>
		</tr>
	</table>
	<hr>
	<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@댓글@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
	
	<form action="BoardCommentWriteAction.bco?board_num=<%=bDTO.getBoard_num()%>&pageNum=<%=pageNum %>" method="post">
		댓글 : <input type="text" name="cmt_content" style="width: 480px;">
		<input type="submit" value="댓글등록" >	
		<input type="hidden" name="user_nick" value="<%=bDTO.getUser_nick()%>">
	</form>
	
	<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@댓글@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
	<hr>
	<form action="boardDeleteAction.bo" >
	<%
// 세션처리 모르겠음 if(bDTO.getUser_nick.equals(user_nick) || ???){
	// 유저아이디가 없거나 회원구분 (관리자 : 1) 관리자가 아닐시 목록으로 버튼만 보여줌
	%>
		<input type="button" value="목록으로" onclick="location.href='board_List.bo?pageNum=<%=pageNum%>';">
	
	<%		
//		}else{ // 본인글이거나 관리자일시 수정삭제 버튼 보여줌
	
	%>
		<input type="button" value="수정하기" onclick="location.href='board_modify.bo?board_num=<%=bDTO.getBoard_num() %>&pageNum=<%=pageNum %>';" >
		<input type="submit" value="삭제하기" onclick="return confirm('게시글을 삭제하시겠습니까?')">
	<%
//		}
	%>	
		<input type="hidden" name="board_num" value="<%=bDTO.getBoard_num() %>">
	</form>

	
</body>
</html>