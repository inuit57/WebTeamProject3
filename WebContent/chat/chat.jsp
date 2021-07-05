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
	String roomId = (String)session.getAttribute("roomId");
	%>
	
	룸 아이디 : <%=roomId %><br>
	
	<input type="hidden" id="roomId" name="roomId" value="<%=roomId %>">

	<textarea rows="5" cols="30" id="msgArea"></textarea><br>
	<input type="text" id="seq"><br>
	<input type="button" value="send" onclick="socketMsgSend();">
	
	
<script type="text/javascript">

$(document).ready(function(){
	webSocketInit();
});

var msgArea = document.getElementById("msgArea");


//webSocketInit();

var webSocket;

function webSocketInit() {
	webSocket = new WebSocket("ws://localhost:8087/WebTeamProject/websocket");
	webSocket.onopen = function(event) {socketOpen(event);};
	webSocket.onclose = function(event) {socketClose(event);};
	webSocket.onmessage = function(event) {socketMessage(event);};
	webSocket.onerror = function(event) {socketError(event);};
}

function socketOpen(event) {
	console.log("웹 소켓 연결 완료");
}

function socketClose(event) {
	console.log("웹 소켓이 닫혔습니다.");
	
	webSocketInit();
}

function socketMsgSend() {
	var msg = $('#roomId').val() +'|'+ $("#seq").val();
	webSocket.send(msg);
	msgArea.value += "나 : " + msg.split('|')[1] + "\n";
	
}

function socketMessage(event) {
	var receiveData = event.data;
	if(receiveData.split('|')[0] == document.getElementById('roomId')) {
		msgArea.value += "상대 : " + receiveData.split('|')[1] + "\n";	
	}
	
}

function socketError(event) {
	alert("에러가 발생하였습니다.");
}

function disconnect() {
	webSocket.close();
}


</script>

</body>
</html>