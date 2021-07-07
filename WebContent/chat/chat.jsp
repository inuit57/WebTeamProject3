<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="js/jquery-3.6.0.js"></script>
<style type="text/css">

#msgArea {
	height: 500px;
}

</style>
	<%
	
	request.setCharacterEncoding("UTF-8");
	
	String roomId = (String)session.getAttribute("roomId");
	String chatRole = (String)session.getAttribute("chatRole");
	
	%>
	
<title><%=roomId %></title>
</head>
<body>

	
	룸 아이디 : <%=roomId %><br>
	Status : <%=chatRole %><br>
	
	<input type="hidden" id="roomId" name="roomId" value="<%=roomId %>">
	<input type="hidden" id="chatRole" name="chatRole" value="<%=chatRole %>">
	
	<textarea rows="5" cols="30" id="msgArea" readonly="readonly"></textarea><br>
	<input type="text" id="seq"><br>
	<input type="button" value="send" onclick="socketMsgSend();">
	
	<%
	// 판매자인 경우
	if( "seller".equals(chatRole)){
	%>	
	<input type="button" value="거래신청" id="sellConfirm01" onclick="socketMsgSeller01();">
	<input type="button" value="거래완료" id="sellConfirm02" onclick="socketMsgSeller02();" disabled="disabled" >
	<% }else{ // 구매자인 경우  %>
	<input type="button" value="거래승인" id="buyConfirm01" onclick="socketMsgBuyer01();" disabled="disabled">
	<input type="button" value="구매확정" id="buyConfirm02" onclick="socketMsgBuyer02();" disabled="disabled">
	<%} %>
<script type="text/javascript">

String.prototype.replaceAll = function(org, dest) {
    return this.split(org).join(dest);
}

$(document).ready(function(){
	webSocketInit();
});

var msgArea = document.getElementById("msgArea");
var chatRole = document.getElementById("chatRole");


var webSocket;

function webSocketInit() {
	//webSocket = new WebSocket("ws://192.168.2.24:8088/WebTeamProject/websocket");
	// IP 주소 바꿔줘야 한다. 
	webSocket = new WebSocket("ws://192.168.2.222:8088/WebTeamProject/websocket");
	webSocket.onopen = function(event) {socketOpen(event);};
	webSocket.onclose = function(event) {socketClose(event);};
	webSocket.onmessage = function(event) {socketMessage(event);};
	webSocket.onerror = function(event) {socketError(event);};
}

function socketOpen(event) {
	
	var roomId = $('#roomId').val();
	
	$(function(){
		$.ajax('./ChatLoad.ch', {
			data : {roomId:roomId},
			async: false,
			success: function(data) {
				
				data = decodeURIComponent(data.replace(/\+/g," "));
				
				var msg = data.split('/');
				
				// 여기에서 거래 요청 관련 버튼이 눌렸을 때
				// 입력된 값들도 읽어서 처리가 필요하다. 

				 
				for(var i in msg) {
					var msgWriter = msg[i].split('|')[0] ;
					var msgText = msg[i].split('|')[2]  ; 
					
					if(msgText == undefined) break; 
				
					if( msgWriter == 'seller'){
						if(msgText == 'sell01'){
							msgText = "거래에 응하시려면 '거래승인'을 눌러주세요.";
							if( chatRole.value == 'buyer' ){
								$("#buyConfirm01").attr("disabled", false); //거래승인 버튼 활성화
								$("#buyConfirm02").attr("disabled", true);
							}
						}
						if(msgText == 'sell02'){						
							msgText = "상품을 받으신 것이 확인되셨다면 '구매확정'을 눌러주세요.";
						 	if(chatRole.value == 'buyer' ){
								$("#buyConfirm01").attr("disabled", true);
								$("#buyConfirm02").attr("disabled", false); // 구매확정 버튼 활성화
						 	}
						}
					}else if(msgWriter == 'buyer'){
						
						if(msgText == 'buy01'){
							msgText = "금액 지불이 완료되었습니다. 거래가 완료된 경우 '거래완료'을 눌러주세요. ";
							if(chatRole.value == 'seller' ){
								$("#sellConfirm01").attr("disabled", true);
								$("#sellConfirm02").attr("disabled", false); //거래완료 버튼 활성화
							}
						}
						
						if(msgText == 'buy02'){
							msgText = "거래가 완료되었습니다. 감사합니다. ";
							//if( chatRole.value == 'seller' ){
							// 방 나가기 버튼을 하나 만들기?? 
								$("#sellConfirm01").attr("disabled", true);
								$("#sellConfirm02").attr("disabled", true);
								$("#buyConfirm01").attr("disabled", true);
								$("#buyConfirm02").attr("disabled", true);
							//}
						}
					}
					
					if(msgWriter == chatRole.value){
						msgArea.value += "나:" +msgText + '\n';
					}else{
						msgArea.value += "상대:" +msgText + '\n';
					}
				}
			}
		});
	});
	console.log("웹 소켓 연결 완료");
	refresh();
}

function socketClose(event) {
	console.log("웹 소켓이 닫혔습니다.");
	
	webSocketInit();
}

function socketMsgSend() {
	var msg = $('#roomId').val() +'|'+ $("#seq").val();
	webSocket.send(msg);
	
	var roomId = $('#roomId').val();
	var chatRole = $('#chatRole').val();
	
	$(function(){
        $.ajax('./ChatSave.ch', {
           data : {roomId:roomId,chatRole:chatRole,msg:msg},
           async: false,
           success: function(data) {
              console.log(Date.now() + msg + '저장완료');
              
              $("#seq").val(""); // 메시지창 초기화 
           }
        });
     });
	
	msgArea.value += "나 : " + msg.split('|')[1] + "\n";
// 	msgArea.value += "나 : " + msg + "\n";
}


