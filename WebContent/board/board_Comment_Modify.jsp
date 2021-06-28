<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>댓글 수정하기</title>
</head>
<body>
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/> 
<!-- 헤더파일들어가는 곳 -->
	<h1> 댓글 수정하기 </h1>
	
	<%
		// 한글처리
		request.setCharacterEncoding("UTF-8");
	
		// 전달된 댓글번호, 페이지번호, 댓글내용 저장
		int cmt_num = Integer.parseInt(request.getParameter("cmt_num"));
		String cmt_content = request.getParameter("cmt_content");
		String pageNum = request.getParameter("pageNum");
		int board_num = Integer.parseInt(request.getParameter("board_num"));
	%>
	
	<form action="boardCommentModifyAction.bco" method="post">
		<input type="text" name="cmt_content_modify" value="<%=cmt_content%>">
		<input type="hidden" name="cmt_num" value="<%=cmt_num%>">
		<input type="hidden" name="board_num" value="<%=board_num%>">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<input type="submit" value="수정하기">
	</form>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/footer.jsp"/> 
<!-- 푸터 들어가는 곳 -->
</body>
</html>