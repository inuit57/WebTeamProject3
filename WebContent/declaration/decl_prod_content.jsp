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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<style type="text/css">

	.table th{
		text-align: center;
	}
</style>

</head>
<body>
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/> 
<!-- 헤더파일들어가는 곳 -->
<div align="center">	
<div class="container" >
<br>

<%
	request.setCharacterEncoding("utf-8");

	List decl_prod_reason = (List)request.getAttribute("decl_prod_reason");
	ProdDTO pDTO = (ProdDTO)request.getAttribute("pDTO");
	String date = pDTO.getProd_date().toString();
	int state = Integer.parseInt(request.getParameter("state"));
%>
	<table class="table">
		<tr>
			<th class="table-dark">글번호</th>
			<td><%=pDTO.getProd_num() %></td>
			<th class="table-dark">조회수</th>
			<td><%=pDTO.getProd_count() %></td>
		</tr>
		<tr>
			<th class="table-dark">작성자</th>
			<td><%=pDTO.getUser_nickname() %></td>
			<th class="table-dark">작성일</th>
			<td><%=date.substring(0, 16)%>분</td>
		</tr>
		<tr>
			<th class="table-dark">가격</th>
			<td colspan="3"><%=pDTO.getProd_price() %></td>
		</tr>
		<tr>
			<th class="table-dark">제목</th>
			<td colspan="3"><%=pDTO.getProd_sub() %></td>
		</tr>
		<tr>
			<th colspan="4" class="table-dark">글내용</th>
		</tr>
		<tr>
			<td colspan="4" rowspan="2"  style="height: 200px;"><img src="./upload/<%=pDTO.getProd_img().split(",")[0]%>"><br> <%=pDTO.getProd_content() %></td>
		</tr>
	</table>

	<hr style="width: 600px; margin-left: 0">
	
	<table class="table">
	<thead class="table-dark">
		<tr>
			<th>신고자</th>
			<th>신고사유</th>
			<th>기타내용</th>
			<th>신고날짜</th>
		</tr>
	</thead>
		<%for(int i=0; i<decl_prod_reason.size();i++){
			declarationDTO dcDTO = (declarationDTO)decl_prod_reason.get(i);%>
		<tr style="text-align: center">
			<td><%=dcDTO.getUser_nickname() %></td>
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
	
	<form action="decl_prod_DeleteAction.decl" onsubmit="return confirm('해당 신고글을 삭제하시겠습니까?')" method="get">
		<input type="button" class="btn btn-success" value="목록으로" style="margin-bottom: 2%; margin-left: 80%" onclick="location.href='decl_prod_list.decl?state=<%=state%>'">
		<input type="submit" class="btn btn-danger" value="해당글 삭제하기" style="margin-bottom: 2%">
		<input type="hidden" name="num" value="<%=pDTO.getProd_num()%>">
		<input type="hidden" name="state" value="<%=state%>">
	</form> 
</div>
</div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/footer.jsp"/> 
<!-- 푸터 들어가는 곳 -->	
</body>
</html>