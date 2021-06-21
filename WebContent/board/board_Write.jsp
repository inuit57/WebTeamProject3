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
// 세션제어
//	String user_id = (String) session.getAttribute("user_id");
	
//	if (user_id == null) {
	%>
<!--  	<script type="text/javascript">
			alert("로그인이 필요한 서비스입니다.");	
			location.href="@@@@@@@";
		</script>-->
	<%		
//	}	
%>
	<fieldset>
		<form action="./BoardWriteAction.bo" method="post" enctype="multipart/form-data">
		지역 : <select name="board_area">
					<option value="서울">서울</option>
					<option value="경기">경기</option>
					<option value="대전">대전</option>
					<option value="부산">부산</option>
					<option value="울산">울산</option>
					<option value="대구">대구</option>
					<option value="광주">광주</option>
					<option value="강원도">강원도</option>
					<option value="인천">인천</option>
			   </select> <br>
		작성자 : <input type="text" name="user_name"> <br>
		제목 : <input type="text" name="board_sub"> <br>
		내용 : <textarea rows="10" cols="30" name="board_content"></textarea><br>
		첨부파일 : <input type="file" name="board_file" >  
		<hr>
		
			<input type="submit" value="글쓰기">
		</form>
	</fieldset>	
	
	
</body>
</html>