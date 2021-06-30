<%@page import="com.msg.db.MsgDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@ include file="../inc/top.jsp" %>

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>

</head>
<body>

	<%
	
	if (user_nick == null) {
		response.sendRedirect("./Main.do");
	
	}else{
		
		
		List msgList = (List) request.getAttribute("msgList");
		String msgTag = (String) request.getAttribute("msgTag");
		int alarm = (int) request.getAttribute("alarm");
	 	MsgDTO mdto = null;
	 	
	%>
	
<script>
	$(document).ready(function () {
		
 		// 쪽지 모달 보이기 
		$("#msgWrite").click(function () {
			$("#modal").show();
		});// 쪽지 모달 보이기
		
		
		
 		// 메세지 1000자 이내로만 작성 가능
		$("#msg_content").keyup(function() {
			 $('#test_cnt').html("("+$(this).val().length+" / 1000)");
			 
		        if($(this).val().length > 1000) {
		            $(this).val($(this).val().substring(0, 1000));
		            $('#test_cnt').html("(1000 / 1000)");
		            $('#test_cnt').css("color","red"); 
		        }else{
		        	 $('#test_cnt').css("color","black"); 
		        }
		});// 메세지 1000자 이내로만 작성 가능
		
		
		// 폼 입력 유효성
		$("#msgSend").click(function () {
			if(document.msgfr.recv_nick.value == ""){
				alert("받는 사람을 입력하세요");
				document.msgfr.recv_nick.focus();
				return false;
			}
			
			if(document.msgfr.msg_content.value == ""){
				alert("내용을 입력하세요");
				document.msgfr.msg_content.focus();
				return false;
			}
			
			document.msgfr.submit();
			alert("쪽지를 성공적으로 보냈습니다.");
		});// 폼 입력 유효성
		
		
		
		//쪽지 모달 끄기
		$("#msgExit").click(function () {
			 $('.searchModal').hide();
		});//쪽지 모달 끄기
		
		
		
		// 받는쪽지, 보내는쪽지 클릭시 해당 list불러오기
		var mt = "<%=msgTag%>";
		if(mt =="recv"){
			$(".msgBtnR").addClass('active');   //active 클래스 붙이기
		}else{
			$(".msgBtnS").addClass('active');	//active 클래스 붙이기
		}
		
		
		$(".msgBtnR").click(function() {
			$(".msgBtnS").removeClass('active');
			$(".msgBtnR").addClass('active');
			location.href='./MsgListAction.ms';
		})
		$(".msgBtnS").click(function() {
			$(".msgBtnR").removeClass('active');
			$(".msgBtnS").addClass('active');
			location.href='./MsgListAction.ms?tag=send';
		})// 받는쪽지, 보내는쪽지 클릭시 해당 list불러오기
		
		
         
	});
	
</script>
	
    <!-- Start Content -->
    <div class="container py-5">
        <div class="row"  >

            <div class="col-lg-3"  style="background-color:#f2fffe; text-align: center;">
            
            <% if(user_profile == null || user_profile.equals("")){ %>
				<img class="profile1234" src="./img/default_image.png" >
			<%}else{ %>
				<img class="profile1234" src="./upload/<%=user_profile%>">
			<%} %>
                <h4 style="text-align:center; margin-bottom: 40px; color:#59ab6e"><%=user_nick %>님</h4>
                <table style="width: 100%; color: #585858;" class="tagTable">
              		<tr class="msgBtnR h3 text-decoration-none msgBtn" > 
						<td><img src="./img/msgRecv.png" style="width: 30px; margin-right: 10px; margin-top: 10px">받은 쪽지<p id="circle1"><%=alarm %></p></td> 
					</tr>
					<tr class="msgBtnS h3 text-decoration-none msgBtn "> 
						<td><img src="./img/msgSend.png" style="width: 30px; margin-right: 10px;margin-top: 10px">보낸 쪽지</td> 
					</tr> 
               </table>
				<button class="services-icon-wap btn4321" id="msgWrite" style="margin-top: 20px">쪽지쓰기</button>
               
	
            </div>

            <div class="col-lg-9">
                <div class="row">
                    <div class="col-md-6">
                        <h2 style="color: #5a5a5a; margin-bottom: 5px"> 쪽지 </h2>
                        
                    </div>
                </div>
                 <hr>
               
               <div class="row" style="margin-top: 30px">
                  <form  action="./MsgDelAction.faq" method="post"  name="listchkDel">
					<button class="services-icon-wap btnSend" id="msgDel"><i class="fas fa-times mx-2"></i>삭제하기</button>
						   <table class="table" style="margin-top: 30px"> 
							<thead> 
								<tr> 
									<th></th> 
									<th id="nickChk">보낸사람</th> 
									<th>내용</th> 
									<th>읽음여부</th> 
								</tr> 
							</thead> 
							<tbody> 
							<% 
						
							for(int i=0; i<msgList.size();i++){
								mdto = (MsgDTO) msgList.get(i);
							%>
								<tr> 
									<td><input type="checkbox" name="msg_idx" value="<%=mdto.getMsg_idx() %>"></td> 
									<td><%=mdto.getRecv_nick() %></td> 
									<td><input type="text" name="msg_content" id="msgContent" value="<%=mdto.getMsg_content() %>" disabled="disabled"></td> 
									<td><%if(mdto.getMsg_chk() == 0){ %>
										읽지 않음
										<%}else{ %>
										읽음
										<%} %>
									</td>
								</tr> 
							<%	
								}
									
							%>
							</tbody> 
							</table>
					</form>
					
					



               </div>
                
            </div>

        </div>
    </div>
    <!-- End Content -->
    
    
    
    <!-- Start Modal -->
    <div id="modal" class="searchModal">
    <div class="search-modal-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="row">
                <div class="page-header">
		            <h1 style="float: left;">쪽지 쓰기</h1>
		            <img src="./img/exit.png" style="width: 35px; float: right;" id="msgExit">
		        </div>
                <form action="./MsgWriteAction.ms" method="post" name="msgfr">
                    	<input type="hidden" value="<%=user_nick %>" name="send_nick">
                    <div style="margin-top: 30px; width: 100%">
                    	<h4 style="float: left; padding-top: 4px; margin-right: 15px">받는사람</h4>
                    	<input type="text" placeholder="받는 사람을 입력하세요" name="recv_nick" style="width: 80%">
                    </div>
                    <div class="form-group">
		               <textarea name="msg_content" id="msg_content" cols="30" rows="10" class="form-control"  style="resize: none;" placeholder="내용을 입력하세요"></textarea>
		               <div class="m-l-10 m-b-10" id="test_cnt" style="margin-top: 10px; float: left;">(0 / 1000)</div>
		               <button class="services-icon-wap btnSend" id="msgSend" style="float: right; margin-top: 10px"><i class="fa fa-envelope mx-2"></i>보내기</button>
                    </div>
		            </form>
		            </div>
                </div>
            </div>
        </div>
        <hr>
        <div style="cursor:pointer;background-color:#DDDDDD;text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="closeModal();">
            <span class="pop_bt modalCloseBtn" style="font-size: 13pt;">
            </span>
        </div>
    </div>
    <!-- End Modal -->
    
    <%
		}
    %>



<%@ include file="../inc/footer.jsp" %>
</body>
</html>