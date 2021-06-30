//이메일 형식 검사 정규식
var verifyEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
//닉네임 형식 검사 정규식
var verifyNick = /[0-9]|[a-z]|[A-Z]|[가-힣]/;

var korCheck = /[가-힣]/;
var engCheck = /[a-z]/; 
var numCheck = /[0-9]/; 
var specialCheck = /[`~!@#$%^&*|\\\'\";:\/?]/;


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