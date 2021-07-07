<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>충전하기</title>

    <link rel="apple-touch-icon" href="./assets/img/apple-icon.png">
    <link rel="shortcut icon" type="image/x-icon" href="../assets/img/favicon.ico">

    <link rel="stylesheet" href="./assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="./assets/css/templatemo.css">
    <link rel="stylesheet" href="./assets/css/custom.css">

    <!-- Load fonts style after rendering the layout styles -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
    <link rel="stylesheet" href="./assets/css/fontawesome.min.css">
    
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<%
request.setCharacterEncoding("UTF-8");


%>

<script>

	<%
	
	String user_nick = (String) session.getAttribute("user_nick");
	if (user_nick == null) {
	%>
		window.close();
		alert("세션이 종료되었습니다. 다시 로그인 해주세요.");
	
	<%
	}else{
	%>
	
	$(function() {
		
	
		// kakaoPay 시작
		$("#kakaoPay").click(function (){
	        IMP.init('imp01708927'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
	        var msg;
	        var totalamount = $('#chargeAmt').val();
	        
	        IMP.request_pay({
	            pg : 'kakaopay',
	            pay_method : 'card',
	            merchant_uid : 'merchant_' + new Date().getTime(),
	            name : '기억마켓 충전',
	            amount : totalamount,
	            buyer_postcode : '123-456',
	            
	            //m_redirect_url : 'http://www.naver.com'
	        }, function(rsp) {
	            if ( rsp.success ) {

	            	msg = '결제가 완료되었습니다.';
                    msg += '\n결제 금액 : ' + rsp.paid_amount;
                    alert(msg);
	            	location.href='./PaymentAction.pa?totalamount='+totalamount;
	            	window.close();
	            } else {
	                msg = '\n결제에 실패했습니다.';
	                msg += '\n\n에러내용 : ' + rsp.error_msg;
	                //실패시 이동할 페이지
	                location.href="./Charge.pa";
	                alert(msg);
	            }
	        });
	        
	   	 });
		// kakaoPay 끝
		
		
		// 금액버튼 시작
		$("#price1").click(function (){
 		   var total = $('#chargeAmt').val();
 		   total *=1;
 		   total += 10000;
		   
			$('input[name=chargeAmt]').attr('value',total);
		   	 });
		
		
		$("#price2").click(function (){
			 var total = $('#chargeAmt').val();
	 		   total *=1;
	 		   total += 50000;
			$('input[name=chargeAmt]').attr('value',total);
	   	 });
		
		
		$("#price3").click(function (){
			 var total = $('#chargeAmt').val();
	 		   total *=1;
	 		   total += 100000;
			$('input[name=chargeAmt]').attr('value',total);
	   	 });
		
		
		$("#price4").click(function (){
			 var total = $('#chargeAmt').val();
	 		   total *=1;
	 		   total += 500000;
			$('input[name=chargeAmt]').attr('value',total);
	   	 });
		// 금액버튼 끝
		

		
		
		// 리셋 버튼 이벤트
		$("#reset").click(function (){
			$('input[name=chargeAmt]').attr('value',"");
	   	 });
		// 리셋 버튼 이벤트
		
		
		
	 });
    </script> 
    


    
</head>
<body>
	<div id="header" style="margin: 0px 20px 0px 20px;">
		<h3 style="text-align: center; margin-top: 30px">충전</h3>
		<div id="in" style="position: relative; margin-top: 50px">
		<input type="tel" class="input_amount" name="chargeAmt" id="chargeAmt" required="required" autocomplete="off" placeholder="금액을 입력하세요" style="margin-top: 0;">
		<img src="./img/reset.png" style="width: 20px; position: absolute; right: 3px; top:4px;" id="reset">
		</div>
        <hr>
        <div style="width:100%">
        <button class="btn321" id="price1">+1만원</button>
        <button class="btn321" id="price2">+5만원</button>
        <button class="btn321" id="price3">+10만원</button>
        <button class="btn321" id="price4">+50만원</button>
		</div>
		<br>
		<div>
			<h5 style="margin-top: 35px">충전수단</h5>
			<hr>
			<img src="./img/kakaoPay.png" style="width: 30%;" id="kakaoPay">

		</div>
	</div>
	

	
	
	 
    	
	<%
		}
			
	%>
	
	
	
	
	
	
	
	
	
</body>
</html>