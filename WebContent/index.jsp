<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="jquery/jquery-3.6.0.js"></script>
<script type="text/javascript" src="./user/userLoginJS/userLogin.js"></script>
<link href="./img/title.png" rel="shortcut icon" type="image/x-icon">
<title>기억마켓</title>


</head>
<body>

    <%
    response.sendRedirect("./main.bo");
     %>
  
   <a href="./main.bo">메인</a><br>
   <a href="./UserLogin.us">로그인</a><br>
   <a href="./UserJoin.us">회원가입</a><br>
   
   <a href="./board_List.bo">일반게시판</a><br>
   <a href="./declarationList.decl">신고목록 게시판</a><br>

   
   <%if(session.getAttribute("id") != null) { %>
   <%=session.getAttribute("nick") %>님 어서오세요.<br>
      <a href="./UserInfoAction.us">마이 페이지</a><br>
      <a href="./UserLogoutAction.us">로그아웃</a><br>
   <%} else { %>
      <a href="./UserLogin.us">로그인</a><br>
      <a href="./UserJoin.us">회원가입</a><br>
   <%} %>


</body>

</html>