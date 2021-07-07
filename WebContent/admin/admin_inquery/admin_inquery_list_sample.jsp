<%@page import="com.inquery.db.InqueryDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="./assets/css/bootstrap.min.css">
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
		<h2 style="text-align: center;">1:1 문의 게시판 관리</h2>
	<%
	 List aiList =(List)request.getAttribute("aiList");
	
	//request.setAttribute("pageSize", pageSize);
	//request.setAttribute("pageNum", pageNum);

		int cnt = Integer.parseInt(request.getAttribute("cnt").toString());

		
		String check = (String)request.getAttribute("check");		
		
	%>
		<div class="innerContent table-responsive inquery">
	
	<table class="table table-sm table-hover" border="1">
	 <thead class="table-dark">
		<tr>
			<td>글 번호</td>
			<td>닉네임</td>
			<td>제목</td>
			<td>날짜</td>
			<td>수정/삭제</td>
		</tr>
	 </thead>
		<%
		for(int i=0;i<aiList.size();i++){
			InqueryDTO inDTO = (InqueryDTO) aiList.get(i);
		%>
		
		<tr>
			<td><%=inDTO.getInq_num() %></td>
			<td><%=inDTO.getUser_nickname()%></td>
			<td><a href="./InqueryAdminContent.ai?num=<%=inDTO.getInq_num()%>">
				<%
				if(inDTO.getInq_lev()==1){
				%>
				( <%=inDTO.getInq_ref()%>번글 답글)
				
				<%} %>
			
				<%=inDTO.getInq_sub() %></a></td>
			<td><%=inDTO.getInq_date() %></td>
			<td>
			
			
				<a href="./InqueryAdminModifyForm.ai?num=<%=inDTO.getInq_num()%>" 
					onclick="return modify();">수정</a>/ 
				<a href="./InqueryAdminDelete.ai?num=<%=inDTO.getInq_num()%>" 
				 	onclick="return deleteIn();">삭제</a>
			</td>
		</tr>
		<%
		}
		%>
	</table>
	</div>
</body>
</html>