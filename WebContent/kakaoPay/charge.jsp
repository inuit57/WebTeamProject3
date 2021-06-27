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
	            name : 'OO마켓 충전',
	            amount : totalamount,
	            buyer_email : 'sdf@daf.com',
	            buyer_name : '뫄뫄',
	            buyer_tel : '01012341234',
	            //m_redirect_url : 'http://www.naver.com'
	        }, function(rsp) {
	            if ( rsp.success ) {
	                //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
	                jQuery.ajax({
	                    url: "/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
	                    type: 'POST',
	                    dataType: 'json',
	                    data: {
	                        imp_uid : rsp.imp_uid
	                        //기타 필요한 데이터가 있으면 추가 전달
	                    }
	                }).done(function(data) {
	                    //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
	                    if ( everythings_fine ) {
	                        msg = '결제가 완료되었습니다.';
	                        msg += '\n고유ID : ' + rsp.imp_uid;
	                        msg += '\n상점 거래ID : ' + rsp.merchant_uid;
	                        msg += '\결제 금액 : ' + rsp.paid_amount;
	                        msg += '카드 승인번호 : ' + rsp.apply_num;
	                        
	                        alert(msg);
	                    } else {
	                        //[3] 아직 제대로 결제가 되지 않았습니다.
	                        //[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
	                    }
	                });
	                //성공시 이동할 페이지
	               location.href='./PaymentAction?msg='+msg;
	            } else {
	                msg = '결제에 실패하였습니다.';
	                msg += '에러내용 : ' + rsp.error_msg;
	                //실패시 이동할 페이지
	                location.href="./Charge.pa";
	                alert(msg);
	            }
	        });
	        
	   	 });
		// kakaoPay 끝
		
		
		// 금액버튼 시작
		
		$("#price1").click(function (){
			//$('input[name=chargeAmt]').attr('value',10000);
// 		   var total = $('#chargeAmt').val();
// 		   total += 10000;
		   
		   $('input[name=chargeAmt]').attr('value',10000);
	   	 });
		$("#price2").click(function (){
			$('input[name=chargeAmt]').attr('value',50000);
	   	 });
		$("#price3").click(function (){
			$('input[name=chargeAmt]').attr('value',100000);
	   	 });
		$("#price4").click(function (){
			$('input[name=chargeAmt]').attr('value',1000000);
	   	 });
		// 금액버튼 끝
		
		
		
		
		
	 });
    </script> 
    


    
</head>
<body>
	<div id="header" style="margin: 0px 20px 0px 20px;">
		<h3 style="text-align: center; margin-top: 30px">충전</h3>
		<input type="text" class="input_amount" name="chargeAmt" id="chargeAmt" required="required" autocomplete="off" placeholder="금액을 입력하세요">
        <hr>
        <div style="width:100%">
        <button class="btn321" id="price1">+1만원</button>
        <button class="btn321" id="price2">+5만원</button>
        <button class="btn321" id="price3">+10만원</button>
        <button class="btn321" id="price4">+100만원</button>
		</div>
		<br>
		<div>
			<h6>충전수단</h6>
			<img src="./img/kakaoPay.png" style="width: 20%;" id="kakaoPay">

		</div>
	</div>
	

	
	
	
	
	
	
	
	
	
	
	
</body>
</html>