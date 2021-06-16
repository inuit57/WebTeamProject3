/**
 * 회원 가입 유효성 검사 JS 파일
 * 
 * 아이디 : 이메일 형식
 * 닉네임 : 영문,한글 8글자 이내
 * 비밀번호 : 영문,숫자,특수문자 포함 8~20글자
 * 
 */
//이메일 형식 검사 정규식
var verifyEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
//닉네임 형식 검사 정규식
var verifyNick = /[0-9]|[a-z]|[A-Z]|[가-힣]/;

var korCheck = /[가-힣]/;
var engCheck = /[a-z]/; 
var numCheck = /[0-9]/; 
var specialCheck = /[`~!@#$%^&*|\\\'\";:\/?]/gi;


//데이터 유효성 체크
function check() {
	
	var id = document.getElementById("id").value;
	var nickname = document.getElementById("nickname").value;
	var pw = document.getElementById("pw").value;
	var pw_check = document.getElementById("pw_check").value;
	var phone = document.getElementById("phone").value;
	var address = document.getElementById("address").value;
	var address_plus = document.getElementById("address_plus").value;
	
	
	if(id.length == 0) {
		$('#id_error').html('아이디를 입력하여 주세요.');
		return false;
	} else if(id.match(verifyEmail) == null) {
		$('#id_error').html('아이디는 이메일 형식이여야 합니다.');
		return false;
	} else if(nickname.length == 0) {
		$('#nickname_error').html('닉네임을 입력하여 주세요.');
		return false;
	} else if(nickname.length > 8) {
		$('#nickname_error').html('닉네임은 8글자 이하여야 합니다.');
		return false;
	} else if(specialCheck.test(nickname)) {
		$('#nickname_error').html('사용할 수 없는 닉네임 입니다.(특수문자 불가능)');
		return false;
	} else if(pw.length == 0) {
		$('#pw_error').html('비밀번호를 입력하여 주세요.');
		return false;
	} else if(pw.length < 8) {
		$('#pw_error').html('비밀번호는 8자리 이상 이여야 합니다.');
		return false;
	}
}
function checkNick() {
	
	var nickname = document.getElementById("nickname").value;
	
	if(nickname.length == 0) {
		$('#nickname_error').html('닉네임을 입력하여 주세요.');
		return;
	} else if(nickname.length > 8) {
		$('#nickname_error').html('닉네임은 8글자 이하여야 합니다.');
		return;
	}
	for(var i = 0; i < nickname.length - 1; i++) {
		if(verifyNick.test(nickname.charAt(i))) {
			
		} else {
			$('#nickname_error').html('사용할 수 없는 닉네임 입니다.(특수문자 불가능)');
			return;
		}
	}
	$('#nickname_error').html('');
}

function checkPw() {
	
}
function reCheckPw() {
	
}

function idCheck() {
	var id = document.getElementById("id").value;

	if(id.length == 0) {
		$('#id_error').html('아이디를 입력하여 주세요.');
	} else if(id.match(verifyEmail) == null) {
		$('#id_error').html('아이디는 이메일 형식이여야 합니다.');
	} else {
		$('#id_error').html('');
	}
}

function findAddr(){
	new daum.Postcode({
        oncomplete: function(data) {
        	
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var jibunAddr = data.jibunAddress; // 지번 주소 변수
            
            if(roadAddr !== ''){
                document.getElementById("address").value = '(' + data.zonecode + ')' + roadAddr;
            } 
            else if(jibunAddr !== ''){
                document.getElementById("address").value = '(' + data.zonecode + ')' + jibunAddr;
            }
        }
    }).open();
}
