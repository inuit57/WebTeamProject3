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
<title>신고목록 - 일반게시판</title>
</head>
<body>
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/> 
<!-- 헤더파일들어가는 곳 -->

<div class="container" >
<br><br>
	<h1>신고목록 - 일반게시판</h1>
	<hr>
	<input type="button" value="상품게시판 신고목록 보기" onclick="location.href='decl_prod_list.decl'">
	<input type="button" value="일반게시판 신고목록 보기" onclick="location.href='decl_normal_list.decl?state=0'">
	<br>
	<input type="button" value="처리대기중" onclick="location.href='decl_normal_list.decl?state=1'">
	<input type="button" value="처리완료" onclick="location.href='decl_normal_list.decl?state=2'">
		
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
	
	<table border="1">
		<tr>
			<td>피의자</td>	<!-- 신고당한 글 작성자 -->	
			<td>글번호</td>
			<td>제목</td>		
			<td>신고날짜</td>		
			<td>신고자</td>
			<td>신고횟수</td>
			<td>처리상태</td>		
		</tr>
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
				String state = "";
			
			switch(dcDTO.getDecl_state()){
			
			case 1: 
				state = "처리중";
				break;
			case 2:
				state = "처리완료";
				break;
			}
			%>
			<td><%=state %></td>
		</tr>
	<%
	}
	%>	
	</table>
	
	<%
		/////////////////////////////////////////////////////////
		// 페이징 처리 - 하단부 페이지 링크
		
		if(decl_normal_listcnt != 0){ // 글이 있을때 표시
			
			// 전체 페이지수 계산
			// ex) 	총50개 -> 한페이지당 10개씩 출력, 5개
			//		총57개 -> 한페이지당 10개씩 출력, 6개
			int pageCount = decl_normal_listcnt/pageSize + (decl_normal_listcnt % pageSize == 0? 0 : 1);
			
			// 한 화면에 보여줄 페이지 번호의 개수 (페이지 블럭)
			int pageBlock = 5;
			
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
				<a href="decl_normal_list.decl?pageNum=<%=startPage - pageBlock%>" >[이전]</a>
				<%
			}
			
			
			
			// 숫자 1...5
			for(int i = startPage; i <= endPage; i++){
				%>
					<a href="decl_normal_list.decl?pageNum=<%=i%>">[<%=i %>]</a>				
				<%
			}
			
			// 다음 (기존의 페이지 블럭보다 페이지의 수가 많을때)
			if(endPage < pageCount){
				%>
				<a href="decl_normal_list.decl?pageNum=<%=startPage + pageBlock%>">[다음]</a>
				<%
			}
			
		}
		
		/////////////////////////////////////////////////////////
		
	%>
</div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/footer.jsp"/> 
<!-- 푸터 들어가는 곳 -->	
</body>
</html>