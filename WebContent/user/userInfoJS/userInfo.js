//이메일 형식 검사 정규식
var verifyEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
//닉네임 형식 검사 정규식
var verifyNick = /[0-9]|[a-z]|[A-Z]|[가-힣]/;

var korCheck = /[가-힣]/;
var engCheck = /[a-z]/; 
var numCheck = /[0-9]/; 
var specialCheck = /[`~!@#$%^&*|\\\'\";:\/?]/;

//유효성 체크 Flag
var idFlag = false;
var nickFlag = false;
var pwFlag = false;
var phoneFlag = false;
var addressFlag = false;
var address_plusFlag = false;
var email_Flag = false;
//<!-- ------------------------test---------------------------- -->
$(document).ready(function() {
	 var $tablink = $(".tab_title li").click(function() {
	    var idx = $tablink.index(this);
	    $(".tab_title li").removeClass("on");
	    $(".tab_title li").eq(idx).addClass("on");
	    $(".tab_cont > div").hide();
	    $(".tab_cont > div").eq(idx).show();
	  })
	});
//<!-- ------------------------test---------------------------- -->
  
   

function Infocheck() {
	checkNick();
	checkPhone();
	addressCheck();
	
	if(nickFlag == false) {
		return false;
	} else if(phoneFlag == false) {
		return false;
	} else if(addressFlag == false) {
		return false;
	} else if(address_plusFlag == false) {
		return false;
	} else {
		return true;
	}
}

function checkNick() {
	
	var nickname = document.getElementById("user_nick").value;
	
	if(nickname.length == 0) {
		$('#nickname_error').css('color','red');
		$('#nickname_error').html('닉네임을 입력하여 주세요.');
		nickFlag = false;
	} else if(nickname.length > 8) {
		$('#nickname_error').css('color','red');
		$('#nickname_error').html('닉네임은 8글자 이하여야 합니다.');
		nickFlag = false;
	} else if(specialCheck.test(nickname)) {
		$('#nickname_error').css('color','red');
		$('#nickname_error').html('특수 문자는 사용 불가능 합니다.');
		nickFlag = false;
	} else if(nickname.search(/\s/) != -1) {
		$('#nickname_error').css('color','red');
		$('#nickname_error').html('닉네임은 공백을 포함할 수 없습니다.');
		nickFlag = false;
	} else {
		$(function(){
			$.ajax('./UserNickCheckAction.us', {
				data : {nickname:nickname},
				success: function(data) {
					if(data == 0) {
						$('#nickname_error').css('color','green');
						$('#nickname_error').html('사용 가능한 닉네임 입니다.');
						nickFlag = true;
					} else {
						$('#nickname_error').css('color','red');
						$('#nickname_error').html('사용 중인 닉네임 입니다.');
						nickFlag = false;
					}
				}
			});
		});
		
	}
	
}

function checkPhone() {
	var phone = document.getElementById("user_phone").value;
	
	if(phone == "") {
		$('#phone_error').css('color','red');
		$('#phone_error').html('휴대폰 번호를 입력해 주세요.');
		phoneFlag = false;
	} else if(phone.length != 11) {
		$('#phone_error').css('color','red');
		$('#phone_error').html('휴대폰 번호를 확인해 주세요');
		phoneFlag = false;
	} else {
		$('#phone_error').css('color','green');
		$('#phone_error').html('사용 가능한 휴대폰 번호 입니다.');
		phoneFlag = true;
	}
}

function addressCheck() {
	var address = document.getElementById("user_address").value;
	var address_plus = document.getElementById("user_address_plus").value;
	
	if(address == "") {
		$('#address_error').css('color','red');
		$('#address_error').html('주소 찾기를 눌러주세요.');
		addressFlag = false;
	} else if(address_plus == "") {
		$('#address_error').css('color','red');
		$('#address_error').html('상세 주소를 입력하세요.');
		address_plusFlag = false;
	} else {
		$('#address_error').css('color','green');
		$('#address_error').html('사용 가능한 주소 입니다.');
		addressFlag = true;
		address_plusFlag = true;
	}
	
}

function checkPw() {
	var new_pw = document.getElementById("new_pw").value;
	var new_pw_check = document.getElementById("new_pw_check").value;
	var pwFlag = false ; 
	
	if ( new_pw.length == 0 ) {
		alert('비밀번호를 입력하여 주세요.');
		pwFlag = false;
	} else if (new_pw.length < 8  ) {
		alert('비밀번호는 8자리 이상 이여야 합니다.');
		pwFlag = false;
	} else if(!engCheck.test(pw) || !numCheck.test(pw) || !specialCheck.test(pw)) {
		alert('영문,숫자,특수문자를 포함해야 합니다.');
		pwFlag = false;
	} else if (new_pw != new_pw_check) {
		alert('비밀번호가 다릅니다.');
		pwFlag = false;
	} else if(new_pw == new_pw_check){
		alert('비밀번호가 일치 합니다.');
		pwFlag = true;
	}
	
	return pwFlag ; 
} 



function findAddr(){
	new daum.Postcode({
        oncomplete: function(data) {
        	
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var jibunAddr = data.jibunAddress; // 지번 주소 변수
            
            if(roadAddr !== ''){
                document.getElementById("user_address").value = '(' + data.zonecode + ')' + roadAddr;
            } 
            else if(jibunAddr !== ''){
                document.getElementById("user_address").value = '(' + data.zonecode + ')' + jibunAddr;
            }
        }
    }).open();
}

function check() {
	var bName = document.getElementById("bankname").value;
	var bNum = document.getElementById("bankaccount").value;
	
	if(bName == "none") {
		alert('은행 이름을 선택하여 주세요');
		return false;
	} else if(bNum == "") {
		alert('계좌 번호를 입력하여 주세요.');
		return false;
	} else {
		return true;
	}
	
	
}

