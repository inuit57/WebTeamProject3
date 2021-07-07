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

</head>
<body>
	<%
	String id = (String)session.getAttribute("id");
	if(id != null){
		%>
		<script type="text/javascript">
			alert("해당 메일이 등록된 아이디가 있습니다");
		</script>
	<%
	}
	session.removeAttribute("id");
	
	%>
<script type="text/javascript">
	
	 var chkup = false;
	 
			$(document).ready(function(){
				$("#fr").submit(function(){
					 if($.trim($("#id").val()) == null){
						 $('.chkMsg_umail').text("이메일을 입력하세요");     
			             $('.chkMsg_umail').css("color","red"); 
			             $('.chkMsg_umail').css("padding-left","1rem"); 
			             $("#id").focus();
			             return false;
					 }
					 if(chkup == false){
						 return false;
					 }
				 });
				
				 $("#id").keyup(function(){
					  
						var umail = $("#id").val();
						var chk = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
						
						if(umail.match(chk) != null){
							$('.chkMsg_umail').text("");     
							chkup = true;  
						}else{
							$('.chkMsg_umail').text("이메일을 정확히 입력하세요");     
							$('.chkMsg_umail').css("color","red"); 
							$('.chkMsg_umail').css("padding-left","1rem");
							chkup = false; 
						}
					 	});
			
			});
	</script>
	
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-l-85 p-r-85 p-t-55 p-b-55">
				<form class="login100-form validate-form flex-sb flex-w" action="./UserEmailSendAction.us" id="fr">
					<a href="./Main.do"><img src="./img/logo_1.png" style="width: 380px; margin-bottom: 50px"></a>
					<span class="login100-form-title p-b-32" style="color: #59ab6e;margin-top: 20px;margin-bottom: 30px">
						이메일 인증
					</span>
					
					<span class="txt1 p-b-11">
						email
					</span>
					<span class="chkMsg_umail"></span>  
					<div class="wrap-input100 validate-input m-b-36" data-validate = "이메일을 입력하세요">
						<input class="input100" type="text" id="id" name="id" placeholder="이메일" >
						<span class="focus-input100"></span>
					</div>
					
					<div class="container-login100-form-btn">
						<input class="login100-form-btn" type="submit" id="login" value="메일인증" style="width: 100%"><br>
					</div>
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