<%@page import="com.board.db.boardDTO"%>
<%@page import="com.board.db.boardDAO"%>
<%@page import="com.declaration.db.declarationDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>신고목록 게시판</h1>
	
	<input type="button" value="상품게시판 신고목록 보기" onclick="location.href='decl_prod_list'">
	<input type="button" value="일반게시판 신고목록 보기" onclick="location.href='decl_normal_list'">
	
	<%
		// 전달된 신고글 목록 저장
		List decl_normal_list = (List)request.getAttribute("decl_normal_list");
		boardDAO bDAO = new boardDAO();
		
		// 신고횟수
		int decl_cnt = 1;
	%>
	
	<table border="1">
		<tr>
			<td>번호</td>
			<td>작성자</td>	<!-- 신고당한 글 작성자 -->	
			<td>제목</td>		
			<td>신고날짜</td>		
			<td>신고자</td>
			<td>신고횟수</td>		
		</tr>
	<%
	for(int i = 0; i < decl_normal_list.size(); i++){
		declarationDTO dcDTO = (declarationDTO)decl_normal_list.get(i);
		
		// 신고게시판에 있는 신고당한글 번호(board_num)를 꺼내서
		// bDAO.getContent(board_num)  DAO객체에 있는 getContent함수로 글내용 가져옴
		int board_num = dcDTO.getBoard_num();
		
		boardDTO bDTO = new boardDTO();
		bDTO = bDAO.getContent(board_num);
		//////////////////////////////////////////////////////////
		if(bDTO.getBoard_num() > 1){
			decl_cnt ++;
		}
		//////////////////////////////////////////////////////////
	%>
		<tr>
			<td><%=bDTO.getBoard_num() %></td>
			<td><%=dcDTO.getUser_nick() %></td> <!-- 신고당한 글 작성자 -->
			<td><%=bDTO.getBoard_sub() %></td> <!-- 신고당한 글의 제목 boardDTO?에서 꺼내옴 -->
			<td><%=dcDTO.getDecl_date() %></td>		
			<td><%=dcDTO.getDecl_writer() %></td><!-- 게시글을 신고한사람 -->	
			<td><%=decl_cnt %></td>	
		</tr>
	<%
	}
	%>	
	</table>
	
	
</body>
</html>