<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.board.comment.db.boardCommentDTO"%>
<%@page import="com.board.comment.db.boardCommentDAO"%>
<%@page import="com.board.db.boardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
	form {
		display: inline;
	}
</style>
</head>
<body>
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/> 
<!-- 헤더파일들어가는 곳 -->
<%
	// 세션제어
	String user_nick = (String)session.getAttribute("user_nick");
%>
<%-- 	<%=user_nick %>님 환영합니다. --%>
<%
	// 전달된 정보저장
	boardDTO bDTO = (boardDTO)request.getAttribute("bDTO");
	int board_num = Integer.parseInt(request.getParameter("board_num"));
	String pageNum = request.getParameter("pageNum");
	int cmt_pageNum = Integer.parseInt(request.getAttribute("cmt_pageNum").toString());
	//int cmt_pageNum = Integer.parseInt(request.getParameter("cmt_pageNum"));
	List boardCommentList = (List)request.getAttribute("boardCommentList");
	int cmt_pageSize = Integer.parseInt(request.getAttribute("cmt_pageSize").toString());
	int currentPage = Integer.parseInt(request.getAttribute("currentPage").toString());
	
	boardCommentDAO bcDAO = new boardCommentDAO();
	int cmt_cnt = bcDAO.getBoardCommentCount(board_num);
%>

<div class="container">
<br><br>
	<div style="margin:auto;  width: 800px;">
	<div align="right">
	<% if(user_nick != null){ %>
		<form action="./declaration.decl" method="post" onsubmit="return confirm('이 글을 신고하시겠습니까?')">
			<input type="submit" value="신고하기" >
			<input type="hidden" name="board_num" value="<%=board_num%>">
			<!-- 신고당하는 글 작성자 -->
			<input type="hidden" name="decl_writer" value="<%=bDTO.getUser_nick()%>">
			<input type="hidden" name="board_sub" value="<%=bDTO.getBoard_sub()%>">
			<input type="hidden" name="board_type" value="0">
			<input type="hidden" name="pageNum" value="<%=pageNum%>">
		</form>
	<%} %>
	</div>
	<table class="table table-bordered" border="1"  >
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
			<th colspan="4">글내용</th>
		</tr>
		<tr>
			<td colspan="4" rowspan="2"  style="height: 200px;"><%=bDTO.getBoard_content() %></td>
		</tr>
	</table>
<!-- 	<hr style="width: 600px; margin-left: 0"> -->
	<hr>
	<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@댓글@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
	
	<%
		ArrayList al = bcDAO.getCommentList(board_num);
		int al_size = al.size(); 
		int cmtViewCnt = 5; //한번에 보이는 댓글갯수
	%>
		<table class="table table-bordered" border="1"  >
			<tr>
