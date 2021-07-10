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
    <link rel="stylesheet" href="./user/css/style.css">
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
		
		$('#loading').hide();		
		
		var pchk1= /^010([0-9]{8})$/;
		var pchk2 = /^01([1|6|7|8|9])([0-9]{3})([0-9]{4})$/;
		var pchkBtn = 0;
		var Code = "";
		var phone = "";
		var UID = "";
		
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
						if(data == ""){
							$(".nonmember").html("<b>해당 번호로 가입된 아이디가 없습니다.</b>");
						}else{
					 		$(".userInfoID").html(data);
					 		UID = data;
						}
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
		
		
		//비밀번호 찾기 모달 보이기
		$("#searchPW").click(function () {
			 $("#searchPWModal").removeClass('modalHidden');	
		});//비밀번호 찾기 모달 보이기
		
		
		
		//비밀번호 찾기 아이디 체크
		$("#pwIdChk").click(function(){
			UID = $("#searchUID").val();
			if(UID != ""){
				$.ajax({
					 url:'./UserIdCheckAction.us',
				     type:'post',
				     data:{"id":UID}, 
				     success:function(data){
						if(data == "1"){
							 $("#searchPWModal").html($("#searchPWModal02"));
							 $("#searchPWModal02").removeClass('modalHidden');	
						}else{
							alert("비회원입니다.");
							location.reload();
						}
				     },
			        error:function(){
			        alert("에러입니다");
			        }
			    }); // 회원 정보 반환
			}else{
				alert("아이디를 입력하세요.");
			}
				
		});
		//비밀번호 찾기 아이디 체크
		
		
		//비밀번호 찾기 문자인증
		$("#pwIdChkCodeSend").click(function(){
			phone = $("#pwIdChkInput").val();
			if(phone != ""){
				$.ajax({
					 url:'./UserPhoneCodeAction.us',
				     type:'post',
				     data:{"user_phone":phone}, 
				     success:function(data){
				    	 Code = data;
				    	 alert("인증번호가 발송되었습니다.");
				    	    $(".acoPwIDChk").html($(".acoPwIDChk02"));
							$(".acoPwIDChk02").removeClass('modalHidden');
							$("#pwIdChkInput02").val(phone);
			               },
			        		error:function(){
			                alert("에러입니다");
			               }
			       }); // 인증번호 보내기
				 
			}else{
				alert("전화번호를 입력하세요.");
			}
		});
		//비밀번호 찾기 문자인증
		
		
		//비밀번호 찾기 인증 번호 체크
		$("#pwIdCodeChk").click(function(){
			phoneC = $("#pwIdChkCodeInput").val();
			if(phoneC == Code){
				$.ajax({
					 url:'./UserPhoneChk.us',
				     type:'post',
				     data:{"user_phone":phone}, 
				     success:function(data){
						if(data == "0"){
							alert("등록된 전화번호와 일치하지 않습니다.");
							location.reload();
						}else{
							 alert("인증되었습니다.");
							 $("#searchPWModal02").html($("#newPw"));
							 $("#newPw").removeClass('modalHidden');	
							 $("#updatePW_phone").val(phone);
						}
				     },
			        error:function(){
			        alert("에러입니다");
			        }
			    }); // 회원 정보 반환
			}else{
				alert("인증번호가 일치하지 않습니다. 다시 입력해 주세요");
			}
				
		});
		//비밀번호 찾기 인증 번호 체크
		
		var NewPwChk = 0;
		// 새 비밀번호 유효성
		$(".NewPW").keyup(function(){
			   var NewPw01 = $("#NewPw01").val();
			   var NewPw02 = $("#NewPw02").val();
			   var pw_chk = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,16}$/.test(NewPw01);
			   if (NewPw01 == null) {
			      $('.pw_error01').css('color','red');
			      $('.pw_error01').text('비밀번호를 입력하세요.');
			      NewPwChk = 0;
			   } else if(!pw_chk) {
			      $('.pw_error01').css('color','red');
			      $('.pw_error01').text('대소문자,숫자,특수문자 중 세가지를 조합한 8~16자리를 입력하세요.');
			      NewPwChk = 0;
			   } else if (NewPw01 != NewPw02) {
				   $('.pw_error01').text('');
			      $('.pw_error02').css('color','red');
			      $('.pw_error02').text('비밀번호가 다릅니다.');
			      NewPwChk = 0;
			   } else if(NewPw01 == NewPw02){
				   $('.pw_error01').text('');
			      $('.pw_error02').text('');  
			      NewPwChk = 1;
			   }
		});	// 새 비밀번호 유효성
		
		
		// 새 비밀번호 update
		$("#NewPwBtn").click(function(){
			   if (NewPwChk == 1) {
				   $("#updatePw").submit();
				   alert("비밀번호가 변경되었습니다.");
			   } 
		})
		// 새 비밀번호 update
		
		
		// 비밀번호 찾기 메일 인증
		$("#pwMailChkCodeSend").click(function(){
			$('#loading').show();
			$.ajax({
				 url:'./UserMailSendAction.us',
			     type:'post',
			     data:{"id":UID}, 
			     success:function(data){
			    	 Code = data;
			    	 alert("인증번호가 발송되었습니다.");
			    	 $('#loading').hide();
			    	 $(".acoPwIDChk03").html($(".acoPwIDChk04"));
					 $(".acoPwIDChk04").removeClass('modalHidden');
			     		},
		        		error:function(){
		                alert("에러입니다");
		               }
		       }); // 인증번호 보내기
		})
		//  비밀번호 찾기 메일 인증
		
		
		//비밀번호 찾기 인증 번호 체크
		$("#pwMailChkCode").click(function(){
			phoneC = $("#pwMailChkInput").val();
			if(phoneC == Code){
				    alert("인증되었습니다.");
					$("#searchPWModal02").html($("#newPw"));
					$("#newPw").removeClass('modalHidden');
					$("#updatePW_id").val(UID);
			}else{
				alert("인증번호가 일치하지 않습니다. 다시 입력해 주세요");
			}
				
		});
		//비밀번호 찾기 인증 번호 체크
		
		
		

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
	
	
	
	<div id="loading" style="display: none;">
    <img src="./img/Loding.gif" alt="loading">
	</div>


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
							<i class="fa fa-lock" style="float:left; margin-top: 5px"></i>
							<p id="searchID" class="stxt3" style="float:left; margin-right: 10px; margin-left: 5px">아이디 </p>
							<p class="stxt3" style="float:left;"> | </p>
							<p id="searchPW" class="stxt3" style="float:left; margin-left: 10px"> 비밀번호 찾기</p>
							
						</div>
					</div>
					
					<div class="container-login100-form-btn">
						<input class="login100-form-btn" type="submit" id="loginUser" value="Login" style="width: 100%"><br>
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
						<p style="font-size: 25px; font-weight: 2px;">회원정보에 등록된 <b>전화번호</b>로 아이디 찾기</p>
						<p style="margin-left: 40px;font-size: 17px;">회원정보에 등록된 전화번호와 입력한 전화번호가 일치해야 합니다.</p>	
					</div>
					<span class="phoneError" style="margin-left: 5px"></span>
					<div class="wrap-input100 validate-input" data-validate = "전화번호를 입력하세요">
						<input class="user_phone_ID" type="number" id="user_phone" placeholder="전화번호">
						<span class="focus-input100"></span>
					</div>
					<div class="container-login100-form-btn" style="margin-top: 40px; margin-bottom: 20px">
						<input class="login100-form-btn" type="button" id="IDphoneCode" value="인증번호 받기" style="width: 100%"><br>
					</div>
	        </div>
	    </div>
	    <!-- 아이디찾기 모달 END -->	
	    
	    
		<!-- 	    인증번호 모달 Start -->
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
						<input class="user_phone_ID" type="text" id="phoneCode" name="phoneCode" placeholder="인증번호" >
						<span class="focus-input100"></span>
					</div>
									
					<div class="container-login100-form-btn" style="margin-top: 40px">
						<input class="login100-form-btn" type="button" id="phoneCodeChk" value="확인" style="width: 100%"><br>
					</div>
	        </div>
	    </div>
