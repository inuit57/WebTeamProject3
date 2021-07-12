<%@page import="com.inquery.db.InqueryDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>1:1 문의 작성글</title>
<link rel="stylesheet" href="./css/admin.css">
<script type="text/javascript">
function modify(){
	return confirm("수정하시겠습니까?");
}

function deleteIn(){
	return confirm("삭제하시겠습니까?");
}

</script>

<style>
.ad-content0{
padding: 150px;
}
.ad-content0 button{
float:right;
}

</style> 

<%@ include file="../../inc/top.jsp" %>

</head>
<body>


<%
	InqueryDTO inDTO =(InqueryDTO) request.getAttribute("inDTO");

	String user_nickname = (String) session.getAttribute("user_nick"); 

%>
  <div class="ad-content0">
  <table border="1" class="table">
			<tr>
				<td>글번호</td>
				<td><%=inDTO.getInq_num()%></td>
				<td>작성일</td>
				<td><%=inDTO.getInq_date()%></td>

			</tr>
			<tr>
				<td>글쓴이</td>
				<td colspan="3"><%=inDTO.getUser_nickname()%></td>
			</tr>
			<tr>
				<td>글 제목</td>
				<td colspan="3"><%=inDTO.getInq_sub()%></td>
			</tr>
			
			<tr>
				<td>글 내용</td>
				<td colspan="3"><%=inDTO.getInq_content() %></td>
			</tr>
			
			
		</table>
		
			<%
			

			if(inDTO.getUser_nickname().equals(user_nickname)){// 세션값 아이디 받아서 수정

			%>
		<button class="btn btn-outline-danger" type="button" onclick="location.href='./InqueryDelete.in?num=<%=inDTO.getInq_num()%>'">삭제</button>
		<button class="btn btn-outline-warning" type="button" onclick="location.href='./InqueryModifyForm.in?num=<%=inDTO.getInq_num()%>'">수정</button>
		
		
		

			<%
			}
			%>
</div>
</body>
<div class="footer">
<%@ include file="../../inc/footer.jsp" %>
</div>
</html>