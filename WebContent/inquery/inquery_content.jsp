<%@page import="com.inquery.db.InqueryDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
function modify(){
	return confirm("수정하시겠습니까?");
}

function deleteIn(){
	return confirm("삭제하시겠습니까?");
}



</script>


</head>
<body>


<%
	InqueryDTO inDTO =(InqueryDTO) request.getAttribute("inDTO");

%>
  
  <table border="1">
			<tr>
				<td>글번호</td>
				<td><%=inDTO.getInq_num()%></td>
				<td>작성일</td>
				<td><%=inDTO.getInq_date()%></td>

			</tr>
			<tr>
				<td>글쓴이</td>
				<td colspan="3"><%=inDTO.getUser_nick()%></td>
			</tr>
			<tr>
				<td>글 제목</td>
				<td colspan="3"><%=inDTO.getInq_sub()%></td>
			</tr>
			<%
			if(inDTO.getInq_img()!=null){
			%>
			<tr>
				<td>이미지</td>
				<td colspan="3">
					<img src="./inquery/upload/<%=inDTO.getInq_img()%>">
				</td>				
			</tr>
		<%} %>
			<tr>
				<td>글 내용</td>
				<td colspan="3"><%=inDTO.getInq_content() %></td>
			</tr>
			
			
		</table>
		
			<%
			
			if(inDTO.getUser_nick().equals("홍길정")){// 세션값 아이디 받아서 수정
			%>
		
			<a href="./InqueryModifyForm.in?num=<%=inDTO.getInq_num()%>" 
					onclick="return modify();">수정</a>/ 
				<a href="./InqueryDelete.in?num=<%=inDTO.getInq_num()%>" 
				 	onclick="return deleteIn();">삭제</a>

			<%
			}
			%>

</body>
</html>