<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

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
		
		var pchk1= /^010([0-9]{8})$/;
		var pchk2 = /^01([1|6|7|8|9])([0-9]{3})([0-9]{4})$/;
		var pchkBtn = 0;
		var Code = "";
		var phone = "";
		var userID="";
		var userPW="";
		
		$("#user_phone").keyup(function(){
			phone = $("#user_phone").val();
			if(phone == null) {
			      $('.phoneError').css('color','red');
			      $('.phoneError').html('연락처를 를 입력해 주세요.');
			      pchkBtn = 0;
			 }else if(phone.match(pchk1) != null || phone.match(pchk2) != null){
				 $('.phoneError').html('');
				 pchkBtn = 1;
		     }else {
		    	  $('.phoneError').css('color','red');
			      $('.phoneError').html('연락처를 정확히 입력하세요');
			      pchkBtn = 0;
		     }
		});

		// 아이디 기억하기
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
		});	// 아이디 기억하기
		
		
		//아이디 찾기 모달 보이기
		$("#searchID").click(function () {
			 $("#searchIDModal").show();
			 $("#user_phone").focus();
		});//아이디 찾기 모달 보이기
		
		
		//비밀번호 찾기 모달 보이기
		$("#searchPW").click(function () {
			 $("#searchPWModal").show();
		});//비밀번호 찾기 모달 보이기
		
		
		//아이디찾기 모달 끄기
		$("#searchIDExit").click(function () {
			 $('.phoneError').html("");
			 $("#user_phone").val("");
			 $('#searchIDModal').hide();
		});//아이디찾기 모달 끄기
		
		
		//인증 모달 끄기
		$(".msgExit").click(function () {
			location.reload();
		});//인증 모달 끄기
		
		
		// 아이디찾기 인증번호 발송
		$("#IDphoneCode").click(function () {
		if(pchkBtn == 1){
			$.ajax({
				 url:'./UserPhoneCodeAction.us',
			     type:'post',
			     data:{"user_phone":phone}, 
			     success:function(data){
			    	 Code = data;
			    	 alert("인증번호가 발송되었습니다.");
			    	 $("#searchIDModal").html($("#modal"));
					 $("#modal").removeClass('modalHidden');
					 $("#phoneCode").focus();
		               },
		        		error:function(){
		                alert("에러입니다");
		               }
		       }); // 인증번호 보내기
			 
		}
		});// 아이디찾기 인증번호 발송
		
		
		
		//인증 번호 체크
		$("#phoneCodeChk").click(function(){
			var  phoneC = $("#phoneCode").val();
			if(phoneC == Code){
				$.ajax({
					 url:'./UserSearchId.us',
				     type:'post',
				     data:{"user_phone":phone}, 
				     success:function(data){
				    	alert("인증되었습니다.");
						$("#searchIDModal").html($("#userInfo"));
						$("#userInfo").removeClass('modalHidden');	 
					 	$(".userInfoID").html(data);
				     },
			        error:function(){
			        alert("에러입니다");
			        }
			    }); // 회원 정보 반환
			}else{
				alert("인증번호가 일치하지 않습니다. 다시 입력해 주세요");
			}
				
		});
		//인증 번호 체크
		
		
		
		
		
		
		

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
							<label class="label-checkbox100" for="rememCKB1" style="color: black;">
								아이디 기억하기
							</label>
						</div>

						<div>
							<i class="fa fa-lock" style="float:left;"></i>
							<p id="searchID" class="stxt3" style="float:left; margin-right: 10px; margin-left: 5px">아이디 </p>
							<p class="stxt3" style="float:left;"> | </p>
							<p id="searchPW" class="stxt3" style="float:left; margin-left: 10px"> 비밀번호 찾기</p>
							
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



		<!-- 아이디찾기 모달 Start -->
	 	<div id="searchIDModal" class="searchIDModal">
	    <div class="searchID-modal-content">
	   				 <img src="./img/exit.png" style="width: 35px; float: right;" id="searchIDExit">
					<span class="login100-form-title p-b-32" style="color: #59ab6e;margin-top: 20px;margin-bottom: 30px">
						아이디 찾기
					</span>
					<div style="margin-bottom: 30px">
						<i class="fa fa-phone" style="font-size: 25px; margin-top: 7px; margin-left: 10px; margin-right: 10px; float:left;"></i>
						<p style="font-size: 25px; font-weight: 2px;">회원정보에 등록된 전화번호로 아이디 찾기</p>
						<p style="margin-left: 40px;font-size: 17px;">회원정보에 등록된 전화번호와 입력한 전화번호가 일치해야 합니다.</p>	
					</div>
					<span class="phoneError" style="margin-left: 5px"></span>
					<div class="wrap-input100 validate-input" data-validate = "전화번호를 입력하세요">
						<input class="input100 user_phone_ID" type="number" id="user_phone" placeholder="전화번호" >
						<span class="focus-input100"></span>
					</div>
					<div class="container-login100-form-btn" style="margin-top: 40px; margin-bottom: 20px">
						<input class="login100-form-btn" type="button" id="IDphoneCode" value="인증번호 받기" style="width: 100%"><br>
					</div>
	        </div>
	    </div>
	    <!-- 아이디찾기 모달 END -->	
	    
	    
	    <!-- 인증번호 모달 Start -->
	    <div id="modal" class="phoneModal02 modalHidden">
	    <div class="phone02-modal-content">
	   				 <img src="./img/exit.png" style="width: 35px; float: right;" class="msgExit">
					<span class="login100-form-title p-b-32" style="color: #59ab6e;margin-top: 20px;margin-bottom: 30px">
						문자인증
					</span>
					
					<span class="txt1 p-b-11" style="font-size: 20px">
						인증번호
					</span>
					<div class="wrap-input100 validate-input" data-validate = "인증번호를 입력하세요">
						<input class="input100" type="text" id="phoneCode" name="phoneCode" placeholder="인증번호" >
						<span class="focus-input100"></span>
					</div>
									
					<div class="container-login100-form-btn" style="margin-top: 40px">
						<input class="login100-form-btn" type="button" id="phoneCodeChk" value="확인" style="width: 100%"><br>
					</div>
	        </div>
	    </div>
	    <!-- 인증번호 모달 END -->	
	    
	    
	    <!-- 회원 정보 모달 Start -->
	    <div id="userInfo" class="userInfo modalHidden">
	    <div class="userInfo-modal-content">
					<img src="./img/exit.png" style="width: 35px; float: right;" class="msgExit">
					<span class="login100-form-title p-b-32" style="color: #59ab6e;margin-top: 20px;margin-bottom: 30px">
						아이찾기
					</span>
					<div style="margin-bottom: 80px; margin-left: 10px; margin-right: 10px">
					<div style="margin-bottom: 30px">
						<span class="txt1 p-b-11" style="font-size: 20px; margin-right: 10px">
							회원님의 <b>아이디</b>는
						</span>
						<b>
						<span class="userInfoID" style="font-size: 25px;color:#59ab6e;">
						</span>
						</b>
						<span class="txt1 p-b-11" style="font-size: 20px; margin-left: 10px">
							입니다.
						</span>
					</div>
					<input class="login100-form-btn" type="button" value="비밀번호찾기" style="width: 30px;float: right;"><br>
					</div>
	        </div>
	    </div>
	    <!-- 회원 정보 END -->	
	   
		




		<!-- 비밀번호 찾기 모달 Start -->
	 	<div id="searchPWModal" class="searchPWModal">
	    <div class="searchPW-modal-content">
	   				 <img src="./img/exit.png" style="width: 35px; float: right;" id="msgExit">
					<span class="login100-form-title p-b-32" style="color: #59ab6e;margin-top: 20px;margin-bottom: 30px">
						비밀번호 찾기
					</span>
					<p style="color: black; font-size: 20px">비밀번호를 찾는 방법을 선택해 주세요.</p>
					<div style="margin-top: 50px">
						<div>
						<input type="checkbox" style="zoom:1.5;margin-top: 5px">
						<i class="fa fa-phone" style="font-size: 20px; margin-top: 4px; margin-left: 10px"></i>
						<span style="margin-left: 10px">회원정보에 등록한 휴대전화로 인증</span>		
						</div>
						<br>
						<div>
						<input type="checkbox" style="zoom:1.5; margin-top: 5px">
						<i class="fa fa-envelope" style="font-size: 15px; margin-top: 4px; margin-left: 10px"></i>
						<span style="margin-left: 10px">회원정보에 등록한 이메일로 인증</span>
						</div>
					</div>
	        </div>
	    </div>
		<!-- 비밀번호 찾기 모달 End -->











	
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