<%@page import="com.prod.db.ProdDTO"%>
<%@page import="com.declaration.db.declarationDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.board.db.boardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>신고글 내용 및 사유</title>
<script type="text/javascript">
	


</script>
</head>
<body>
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/> 
<!-- 헤더파일들어가는 곳 -->

<h1>신고글 내용 및 사유</h1>

<%
	request.setCharacterEncoding("utf-8");

	List decl_prod_reason = (List)request.getAttribute("decl_prod_reason");
	ProdDTO pDTO = (ProdDTO)request.getAttribute("pDTO");
	String date = pDTO.getProd_date().toString();
%>
	<table border="1" style="width: 600px;">
		<tr>
			<th>글번호</th>
			<td><%=pDTO.getProd_num() %></td>
			<th>조회수</th>
			<td><%=pDTO.getProd_count() %></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><%=pDTO.getUser_nick() %></td>
			<th>작성일</th>
			<td><%=date.substring(0, 16)%>분</td>
		</tr>
		<tr>
			<th>가격</th>
			<td colspan="3"><%=pDTO.getProd_price() %></td>
		</tr>
		<tr>
			<th>제목</th>
			<td colspan="3"><%=pDTO.getProd_sub() %></td>
		</tr>
		<tr>
			<th colspan="4">글내용</th>
		</tr>
		<tr>
			<td colspan="4" rowspan="2"  style="height: 200px;"><img src="./upload/<%=pDTO.getProd_img().split(",")[0]%>"><br> <%=pDTO.getProd_content() %></td>
		</tr>
	</table>

	<hr style="width: 600px; margin-left: 0">
	
	<table border="1" style="width: 1000px;">
		<tr>
			<th>신고자</th>
			<th>신고사유</th>
			<th>기타내용</th>
			<th>신고날짜</th>
		</tr>
		<%for(int i=0; i<decl_prod_reason.size();i++){
			declarationDTO dcDTO = (declarationDTO)decl_prod_reason.get(i);%>
		<tr>
			<td><%=dcDTO.getUser_nick() %></td>
		<%
			String reason ="";
		
		switch(dcDTO.getDecl_reason()){
		
		case 1:
			reason = "부적절한 홍보 게시글";
			break;
		case 2:
			reason = "음란성 또는 청소년에게 부적합한 내용";
			break;
		case 3:
			reason = "중고거래 게시글이 아니에요";
			break;
		case 4:
			reason = "전문 판매업자 같아요";
			break;
		case 5:
			reason = "사기 글이에요";
			break;
		case 6:
			reason = "기타";
			break;
		}
		%>	
			
			<td><%=reason %></td>
			<td><%if(dcDTO.getDecl_content() == null){%><%} else { %>
				<%=dcDTO.getDecl_content() %>
			<%} %>
			</td>
			<td><%=dcDTO.getDecl_date().substring(0,16)%>분</td>
		</tr>
		<%} %>
	</table>
	
	<form action="decl_prod_DeleteAction.decl?" onsubmit="return confirm('해당 신고글을 삭제하시겠습니까?')" method="get">
		<input type="button" value="목록으로" onclick="location.href='decl_prod_list.decl'">
		<input type="submit" value="해당글 삭제하기" >
		<input type="hidden" name="num" value="<%=pDTO.getProd_num()%>">
	</form>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/footer.jsp"/> 
<!-- 푸터 들어가는 곳 -->	
</body>
</html>