<%@page import="java.net.InetAddress"%>
<%@page import="com.user.db.UserDAO"%>
<%@page import="com.prod.db.ProdDAO"%>
<%@page import="com.prod.db.ProdDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="js/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<style type="text/css">

#msgArea {
	height: 500px;
	border-radius: 3px;
}

#msgWindow {
	overflow: auto;
	height: 41em;
	width: 400px;
	background-color: #5BAC70; /* 로고 색 */
	font-size: 15px;
	margin-top: 1px;
	border-radius: 5px;
	border-bottom: 3px solid #5BAC30;
/* 	#EAEAEA 회색 */
/* #DEF7DE  연한 초록색*/
	
	
}

#msgWindow::-webkit-scrollbar {
	width: 5px;
}
#msgWindow::-webkit-scrollbar-thumb {
    background-color: #EAEAEA;
    border-radius: 10px;
}
#msgWindow::-webkit-scrollbar-track {
    background-color: grey;
    border-radius: 10px;
    box-shadow: inset 0px 0px 5px white;
}

#top_bar {
	background-color: #5BAC70;
	border-bottom: 3px solid #5BAC30;
	height: 60px;
	width: 400px;
	text-align: center;
	color: white;
	border-radius: 5px;
	
}

#send_button {
	width: 85px;
	height: 50px;
	background-color: #5BAC30;
	color: white;
	position: relative;
	bottom: 20px;
	border-radius: 3px;
}

#price {
	text-align: right;
}

.bottom_button {
	position: relative;
	bottom: 5px;
	left: 40px;
	background-color: #5BAC30;
	color: white;
	height: 30px;
	text-align: center;
}

#msg_div {
	margin-top: 1px;
}

#seq {
	border-radius: 5px;
}

</style>
	<%
	
	 InetAddress inet= InetAddress.getLocalHost();
	 String serverIP = inet.getHostAddress(); 
	
	
	request.setCharacterEncoding("UTF-8");
	
	String user_nick = (String)session.getAttribute("user_nick"); 
	
	
	String roomId = (String)session.getAttribute("roomId");
	String chatRole = (String)session.getAttribute("chatRole");
	int prod_num = (Integer)session.getAttribute("prod_num");
	
	ProdDTO pdto = new ProdDTO();
	ProdDAO pdao = new ProdDAO();
	UserDAO udao = new UserDAO(); 
	
	
	pdto = pdao.getProduct(prod_num);

	%>
	
<title>채팅창</title>
</head>
<body>
	
	<div id="top_bar">
	<br>
	<%=pdto.getProd_sub() %><br>
	<div id="price">
	<%=pdto.getProd_price() %>원&nbsp&nbsp
	</div>
	</div>
	
	
	<input type="hidden" id="roomId" name="roomId" value="<%=roomId %>">
	<input type="hidden" id="chatRole" name="chatRole" value="<%=chatRole %>">
	
	
	<input type="hidden" id="curr_coin" value="<%=udao.getCoin(user_nick) %>" >
	<input type="hidden" id="price_check" value="<%=pdto.getProd_price() %>" >
	
	
	<div id="msgWindow"></div>
	
	<div id="msg_div">
	<textarea rows="3" cols="40" wrap="hard" id="seq" onkeydown="if(event.keyCode==13 && !event.shiftKey){socketMsgSend();}" ></textarea>
	<input type="button" id="send_button" value="보내기" onclick="socketMsgSend();"> <br>
	</div>
	<input type="button" value="이 사람이랑 거래 안하기" id="deleteChat" class="bottom_button" name="deleteChat">
	
	
	<%
	// 판매자인 경우
	if( "seller".equals(chatRole)){
	%>	
	<input type="button" value="거래신청" id="sellConfirm01" class="bottom_button" onclick="socketMsgSeller01();" >
	<input type="button" value="거래완료" id="sellConfirm02" class="bottom_button" onclick="socketMsgSeller02();" disabled="disabled">
	<% }else{ // 구매자인 경우  %>
	<input type="button" value="거래승인" id="buyConfirm01" class="bottom_button" onclick="socketMsgBuyer01();" disabled="disabled">
	<input type="button" value="구매확정" id="buyConfirm02" class="bottom_button" onclick="socketMsgBuyer02();" disabled="disabled">
	<%} %>
	
	
	
	
	
