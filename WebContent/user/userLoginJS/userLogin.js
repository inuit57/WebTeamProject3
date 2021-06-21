/**
 * 로그인 시 사용하는 js
 */


function userLogin() {
	
	var id = document.getElementById("id").value;
	var pw = document.getElementById("pw").value;
	
	$(function(){
		$.ajax('./UserLoginAction.us', {
			data : {id:id, pw:pw},
			
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