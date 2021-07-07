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
		
		
<script type="text/javascript">
	$(document).ready(function () {
		
		$("#user_phone").focus();
		
		var pchk1= /^010([0-9]{8})$/;
		var pchk2 = /^01([1|6|7|8|9])([0-9]{3})([0-9]{4})$/;
		var pchkBtn = 0;
		var Code = "";
		
		$("#user_phone").keyup(function(){
			var phone = $("#user_phone").val();
			if(phone == null) {
			      $('.phoneError').css('color','red');
			      $('.phoneError').html('연락처를 를 입력해 주세요.');
			      pchkBtn = 0;
			 }else if(phone.match(pchk1) != null || phone.match(pchk2) != null){
			        $.ajax({
						 url:'./UserPhoneChk.us',
					     type:'post',
					     data:{"user_phone":phone}, 
					     success:function(data){
					    	 if(data == 1){
					    		 $('.phoneError').css('color','red');
							     $('.phoneError').html('가입된 번호입니다.');
							     pchkBtn = 0;
					    	 }else if(data == 0){
					    		 $('.phoneError').css('color','green');
						      	 $('.phoneError').html('사용 가능 합니다.');
						      	pchkBtn = 1;
					    	 }
				               },
				        		error:function(){
				                alert("에러입니다");
				               }
				       }); // 전화번호 중복체크
			        
			        
		    }else {
		    	  $('.phoneError').css('color','red');
			      $('.phoneError').html('연락처를 정확히 입력하세요');
			      pchkBtn = 0;
		     }
		});
		
		
		//인증번호 체크 모달 보이기
		$("#phoneChk").click(function () {
			var phone = $("#user_phone").val();
			if(pchkBtn == 1){
				$.ajax({
					 url:'./UserPhoneCodeAction.us',
				     type:'post',
				     data:{"user_phone":phone}, 
				     success:function(data){
				    	 Code = data;
				    	 alert("인증번호가 발송되었습니다.");
				    	 $("#modal").show();
				    	 $("#phoneCode").focus();
				    	 
			               },
			        		error:function(){
			                alert("에러입니다");
			               }
			       }); // 인증번호 보내기
				
			}
		});//인증번호 체크 모달 보이기
		
		
		//인증 모달 끄기
		$("#msgExit").click(function () {
			 $("#phoneCode").val("");
			 $('.phoneModal').hide();
		});//인증 모달 끄기
		
		
		
		//인증 번호 체크
		$("#phoneCodeChk").click(function(){
			var  phoneC = $("#phoneCode").val();
			
			if(phoneC == Code){
				$('#fr').submit();
				alert("인증되었습니다.");
			}else{
				alert("인증번호가 일치하지 않습니다. 다시 입력해 주세요");
			}
				
		});
		//인증 번호 체크
		
		
		
		
		
	});
	
	
	
	
</script>

</head>
<body>
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-l-85 p-r-85 p-t-55 p-b-55">
				<form action="./UserJoin.us" method="post"  id="fr">
					<a href="./Main.do"><img src="./img/logo_1.png" style="width: 380px; margin-bottom: 50px"></a>
					<span class="login100-form-title p-b-32" style="color: #59ab6e;margin-top: 20px;margin-bottom: 30px">
						문자인증
					</span>
					
					<span class="txt1 p-b-11">
						phone
					</span>
					<span class="phoneError" style="float: right;"></span>
					<div class="wrap-input100 validate-input" data-validate = "전화번호를 입력하세요">
						<input class="input100" type="number" id="user_phone" name="user_phone" placeholder="전화번호" >
						<span class="focus-input100"></span>
					</div>
									
					<div class="container-login100-form-btn" style="margin-top: 40px">
						<input class="login100-form-btn" type="button" id="phoneChk" value="문자인증" style="width: 100%"><br>
					</div>
				</form>	
			</div>
		</div>
	</div>
	
	

		<div id="dropDownSelect1"></div>
	
	
	
		<!-- 인증번호 모달 Start -->
	    <div id="modal" class="phoneModal">
	    <div class="phone-modal-content">
	   				 <img src="./img/exit.png" style="width: 35px; float: right;" id="msgExit">
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