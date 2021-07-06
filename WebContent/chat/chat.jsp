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

<title>Insert title here</title>
</head>
<body>

	<%
	
	request.setCharacterEncoding("UTF-8");
	
	String roomId = (String)session.getAttribute("roomId");
	String chatRole = (String)session.getAttribute("chatRole");
	%>
	
	룸 아이디 : <%=roomId %><br>
	Status : <%=chatRole %><br>
	
	<input type="hidden" id="roomId" name="roomId" value="<%=roomId %>">
	<input type="hidden" id="chatRole" name="chatRole" value="<%=chatRole %>">
	
	<textarea rows="5" cols="30" id="msgArea"></textarea><br>
	<input type="text" id="seq"><br>
	<input type="button" value="send" onclick="socketMsgSend();">
	
	
<script type="text/javascript">

String.prototype.replaceAll = function(org, dest) {
    return this.split(org).join(dest);
}

$(document).ready(function(){
	webSocketInit();
});

var msgArea = document.getElementById("msgArea");
var chatRole = document.getElementById("chatRole");

//webSocketInit();

var webSocket;

function webSocketInit() {
	webSocket = new WebSocket("ws://192.168.2.24:8088/WebTeamProject/websocket");
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
				
				for(var i in msg) {
					if(msg[i].split('|')[0] == 'seller' && chatRole.value == 'seller') {
						msgArea.value += "나:" + msg[i].split('|')[2] + '\n';
					} else if(msg[i].split('|')[0] == 'seller' && chatRole.value == 'buyer') {
						msgArea.value += "상대:" + msg[i].split('|')[2] + '\n';
					} else if(msg[i].split('|')[0] == 'buyer' && chatRole.value == 'buyer') {
						msgArea.value += "나:" + msg[i].split('|')[2] + '\n';
					} else if(msg[i].split('|')[0] == 'buyer' && chatRole.value == 'seller') {
						msgArea.value += "상대:" + msg[i].split('|')[2] + '\n';
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
           }
        });
     });
	
	msgArea.value += "나 : " + msg.split('|')[1] + "\n";
// 	msgArea.value += "나 : " + msg + "\n";
}

function socketMessage(event) {
	var receiveData = event.data;
	
	if(receiveData.split('|')[0] == document.getElementById('roomId').value) {
		msgArea.value += "상대 : " + receiveData.split('|')[1] + "\n";
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