<!-- 	    인증번호 모달 END	 -->
	    
	    
	    <!-- 회원 정보 모달 Start -->
	    <div id="userInfo" class="userInfo modalHidden">
	    <div class="userInfo-modal-content">
					<img src="./img/exit.png" style="width: 35px; float: right;" class="msgExit">
					<span class="login100-form-title p-b-32" style="color: #59ab6e;margin-top: 20px;margin-bottom: 30px">
						아이찾기
					</span>
					<div style="margin-bottom: 80px; margin-left: 10px; margin-right: 10px">
					<div style="margin-bottom: 30px">
						<span class="txt1 p-b-11 nonmember" style="font-size: 20px; margin-right: 10px">
							<b>아이디</b> :
						</span>
						<b>
						<span class="userInfoID" style="font-size: 25px;color:#59ab6e;">
						</span>
						</b>
					</div>
					</div>
	        </div>
	    </div>
	    <!-- 회원 정보 END -->	
	   


		<!-- 비밀번호 찾기 ID체크  Start -->
	 	<div id="searchPWModal" class="searchPWModal modalHidden">
	    <div class="searchPW-modal-content">
	   				<img src="./img/exit.png" style="width: 35px; float: right;" class="msgExit">
					<span class="login100-form-title p-b-32" style="color: #59ab6e;margin-top: 20px;margin-bottom: 30px">
						비밀번호 찾기
					</span>
					<div style="margin-bottom: 30px">
						<i class="fa fa-user" style="font-size: 25px; margin-top: 10px; margin-left: 10px; margin-right: 10px; float:left;"></i>
						<p style="font-size: 25px; font-weight: 2px;">찾으실 <b>아이디</b>를 입력하세요 </p>
					</div>
					<span class="phoneError" style="margin-left: 5px"></span>
					<div class="wrap-input100 validate-input" data-validate = "아이디를 입력하세요">
						<input class="user_phone_ID" type="text" id="searchUID" placeholder="아이디" >
						<span class="focus-input100"></span>
					</div>
					<div class="container-login100-form-btn" style="margin-top: 40px; margin-bottom: 20px">
						<input class="login100-form-btn" type="button" id="pwIdChk" value="비밀번호 찾기" style="width: 100%"><br>
					</div>
	        </div>
	    </div>
		<!-- 비밀번호 찾기 ID체크 모달 End -->


		<!-- 비밀번호 찾기 모달 Start -->
	 	<div id="searchPWModal02" class="searchPWModal modalHidden">
	    <div class="searchPW-modal-content">
	   				 <img src="./img/exit.png" style="width: 35px; float: right;" class="msgExit">
					<span class="login100-form-title p-b-32" style="color: #59ab6e;margin-top: 20px;margin-bottom: 30px">
						비밀번호 찾기
					</span>
					<p style="color: black; font-size: 20px">비밀번호를 찾는 방법을 선택해 주세요.</p>
					<div style="margin-top: 30px">
						<ul class="accordion">
					      <li class="item">
					         <h2 class="accordionTitle"><i class="fa fa-phone" style="font-size: 20px; margin-top: 4px;"></i>&emsp; 회원정보에 등록한 휴대전화로 인증<span class="accIcon"></span></h2>
					         <div class="text">
					         	<div class="acoPwIDChk" >
						         	<input class="acoInput"  id="pwIdChkInput" type="number" placeholder="전화번호" style="float: right;">
						         	<input class="login100-form-btn" type="button" id="pwIdChkCodeSend" value="인증번호 받기" style="width: 50px;float: right;margin-top: 10px"><br>
					         	</div>
					         	<div class="acoPwIDChk02 modalHidden">
						         	<input class="acoInput"  id="pwIdChkInput02" type="text"  disabled="disabled" style="float: right;">
						         	<input class="acoInput"  id="pwIdChkCodeInput"  placeholder="인증번호를 입력하세요" type="text" style="margin-top: 15px; float: right;">
						         	<input class="login100-form-btn" type="button" id="pwIdCodeChk" value="확인" style="width: 50px; float: right;margin-top: 10px"><br>
					         	</div>
					         </div>
					      </li>
					      <li class="item">
					         <h2 class="accordionTitle"><i class="fa fa-envelope" style="font-size: 15px; margin-top: 4px;"></i>&emsp; 회원정보에 등록한 이메일로 인증<span class="accIcon"></span></h2>
					         <div class="text">
								<div class="acoPwIDChk03" >
						         	<input class="login100-form-btn" type="button" id="pwMailChkCodeSend" value="인증번호 받기" style="width: 50px; margin-top: 10px"><br>
					         	</div>
					         	<div class="acoPwIDChk04 modalHidden">
					         		<input class="acoInput"  id="pwMailChkInput" type="number" placeholder="인증번호를 입력하세요" style="float: right;">
						         	<input class="login100-form-btn" type="button" id="pwMailChkCode" value="확인" style="width: 50px;float: right;margin-top: 10px"><br>
					         	</div>
							 </div>
					      </li>
					   </ul>
					</div>
	        </div>
	    </div>
		<!-- 비밀번호 찾기 모달 End -->



		<!-- 새비밀번호 설정 Start -->
	 	<div id="newPw" class="searchPWModal modalHidden">
	    <div class="searchPW-modal-content">
	   				<img src="./img/exit.png" style="width: 35px; float: right;" class="msgExit">
					<span class="login100-form-title p-b-32" style="color: #59ab6e;margin-top: 20px;margin-bottom: 30px">
						새 비밀번호 설정 
					</span>
					<div style="margin-bottom: 30px">
						<p style="font-size: 25px; font-weight: 2px;">새 비밀번호를 입력하세요 </p>
					</div>
					
					<form action="./UserPwUpdate.us" method="post" id="updatePw">
					<input type="hidden" name="user_phone" id="updatePW_phone" value="0">
					<input type="hidden" name="user_id" id="updatePW_id" value="0">
					<span class="pw_error01" style="margin-left: 5px"></span>
					<div class="wrap-input100 validate-input" data-validate = "새 비밀번호를 입력하세요">
						<input class="user_phone_ID NewPW" type="password" id="NewPw01" name="user_pw" placeholder="새 비밀번호를 입력하세요" >
					</div>
					<span class=pw_error02 style="margin-left: 5px;margin-top: 15px"></span>
					<div class="wrap-input100 validate-input" data-validate = "비밀번호를 한 번 더 입력하세요">
						<input class="user_phone_ID NewPW" type="password" id="NewPw02" name="user_pwChk" placeholder="비밀번호를 한 번 더 입력하세요" >
					</div>
					<div class="container-login100-form-btn" style="margin-top: 40px; margin-bottom: 20px">
						<input class="login100-form-btn" type="button" id="NewPwBtn" value="비밀번호 변경" style="width: 100%"><br>
					</div>
					</form>
	        </div>
	    </div>
		<!-- 새비밀번호 설정 End -->





	
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
	<script  src="./user/js/script.js"></script>
	
</body>
</html>