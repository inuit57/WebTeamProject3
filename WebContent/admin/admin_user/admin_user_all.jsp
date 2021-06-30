<%@page import="com.user.db.UserDTO"%>
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
<%
	List auList = (List)request.getAttribute("auList");
	
	int cnt = Integer.parseInt(request.getAttribute("cnt").toString());
	int pageSize = Integer.parseInt(request.getAttribute("pageSize").toString());
	int pageNum = Integer.parseInt(request.getAttribute("pageNum").toString());
	
	
	
	int currentPage = pageNum;
	
	
	int startRow = (currentPage-1)*pageSize+1;
	
	// 끝행 계산하기
	// 1p -> 10번, 2p -> 20번,... => 일반화
	int endRow = currentPage*pageSize;
	
	int auth = (int)request.getAttribute("auth");
	
%>

<table border="1">
		<tr>
			<td>유저번호</td>
			<td>닉네임</td>
			<td>아이디</td>
			<td>가입날짜</td>
			<td>코인</td>
			<td>연락처</td>
			<td>주소</td>
			<td>주소plus</td>
			<td>은행명</td>
			<td>은행계좌번호</td>
			<td>회원/관리자</td>
			<td>회원등급</td>
			<td>탈퇴여부</td>
			
		</tr>


<%
for(int i=0;i<auList.size();i++){
	UserDTO uDTO = (UserDTO)auList.get(i);

%>
<tr>
<td><%=uDTO.getUser_num() %></td>
<td><%=uDTO.getUser_nickname() %></td>
<td><%=uDTO.getUser_id() %></td>
<td><%=uDTO.getUser_joindate() %></td>
<td><%=uDTO.getUser_coin() %></td>
<td><%=uDTO.getUser_phone() %></td>
<td><%=uDTO.getUser_address() %></td>
<td><%=uDTO.getUser_addressPlus() %></td>
<td><%=uDTO.getUser_bankName() %></td>
<td><%=uDTO.getUser_bankAccount() %></td>
<%
if(uDTO.getUser_auth()==0){
%>
<td>회원 </td>
<%
}else{
%>
<td>관리자 </td>
<%
}
%>
<td><%=uDTO.getUser_grade() %></td>
<td><%=uDTO.getUser_use_yn() %></td>


</tr>
<%
}
%>

</table>
<%
		/////////////////////////////////////////////////////////////
		// 페이징 처리 - 하단부 페이지 링크
		
		if(cnt != 0){ // 글이 있을때 표시
		
		// 전체 페이지수 계산
		// ex) 총 50개 -> 한 페이지당 10개씩 출력, 5개
		// 	      총 57개 -> 한 페이지당 10개씩 출력, 6개
		int pageCount = cnt/pageSize+(cnt % pageSize == 0? 0:1);
		
		// 한 화면에 보여줄 페이지 번호의 개수(페이지 블럭)
		int pageBlock = 5;
		
		// 페이지 블럭의 시작페이지 번호
		// ex) 1~10페이지 : 1, 11~20 페이지 : 11, 21~30 페이지 : 21
		int startPage = ((currentPage-1)/pageBlock)*pageBlock + 1;
		
		// 페이지 블럭의 끝 페이지 번호
		int endPage = startPage+pageBlock-1;
		
		String url = request.getRequestURI().toString();
		
		System.out.println("@@@@@@@@@@@@@@@@"+url);
		
		
		if( url.indexOf("auth") <0 ){
			url = "./AdminUserList.au?pageNum=";
		}else{
			url = "./AdminUserList.au?auth="+auth+ "&pageNum=";
		}
		
		if(endPage > pageCount){
			endPage = pageCount;
		}
		
		// 이전 (해당 페이지블럭의 첫번째 페이지 호출)
		if(startPage > pageBlock){
		%>
		
<%-- 		<a href="<%=url%>&pageNum=<%=startPage-pageBlock%>">[이전]</a> --%>
		<a href="<%=url%><%=startPage-pageBlock%>">[이전]</a>
		<% 
		}
		
		
		
		
		// if( url.indexOf("auth") > 0 ){
			
		//}
		// 숫자 1....5
		for(int i = startPage;i<=endPage;i++){
			
		%> 
	
<%-- 		<a href="<%=url %>&pageNum=<%=i%>">[<%=i %>]</a> --%>
		<a href="<%=url %><%=i%>">[<%=i %>]</a>
		<% 
		}
		
		// 다음 (기존의 페이지 블럭보다 페이지의 수가 많을때)
		if(endPage < pageCount){
		%>
	
<%-- 		<a href="<%=url %>&pageNum=<%=startPage+pageBlock%>">[다음]</a> --%>
		<a href="<%=url %><%=startPage+pageBlock%>">[다음]</a>
		<%
		
		}
		
		
		}	
		/////////////////////////////////////////////////////////////	

%>


<br>

<a href="./AdminUserList.au">전체</a>
	<a href="./AdminUserList.au?auth=0">일반회원</a>
	<a href="./AdminUserList.au?auth=1">관리자</a>
	<br>
	<br>
	
	
	<form action="./AdminUserSearch.ai" method="post">
			<select name="sk">
				<option value="user_nick">닉네임 </option>
				<option value="user_id">아이디 </option>
			</select>
			<input type="text" name="sv">
			<input type="submit" value="검색">		
		</form>
	

</body>
</html>