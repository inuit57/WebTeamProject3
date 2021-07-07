<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">


<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="./user/images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="./user/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="./user/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="./user/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="./user/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="./user/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="./user/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="./user/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="./user/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="./user/css/util.css">
	<link rel="stylesheet" type="text/css" href="./user/css/main.css">
<!--===============================================================================================-->
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script src="./js/jquery-3.6.0.js"></script>
<script type="text/javascript" src="./user/userLoginJS/userLogin.js"></script>


<link href="./img/title.png" rel="shortcut icon" type="image/x-icon">
<title>기억마켓</title>



		<%
			request.setCharacterEncoding("UTF-8");
		
		%>


<!-- 카카오 스크립트 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">
Kakao.init('824c000c199e69a3e3dc1d068f46bdfc');
console.log(Kakao.isInitialized());


//카카오로그인
	function kakaoLogin() {
       Kakao.Auth.loginForm({
         success: function (response) {
           Kakao.API.request({
             url: '/v2/user/me',
             success: function (response) {
                console.log(response)
                
                var k_email = response.kakao_account.email;
                var k_nickname = response.properties.nickname;
                
                // 연령대, 생일 가져오기
                
                $('#id').val(k_email);
                $('#pw').val(k_nickname);
                $("#loginType").val("kakao");
                
                $('#loginfr').submit();
                
//                  alert(k_id)
//                  alert(k_email)
//                  alert(k_gender)
//                  alert(k_nickname)

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
              alert('카카오 로그아웃 성공')
           },
           fail: function (error) {
             console.log(error)
           },
         })
         Kakao.Auth.setAccessToken(undefined)
       }
     }  




</script>

<script type="text/javascript">
	$(document).ready(function () {

		$("#id").val(Cookies.get('key'));      
	    if($("#id").val() != ""){
	        $("#rememCKB1").attr("checked", true);
	    }
	    
		$("#rememCKB1").change(function(){
		    if($("#rememCKB1").is(":checked")){
		        Cookies.set('key', $("#id").val(), { expires: 7 });
		    }else{
		          Cookies.remove('key');
		    }
		});
		     
		$("#id").keyup(function(){
		    if($("#rememCKB1").is(":checked")){
		        Cookies.set('key', $("#id").val(), { expires: 7 });
		    }
		});	

	});
</script>

</head>
<body>

	<%
	
	String error = request.getParameter("error"); 
	if(error != null && error.equals("1")) {
		%>
		<script type="text/javascript">
			alert("아이디 또는 비밀번호 오류 입니다");
		</script>
		
	<%
	}
	
	%>
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-l-85 p-r-85 p-t-55 p-b-55">
				<form class="login100-form validate-form flex-sb flex-w" action="./UserLoginAction.us" id="loginfr">
					<a href="./Main.do"><img src="./img/logo_1.png" style="width: 380px; margin-bottom: 50px"></a>
					<span class="login100-form-title p-b-32" style="color: #59ab6e;">
						Login
					</span>
					
					<input type="hidden" id="loginType" name="loginType" value="normal">

					<span class="txt1 p-b-11">
						email
					</span>
					<div class="wrap-input100 validate-input m-b-36" data-validate = "이메일을 입력하세요">
						<input class="input100" type="text" id="id" name="id" placeholder="이메일">
						<span class="focus-input100"></span>
					</div>
					
					<span class="txt1 p-b-11">
						Password
					</span>
					<div class="wrap-input100 validate-input m-b-12" data-validate = "비밀번호를 입력하세요">
						<span class="btn-show-pass">
							<i class="fa fa-eye"></i>
						</span>
						<input  class="input100" type="password" id="pw" name="pw" placeholder="비밀번호">
						
						<span class="focus-input100"></span>
					</div>
					
					<div class="flex-sb-m w-full p-b-48">
						<div class="contact100-form-checkbox">
							<input class="input-checkbox100" id="rememCKB1" type="checkbox" name="remember">
							<label class="label-checkbox100" for="rememCKB1">
								아이디 기억하기
							</label>
						</div>

						<div>
							<a href="#" class="txt3">
								아이디 / 비밀번호 찾기
							</a>
						</div>
					</div>
					
					<div class="container-login100-form-btn">
						<input class="login100-form-btn" type="submit" id="login" value="Login" style="width: 100%"><br>
						<img src="./img/kakao_login.png" onclick="kakaoLogin();" style="width: 100%; margin-top: 5px">
					</div>
						<a href="./UserJoinChk.us" style="margin-top:30px;margin-left:40%;font-size: 17px">회원가입</a>
				</form>
			</div>
		</div>
	</div>
	

	<div id="dropDownSelect1"></div>



	
















	
<!--===============================================================================================-->
	<script src="./user/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="./user/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="./user/vendor/bootstrap/js/popper.js"></script>
	<script src="./user/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="./user/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="./user/vendor/daterangepicker/moment.min.js"></script>
	<script src="./user/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="./user/vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="./user/js/main.js"></script>
	
</body>
</html>