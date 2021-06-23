<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="jquery/jquery-3.6.0.js"></script>
<script type="text/javascript" src="./user/userLoginJS/userLogin.js"></script>
<title>Insert title here</title>


<!-- 카카오 스크립트 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">
Kakao.init('824c000c199e69a3e3dc1d068f46bdfc');
console.log(Kakao.isInitialized());

function kakaoLogin() {
    Kakao.Auth.login({
      success: function (response) {
        Kakao.API.request({
          url: '/v2/user/me',
          success: function (response) {
        	  console.log(response)
          },
          fail: function (error) {
            console.log(error)
          },
        })
      },
      fail: function (error) {
        console.log(error)
      },
    })
  }
//카카오로그아웃  
function kakaoLogout() {
    if (Kakao.Auth.getAccessToken()) {
      Kakao.API.request({
        url: '/v1/user/unlink',
        success: function (response) {
        	console.log(response)
        },
        fail: function (error) {
          console.log(error)
        },
      })
      Kakao.Auth.setAccessToken(undefined)
    }
  }  
</script>

</head>
<body>
	<% String error = request.getParameter("error"); %>
	<h3>로그인</h3>
	<form action="./UserLoginAction.us">
	<input type="text" id="id" name="id" placeholder="아이디"><br>
	<input type="password" id="pw" name="pw" placeholder="비밀번호"><br>
	<input type="submit" value="로그인"><br>
	
	<img src="./img/kakao_login.png" onclick="kakaoLogin();">
	
	
	
	
	
	
	
	
	</form>
	<%if(error != null && error.equals("1")) {%>
	<label>아이디 또는 비밀번호 오류 입니다.</label>
	<%} else {} %>
</body>
</html>