<script type="text/javascript">

String.prototype.replaceAll = function(org, dest) {
    return this.split(org).join(dest);
}

$(document).ready(function(){
	webSocketInit();
});

var chatRole = document.getElementById("chatRole");


var webSocket;

function webSocketInit() {
	//webSocket = new WebSocket("ws://192.168.2.24:8088/WebTeamProject/websocket");
	// IP 주소 바꿔줘야 한다. 
	webSocket = new WebSocket("ws://<%=serverIP%>:8088/WebTeamProject/websocket");
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
                        
                        $("#buyConfirm01").attr("type", "button"); //거래승인 버튼 활성화
                        $("#buyConfirm02").attr("type", "hidden");
                     }
                  }
                  if(msgText == 'sell02'){                  
                     msgText = "상품을 받으신 것이 확인되셨다면 '구매확정'을 눌러주세요.";
                      if(chatRole.value == 'buyer' ){
                        $("#buyConfirm01").attr("disabled", true);
                        $("#buyConfirm02").attr("disabled", false); // 구매확정 버튼 활성화
                        
                        $("#buyConfirm01").attr("type", 'hidden');
                        $("#buyConfirm02").attr("type", 'button'); // 구매확정 버튼 활성화
                      }
                  }
               }else if(msgWriter == 'buyer'){
                  
                  if(msgText == 'buy01'){
                     msgText = "금액 지불이 완료되었습니다. 거래가 완료된 경우 '거래완료'을 눌러주세요. ";
                     if(chatRole.value == 'seller' ){
                        $("#sellConfirm01").attr("disabled", true);
                        $("#sellConfirm02").attr("disabled", false); //거래완료 버튼 활성화
                        
                        $("#sellConfirm01").attr("type", 'hidden');
                        $("#sellConfirm02").attr("type", 'button'); //거래완료 버튼 활성화
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
                        
                        $("#sellConfirm01").attr("type", hidden);
                        $("#sellConfirm02").attr("type", hidden);
                        $("#buyConfirm01").attr("type", hidden);
                        $("#buyConfirm02").attr("type", hidden);
                     //}
                  }
               }
               
               if(msgWriter == chatRole.value){
                  addRightChat(msgText);
               }else{
                  addLeftChat(msgText);
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
	
	var aaa = document.getElementById('seq').value;
	
	if(aaa=="") {return;}
	
	var msg = $('#roomId').val() +'|'+ $("#seq").val().replace(/\n/g, "<br>");
	
	
	
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
	
	addRightChat(msg.split('|')[1]);
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
	$("#sellConfirm01").attr("type", 'hidden');
	addRightChat("거래를 요청합니다. '거래승인' 을 눌러주세요.");
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
	$("#sellConfirm02").attr("type", 'hidden');
	addRightChat("상품을 받으신 것이 확인되셨다면 '구매확정'을 눌러주세요.");
}
//판매자 채팅 버튼 끝----------------------------------------------------------------

// 구매자 채팅 버튼 시작-------------------------------------------------------------------------
function socketMsgBuyer01() {
	
	console.log($('#price_check').val()) ;
	console.log($('#curr_coin').val()) ;
	
	var price_chk = $('#price_check').val(); 
	var curr_coin = $('#curr_coin').val() ;
	if( (price_chk - curr_coin) > 0 ){
		//console.log( curr_coin - price_chk); 
		if( confirm("코인이 부족합니다. 충전하러 가시겠습니까?") ){
			 
			window.opener.location.href="./Payment.pa";
			//opener.focus(); 포커스가 안먹는다...왜지 ㅠㅠ 
		}
		return; 
	}else{
	
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
		$("#buyConfirm01").attr("type", 'hidden');
		addRightChat("금액 지불이 완료되었습니다. 거래가 완료된 경우 '거래완료'을 눌러주세요. ");
	}
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
	
	$("#buyConfirm01").attr("type", 'hidden');
	$("#buyConfirm02").attr("type", 'hidden');
	
	addRightChat("나 : 거래가 완료되었습니다. 감사합니다.");
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
			
	        $("#buyConfirm01").attr("type", 'button');
	        $("#buyConfirm02").attr("type", 'hidden');

			
		}else if(receiveMsg == 'sell02'){
			receiveMsg = "상품을 받으신 것이 확인되셨다면 '구매확정'을 눌러주세요.";
			$("#buyConfirm01").attr("disabled", true);
			$("#buyConfirm02").attr("disabled", false);
			
	        $("#buyConfirm01").attr("type", 'hidden');
	        $("#buyConfirm02").attr("type", 'button');

			
		}else if(receiveMsg == 'buy01'){
			receiveMsg = "금액 지불이 완료되었습니다. 거래가 완료된 경우 '거래완료'을 눌러주세요.";
			$("#sellConfirm01").attr("disabled", true);
			$("#sellConfirm02").attr("disabled", false);
			
			$("#sellConfirm01").attr("type", 'button');
	        $("#sellConfirm02").attr("type", 'hidden');
			
		}else if(receiveMsg == 'buy02'){
			receiveMsg = "거래가 완료되었습니다. 감사합니다.";
			$("#sellConfirm01").attr("disabled", true);
			$("#sellConfirm02").attr("disabled", true);
			$("#buyConfirm01").attr("disabled", true);
			$("#buyConfirm02").attr("disabled", true); 
			
			$("#sellConfirm01").attr("type", 'hidden');
	        $("#sellConfirm02").attr("type", 'hidden');
	        $("#buyConfirm01").attr("type", 'hidden');
	        $("#buyConfirm02").attr("type", 'hidden');
		}
		
		addLeftChat(receiveMsg);
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

$().ready(function() {
	$('#deleteChat').click(function() {
		Swal.fire({
			title: '주 의',
			text: '거래를 취소 하시겠습니까?\n모든 채팅 정보가 삭제 됩니다.',
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '',
			cancelButtonColor: '',
			confirmButtonText: '예',
			cancelButtonText: '아니요'
		}).then((result) => {
			if(result.isConfirmed) {
				
				var roomId = $('#roomId').val();
				
				$(function(){
			        $.ajax('./ChatDeleteAction.ch', {
			           data : {roomId:roomId},
			           async: false,
			           success: function(data) {
			        	   window.close();
			           }
			        });
			     });
				
				
			}
		})
	});
});

function addLeftChat(msg) {
	var div = document.createElement('div');
	
	div.style["width"]='auto';
	div.style["word-wrap"]='break-word';
	div.style['display']='inline-block';
	div.style['background-color']='#EAEAEA';
	div.style['border-radius']='3px';
	div.style['padding']='3px';
	div.style['margin-left']='5px';
	div.style['margin-bottom']='4px';
	div.style['margin-top']='4px';
	
	div.innerHTML = msg;
	
	document.getElementById('msgWindow').appendChild(div);
	
	var clear = document.createElement('div');
	clear.style['clear'] = 'both';
	document.getElementById('msgWindow').appendChild(clear);
	
	document.getElementById('msgWindow').scrollTop = document.getElementById('msgWindow').scrollHeight;
	
}

function addRightChat(msg) {
	var div = document.createElement('div');
		
		div.style["width"]='auto';
		div.style["word-wrap"]='break-word';
		div.style['float']='right';
		div.style['display']='inline-block';
		div.style['background-color']='#DEF7DE';
		div.style['border-radius']='3px';
		div.style['padding']='3px';
		div.style['margin-right']='5px';
		div.style['margin-bottom']='4px';
		div.style['margin-top']='4px';
		
		
		div.innerHTML = msg;
		
		document.getElementById('msgWindow').appendChild(div);
		
		var clear = document.createElement('div');
		clear.style['clear'] = 'both';
		document.getElementById('msgWindow').appendChild(clear);
		
		document.getElementById('msgWindow').scrollTop = document.getElementById('msgWindow').scrollHeight;
}

</script>

</body>
</html>