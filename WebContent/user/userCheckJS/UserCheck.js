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
var specialCheck = /[`~!@#$%^&*|\\\'\";:\/?]/;
var pchk1= /^010([0-9]{8})$/;
var pchk2 = /^01([1|6|7|8|9])([0-9]{3})([0-9]{4})$/;

//유효성 체크 Flag
var idFlag = false;
var nickFlag = false;
var pwFlag = false;
var phoneFlag = false;
var addressFlag = false;
var address_plusFlag = false;
var email_Flag = false;

//Submit할때 데이터 유효성 체크
function check() {
   idCheck();
   checkNick();
   checkPhone();
   checkPw();
   addressCheck();
   
   if(idFlag == false) {
      return false;
   } else if(nickFlag == false) {
      return false;
   } else if(pwFlag == false) {
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
   
   var nickname = document.getElementById("nickname").value;
   
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

function idCheck() {
   
   var id = document.getElementById("id").value;

   if(id.length == 0) {
      $('#id_error').css('color','red');
      $('#id_error').html('아이디를 입력하여 주세요.');
      idFlag = false;
   } else if(id.match(verifyEmail) == null) {
      $('#id_error').css('color','red');
      $('#id_error').html('아이디는 이메일 형식이여야 합니다.');
      idFlag = false;
   } else {
      $(function(){
         $.ajax('./UserIdCheckAction.us', {
            data : {id:id},
            success: function(data) {
               if(data == 0) {
                  $('#id_error').css('color','green');
                  $('#id_error').html('사용 가능한 이메일 입니다.');
                  idFlag = true;
               } else {
                  $('#id_error').css('color','red');
                  $('#id_error').html('사용 중인 이메일 입니다.');
                  idFlag = false;
               }
            }
         });
      });
   }
}

function checkPhone() {
   var phone = document.getElementById("phone").value;
	if(phone == "") {
	      $('#phone_error').css('color','red');
	      $('#phone_error').html('휴대폰 번호를 입력해 주세요.');
	      phoneFlag = false;
	 }else if(phone.match(pchk1) != null || phone.match(pchk2) != null){
	      $('#phone_error').css('color','green');
	        $('#phone_error').html('사용 가능 합니다.');
	        phoneFlag = true;
	        
	        $.ajax({
				 url:'./UserPhoneChk.us',
			     type:'post',
			     data:{"user_phone":phone}, 
			     success:function(data){
			    	 if(data == 1){
			    		 $('#phone_error').css('color','red');
			   	      	 $('#phone_error').html('가입된 번호입니다.');
			   	      	 phoneFlag = false;
			    	 }else if(data == 0){
			    		 $('#phone_error').css('color','green');
			 	         $('#phone_error').html('사용 가능 합니다.');
			 	         phoneFlag = true;
			    	 }
		               },
		        		error:function(){
		                alert("에러입니다");
		               }
		       }); // 전화번호 중복체크
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
    }else {
    	$('#phone_error').css('color','red');
	      $('#phone_error').html('휴대폰 번호를 확인해 주세요');
	      phoneFlag = false;
     }
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
}

function addressCheck() {
   var address = document.getElementById("address").value;
   var address_plus = document.getElementById("address_plus").value;
   
   if(address == "") {
      $('#address_error').css('color','red');
      $('#address_error').html('주소 찾기를 눌러주세요.');
      addressFlag = false;
   } else if(address_plus == "") {
      $('#address_error').css('color','red');
      $('#address_error').html('상세 주소를 입력하세요.');
      address_plusFlag = false;
   } else {
      $('#address_error').html('');
      addressFlag = true;
      address_plusFlag = true;
   }
   
}

function emailCheck() {
   emailFlag = false;
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