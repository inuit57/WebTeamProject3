<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="jquery/jquery-3.6.0.js"></script>
<script type="text/javascript" src="./user/userCheckJS/UserCheck.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href="css/userJoin.css" rel="stylesheet">
<script type="text/javascript">
<!--

//-->
</script>
<title>회원가입</title>
</head>
<body>
   <div id="join">
   <div id="logo">
      <label id="logo">기억마켓</label>
   </div>
   <form action="./UserJoinAction.us" method="post" onsubmit="return check()">
   <div id="join_input">
   <label>아이디</label><br>
   <input type="text" name="id" id="id" 
               <%if(request.getParameter("id") != null){ %>
               value=<%=request.getParameter("id")  %>
               <%} %>readonly><br>
   
   <label id="id_error" class="error"></label><br>
   
   <label>닉네임</label><br>
   <input type="text" name="nickname" id="nickname" placeholder="특수 문자를 제외한 8글자 이내" onblur="checkNick();" autocomplete="off"
               <%if(request.getParameter("user_nickname") != null){ %>
               value=<%=request.getParameter("user_nickname")  %>
               <%} %>  ><br>
               
               
   <label id="nickname_error" class="error"></label><br>
   <label>비밀번호</label><br>
   <input type="password" name="pw" id="pw" placeholder="영문,숫자,특수문자 포함 8자리" onkeyup="checkPw();"><br>
   <label>비밀번호 재확인</label><br>
   <input type="password" id="pw_check" onkeyup="checkPw();"><br>
   <label id="pw_error" class="error"></label><br>
   <label>전화번호</label><br>
   <input type="text" name="phone" id="phone" placeholder="숫자만 입력해 주세요." onkeyup="checkPhone();" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"><br>
   <label id="phone_error" class="error"></label><br>
   <label>주소</label><label id="address_find" onclick="findAddr()">주소 찾기</label><br>
   <input type="text" name="address" id="address" placeholder="오른쪽 위의 주소 찾기를 눌러주세요." readonly="readonly"><br>
   <label>상세주소</label><br>
   <input type="text" name="address_plus" id="address_plus" onblur="addressCheck();" autocomplete="off"><br>
   <label id="address_error" class="error"></label><br>
   </div>
   <br><input type="submit" value="가입하기" id="join_submit">
   </form>
   <div id="footer">
   기억마켓 <label id="copyright">Copyright 삼조 Itwillbs. All Rights Reserved.</label>
   </div>
   </div>
</body>
</html>