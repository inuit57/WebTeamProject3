<%@page import="com.declaration.db.declarationDAO"%>
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
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="./assets/css/bootstrap.min.css">

<style>
*{
	font-size: 11px;
}


</style>


<title>신고목록 - 일반게시판</title>

</head>
<body>
<!-- 헤더파일들어가는 곳 -->

	<div class="innerContent table-responsive normal">

	<h2 style="text-align: center;">신고목록 - 일반게시판</h2>
		
	<%
		// 전달된 신고글 목록 저장
		List decl_normal_list = (List)request.getAttribute("decl_normal_list");
		int decl_normal_listcnt = Integer.parseInt(request.getAttribute("decl_normal_listcnt").toString());
		int pageNum = Integer.parseInt(request.getAttribute("pageNum").toString());	
		int pageSize = Integer.parseInt(request.getAttribute("pageSize").toString());
		int currentPage = Integer.parseInt(request.getAttribute("currentPage").toString());
		
		boardDAO bDAO = new boardDAO();
		declarationDAO dcDAO = new declarationDAO();
	%>
	
	<table class="table table-sm table-hover" border="1"  style="text-align: center;">
	 <thead class="table-dark">
		<tr>
			<td>피의자</td>	<!-- 신고당한 글 작성자 -->	
			<td>글번호</td>
			<td>제목</td>		
			<td>신고날짜</td>		
			<td>신고자</td>
			<td>신고횟수</td>
			<td>처리상태</td>		
		</tr>
		</thead>
	<%
	for(int i = 0; i < decl_normal_list.size(); i++){
		declarationDTO dcDTO = (declarationDTO)decl_normal_list.get(i);
		
		// 신고게시판에 있는 신고당한글 번호(board_num)를 꺼내서
		// bDAO.getContent(board_num)  DAO객체에 있는 getContent함수로 글내용 가져옴
		int board_num = dcDTO.getBoard_num();
		// dcDTO에있는 신고당한 게시글 번호를 가져가서
		// 신고테이블DB에 해당 게시글번호로 신고된 게시글 개수가 몇개인지 찾아옴
		int decl_normal_cnt = dcDAO.getDecl_normal_count(board_num);
		
	%>
		<tr>
			<td><%=dcDTO.getDecl_writer() %></td> <!-- 신고당한 글 작성자 -->
			<td><%=dcDTO.getBoard_num() %></td>
			<td>
				<a href="decl_normal_content.decl?board_num=<%=board_num%>"><%=dcDTO.getBoard_sub() %></a>
			</td> 
			<td><%=dcDTO.getDecl_date().substring(0,16) %></td>		
			<td><%=dcDTO.getUser_nickname() %></td><!-- 게시글을 신고한사람 -->	
			<td><%=decl_normal_cnt %></td>	
			<%
			
			if(dcDTO.getDecl_state()==1){
			%>
			<td style="color: red;">처리중</td>
			<%}else{ %>
			<td style="color: green;">처리완료</td>
			<%} %>
			
		</tr>
	<%
	}
	%>	
	</table>
</div>

<!-- 푸터 들어가는 곳 -->

<!-- 푸터 들어가는 곳 -->	
</body>
</html>