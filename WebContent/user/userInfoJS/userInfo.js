

function checkPw() {
	
	var pw = document.getElementById("pw").value;
	var pw_check = document.getElementById("pw_check").value;

	if (pw.length == 0) {
		$('#pw_error').css('color','red');
		$('#pw_error').html('비밀번호를 입력하여 주세요.');
		pwFlag = false;
	} else if (pw.length < 8) {
		$('#pw_error').css('color','red');
		$('#pw_error').html('비밀번호는 8자리 이상 이여야 합니다.');
		pwFlag = false;
	} else if(!engCheck.test(pw) || !numCheck.test(pw) || !specialCheck.test(pw)) {
		$('#pw_error').css('color','red');
		$('#pw_error').html('영문,숫자,특수문자를 포함해야 합니다.');
		pwFlag = false;
	} else if (pw != pw_check) {
		$('#pw_error').css('color','red');
		$('#pw_error').html('비밀번호가 다릅니다.');
		pwFlag = false;
	} else if(pw == pw_check){
		$('#pw_error').css('color','green');
		$('#pw_error').html('비밀번호가 일치 합니다.');
		pwFlag = true;
	}
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