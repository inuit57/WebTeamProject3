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
                
                
                
                kakaoEmailChk(k_email,k_nickname);
                
                

                // 연령대, 생일 가져오기
                
/*                 $('#id').val(k_email);
            	$('#user_nickname').val(k_nickname);
                $("#loginType").val("kakao");
                
                $('#fr').submit(); */
                
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
 
 
 
 
   function kakaoEmailChk(k_email,k_nickname){
	   $.ajax({
			 url:'./UserIdCheckAction.us',
		     type:'post',
		     data:{"id":k_email}, 
		     success:function(data){
		    	if(data.trim() == 1){
		    	 alert("가입된 이메일입니다.");
	    	 	 location.href="./UserJoinChk.us";
	    		}else{
	    			 $('#id').val(k_email);
	             	 $('#user_nickname').val(k_nickname);
	                 $("#loginType").val("kakao");
	                 $('#fr').submit();
	    		}
		     }
		 })
	  }

      
      

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
				<form class="login100-form validate-form flex-sb flex-w" action="./UserJoin.us" id="fr" method="post">
					<a href="./Main.do"><img src="./img/logo_1.png" style="width: 380px; margin-bottom: 50px"></a>
					<span class="login100-form-title p-b-32" style="color: #59ab6e;">
						Join
					</span>
					
					<input  type="hidden" id="id" name="id">  
					<input  type="hidden" id="user_nickname" name="user_nickname">  
					<input type="hidden" id="loginType" name="loginType" value="normal">
					
					<div>
					<p style="font-size: 20px; color: black;">기억마켓 회원가입을 환영합니다!</p>
					<p style="font-size: 20px; color: #59ab6e;">가입 방법을 선택 후 진행해주세요</p>
					</div>
					
					<div class="container-login100-form-btn" style="margin-top: 50px">
						<input class="login100-form-btn" type="button" onclick="location.href='./UserEmail.us'" value="이메일 인증으로 가입" style="width: 100%;"><br>
						<i class="fa fa-envelope" style="color: white; margin-top: -37px; margin-left: 20px"></i>
						
						<input class="login100-form-btn" type="button" onclick="location.href='./UserPhone.us'" value="문자 인증으로 가입" style="width: 100%;margin-top: 5px"><br>
						<i class="fa fa-phone" style="color: white; margin-top: -37px; margin-left: 20px; font-size: 25px"></i>
						
						<img src="./img/kakao_join.png" onclick="kakaoLogin();" style="width: 100%; margin-top: 5px">
					</div>
						<a href="./UserLogin.us" style="margin-top:30px;margin-left:40%;font-size: 17px">로그인</a>
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