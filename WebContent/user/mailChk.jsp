<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>

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

	<%
		String content = (String)session.getAttribute("content");
		String id= (String)session.getAttribute("id");
		if(id != null){
			%>
			<script type="text/javascript">
				alert("해당 메일로 인증번호가 발송되었습니다");
			</script>
		<%
		}
		session.removeAttribute("id");
		

		request.setCharacterEncoding("UTF-8");
		
	%>

</head>
<body>
	
<script type="text/javascript">
	
	function check() {
		var code = document.fr.con_chk.value;
		var authNum = <%=content %>;
		
		if(!code) {
			alert("인증번호를 입력해주세요");
			return;
		}
		
		if(authNum == code) {
			
			alert("인증 되었습니다.");
			
		<%
			session.removeAttribute("content");
		
		%>
			
			fr.submit();
		
			
		} else {
			alert("인증번호가 다릅니다. 다시 입력해 주세요.");
			return;
		}
	}
</script>
	
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-l-85 p-r-85 p-t-55 p-b-55">
				<form class="login100-form validate-form flex-sb flex-w" action="./UserJoin.us" id="fr" name="fr" method="post">
					<a href="./Main.do"><img src="./img/logo.png"></a>
					<span class="login100-form-title p-b-32" style="color: #59ab6e;margin-top: 20px;margin-bottom: 30px">
						인증번호
					</span>

			 		<input type="hidden" name="id" value=<%=id %>>
					<span class="txt1 p-b-11">
						인증번호
					</span>
					<span class="chkMsg_umail"></span>  
					<div class="wrap-input100 validate-input m-b-36" data-validate = "인증번호를 입력하세요">
						<input class="input100" type="text" name="con_chk" placeholder="인증번호" >
						<span class="focus-input100"></span>
					</div>
					
					<div class="container-login100-form-btn">
						<input class="login100-form-btn" type="button" id="login"  onclick="check();" value="메일인증" style="width: 100%"><br>
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