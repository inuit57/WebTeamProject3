<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../inc/top.jsp" %>

	<%
		request.setCharacterEncoding("UTF-8");
		// 로그인한 사람의 정보를 DB에서 조회해서 
		// jsp화면에 출력

		// 로그인 세션처리 (로그인x->로그인페이지로 이동)
			
		if (user_nick == null) {
			response.sendRedirect("./Main.do");
		}else{
		
	%>
	
	<script type="text/javascript">
    function winopen(){
    	
    	//id 값이 있을때 -> 새창열기
    	window.open("./Charge.pa","PopupWin","width=480,height=700");    	
    	
    }
    </script>
 
 
    <!-- Start Content -->
    <div class="container py-5">
        <div class="row"  >

            <div class="col-lg-3"  style="background-color:#f2fffe;">
                 <img class="profile1234" src="./img/user.png">
                <h4 style="text-align:center; margin-bottom: 40px; color:#59ab6e"><%=user_nick %>님</h4>
				<h6 style="margin-bottom: -1px; text-align:center;"> 잔여 포인트 </h6>
				<div style="margin-left:38%; margin-bottom: 20px"><h1 style="float:left;">00</h1><h4 style="padding-top: 12px">원</h4></div>            
				<button class="services-icon-wap btn4321" onclick="winopen()">충전</button>
            </div>

            <div class="col-lg-9">
                <div class="row" style="margin-bottom: 30px">
                    <div class="col-md-6">
                        <h2 style="color: #5a5a5a"> 결제내역 </h2>
                    </div>
                </div>
                
            </div>

        </div>
    </div>
    <!-- End Content -->
    
    
    
    
    
    	
	<%
		}
			
	%>
	
	

<%@ include file="../inc/footer.jsp" %>