<!-- 				<th style="width: 100px; "> 작성자 </th> -->
<!-- 				<th style="width: 200px;"> 댓글 내용 </th> -->
<!-- 				<th style="width: 100px;"> 작성일 </th> -->
<!-- 				<th style="width: 100px;"> 수정/삭제 </th> -->
				<th> 작성자 </th>
				<th> 댓글 내용 </th>
				<th> 작성일 </th>
				<th> 수정/삭제 </th>
			</tr>
			
		<%
		for(int i = 0; i < cmtViewCnt ; i++){
			int index = (cmt_pageNum-1)*cmtViewCnt + i ; 
			if(index >= al_size) break;	
			boardCommentDTO bcDTO2 = (boardCommentDTO)al.get(index);
			
		%>
			<tr>
<%-- 				<td style="width: 100px; text-align: center;"><%=bcDTO2.getUser_nick() %></td> --%>
<%-- 				<td style="width: 300px; text-align: center;"><%=bcDTO2.getCmt_content() %></td> --%>
<%-- 				<td style="width: 100px; text-align: center;"><%=bcDTO2.getCmt_date().substring(0, 10) %></td> --%>
<!-- 				<th style="width: 100px;"> -->
				<td style="width: 100px; text-align: center;"><%=bcDTO2.getUser_nick() %></td>
				<td style="width: 300px;"><%=bcDTO2.getCmt_content() %></td>
				<td style="width: 100px;"><%=bcDTO2.getCmt_date().substring(0, 10) %></td>
				<th style="width: 100px;">
					<%
						if(bcDTO2.getUser_nick().equals(user_nick)|| user_nick.equals("admin")) {
					%>
							<form action="board_Comment_Modify.bco?board_num=<%=board_num %>&pageNum=<%=pageNum%>" method="post">
								<input type="submit" value="수정" onclick="return confirm('이댓글을 수정하시겠습니까?')">
								<input type="hidden" name="cmt_num" value="<%=bcDTO2.getCmt_num()%>">
								<input type="hidden" name="cmt_content" value="<%=bcDTO2.getCmt_content()%>">
							</form>
							<form action="boardCommentDeleteAction.bco?board_num=<%=board_num %>&pageNum=<%=pageNum%>" method="post">
								<input type="submit" value="삭제" onclick="return confirm('이댓글을 삭제하시겠습니까?')">
								<input type="hidden" name="cmt_num" value="<%=bcDTO2.getCmt_num()%>">
							</form>
					<%
						}
					%>
				</th>
			</tr>
			<%
			} //for
			%>
			<tr>
			<!-- 댓글 작성공간 -->
			<form action="BoardCommentWriteAction.bco?board_num=<%=bDTO.getBoard_num()%>&pageNum=<%=pageNum %>" method="post">
				<input type="hidden" name="user_nick" value="<%=user_nick%>">
				<td>댓글</td>
				<td colspan="2"><input type="text" name="cmt_content" style="width:600px;"></td>
				<td><input type="submit" value="댓글등록"></td>	
			</form>
			<!-- 댓글 작성공간 -->
			</tr>
		</table>
		
		<div align="center">
		<%
		/////////////////////////////////////////////////////////
		// 페이징 처리 - 하단부 페이지 링크
		if(cmt_cnt != 0){ // 글이 있을때 표시
			// 전체 페이지수 계산
			// ex) 	총50개 -> 한페이지당 10개씩 출력, 5개
			//		총57개 -> 한페이지당 10개씩 출력, 6개
			int pageCount = cmt_cnt/cmt_pageSize + (cmt_cnt % cmt_pageSize == 0? 0 : 1);
			
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
				<a href="board_content.bo?board_num=<%=board_num %>&pageNum=<%=pageNum%>&cmt_pageNum=<%=startPage - pageBlock%>">[이전]</a>
				<%
			}
			// 숫자 1...5
			for(int i = startPage; i <= endPage; i++){
				%>
					<a href="board_content.bo?board_num=<%=board_num %>&pageNum=<%=pageNum%>&cmt_pageNum=<%=i%>" >[<%=i %>]</a>				
				<%
			}
			// 다음 (기존의 페이지 블럭보다 페이지의 수가 많을때)
			if(endPage < pageCount){
				%>
				<a href="board_content.bo?board_num=<%=board_num %>&pageNum=<%=pageNum%>&cmt_pageNum=<%=startPage + pageBlock%>">[다음]</a>
				<%
			}
		}
	%>
	</div>
	<hr>
	
	<div align="center">
	<form action="boardDeleteAction.bo" >
	<%
	// 유저가 작성자아이디와 일치하면 수정 삭제 버튼 보여줌 
	if(bDTO.getUser_nick().equals(user_nick) || user_nick.equals("admin")){
	%>
		<input type="button" value="수정하기" onclick="location.href='board_modify.bo?board_num=<%=bDTO.getBoard_num() %>&pageNum=<%=pageNum %>';" >
		<input type="submit" value="삭제하기" onclick="return confirm('게시글을 삭제하시겠습니까?')">
	<%		
		} // 아니면 목록으로 버튼만 보여줌
	
	%>
		<input type="button" value="목록으로" onclick="location.href='board_List.bo?pageNum=<%=pageNum%>';">
		<input type="hidden" name="board_num" value="<%=bDTO.getBoard_num() %>">
	</form>
	</div>

</div>
</div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/footer.jsp"/> 
<!-- 푸터 들어가는 곳 -->	
</body>
</html>