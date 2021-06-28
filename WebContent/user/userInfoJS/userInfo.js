/**
 * 
 */

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