//판매자 채팅 버튼 시작----------------------------------------------------------------
function socketMsgSeller01() {
	var msg = $('#roomId').val() +'|'+ 'sell01';
	webSocket.send(msg);
	
	var roomId = $('#roomId').val();
	var chatRole = $('#chatRole').val();
	
	$(function(){
        $.ajax('./ChatSave.ch', {
           data : {roomId:roomId,chatRole:chatRole,msg:msg},
           async: false,
           success: function(data) {
              console.log(Date.now() + msg + '저장완료');
              
              $("#seq").val(""); // 메시지창 초기화 
           }
        });
     });
	
	$("#sellConfirm01").attr("disabled", true);
	msgArea.value += "나 : 거래를 요청합니다. '거래승인'을 눌러주세요."+ "\n"; 
}

function socketMsgSeller02() {
	var msg = $('#roomId').val() +'|'+ 'sell02';
	webSocket.send(msg);
	
	var roomId = $('#roomId').val();
	var chatRole = $('#chatRole').val();
	
	$(function(){
        $.ajax('./ChatSave.ch', {
           data : {roomId:roomId,chatRole:chatRole,msg:msg},
           async: false,
           success: function(data) {
              console.log(Date.now() + msg + '저장완료');
              
              $("#seq").val(""); // 메시지창 초기화 
           }
        });
     });
	
	$("#sellConfirm02").attr("disabled", true);
	msgArea.value += "나 : 상품을 받으신 것이 확인되셨다면 '구매확정'을 눌러주세요."+ "\n"; 
}
//판매자 채팅 버튼 끝----------------------------------------------------------------

// 구매자 채팅 버튼 시작-------------------------------------------------------------------------
function socketMsgBuyer01() {
	var msg = $('#roomId').val() +'|'+ 'buy01';
	webSocket.send(msg);
	
	var roomId = $('#roomId').val();
	var chatRole = $('#chatRole').val();
	
	$(function(){
        $.ajax('./ChatSave.ch', {
           data : {roomId:roomId,chatRole:chatRole,msg:msg},
           async: false,
           success: function(data) {
              console.log(Date.now() + msg + '저장완료');
              
              $("#seq").val(""); // 메시지창 초기화 
           }
        });
     });
	
	$("#buyConfirm01").attr("disabled", true);
	msgArea.value += "나 : 금액 지불이 완료되었습니다. 거래가 완료된 경우 '거래완료'을 눌러주세요. "+ "\n";  
}

function socketMsgBuyer02() {
	var msg = $('#roomId').val() +'|'+ 'buy02';
	webSocket.send(msg);
	
	var roomId = $('#roomId').val();
	var chatRole = $('#chatRole').val();
	
	$(function(){
        $.ajax('./ChatSave.ch', {
           data : {roomId:roomId,chatRole:chatRole,msg:msg},
           async: false,
           success: function(data) {
              console.log(Date.now() + msg + '저장완료');
              
              $("#seq").val(""); // 메시지창 초기화 
           }
        });
     });
	
	$("#buyConfirm01").attr("disabled", true);
	$("#buyConfirm02").attr("disabled", true);
	
	msgArea.value += "나 : 거래가 완료되었습니다. 감사합니다."+ "\n"; 
}

// 구매자 채팅 버튼 끝-------------------------------------------------------------------------


function socketMessage(event) {
	var receiveData = event.data;
	
	var receiveMsg = receiveData.split('|')[1]  ;
	if(receiveData.split('|')[0] == document.getElementById('roomId').value) {
		
		
		if(receiveMsg == 'sell01'){
			receiveMsg = "거래에 응하시려면 '거래승인'을 눌러주세요.";
			//포인트 차감 처리 필요 -> 이후 거래가 불발될 경우 포인트를 복구시켜줘야 한다. 
			$("#buyConfirm01").attr("disabled", false);
			$("#buyConfirm02").attr("disabled", true);
			
		}else if(receiveMsg == 'sell02'){
			receiveMsg = "상품을 받으신 것이 확인되셨다면 '구매확정'을 눌러주세요.";
			$("#buyConfirm01").attr("disabled", true);
			$("#buyConfirm02").attr("disabled", false);
			
		}else if(receiveMsg == 'buy01'){
			receiveMsg = "금액 지불이 완료되었습니다. 거래가 완료된 경우 '거래완료'을 눌러주세요.";
			$("#sellConfirm01").attr("disabled", true);
			$("#sellConfirm02").attr("disabled", false);
			
		}else if(receiveMsg == 'buy02'){
			receiveMsg = "거래가 완료되었습니다. 감사합니다.";
			$("#sellConfirm01").attr("disabled", true);
			$("#sellConfirm02").attr("disabled", true);
			$("#buyConfirm01").attr("disabled", true);
			$("#buyConfirm02").attr("disabled", true); 
		}
		
		msgArea.value += "상대 : " + receiveMsg + "\n";
	}
}

function socketError(event) {
	alert("에러가 발생하였습니다.");
}

function disconnect() {
	
	webSocket.close();
}

function refresh() {
	window.opener.location.reload();
}



</script>

</body>
</html>