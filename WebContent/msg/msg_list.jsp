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
	 	MsgDTO mdto = null;
	 	int msgDiv = 0;
	 	
	 	if(msgTag.equals("send")){
	 		msgDiv =1;
	 		
	 	}
	 	
	 	
	 	
	%>
	
<script>
	$(document).ready(function () {
		
		var RecvnickAdd = "";
		
		// 다수에게 쪽지 보내기
		$("#recv_nick").blur(function() {
			var nickname = $("#recv_nick").val();
			if(nickname != ""){
            $.ajax({
				 url:'./UserNickCheckAction.us',
			     type:'post',
			     data:{"nickname":nickname}, 
			     success:function(data){
			    	 if(data == 1){
			    		const box = document.getElementById("box");
						const newP = document.createElement('p');
			            newP.innerHTML = "<input type='text' id='boxAdd' value='"+nickname+"' readonly><i class='fas fa-times' onclick='remove(this)' style='float: left; margin-left: -22px; margin-top: 7px'></i>";
			            box.appendChild(newP);
			            RecvnickAdd += nickname + "/";
			            $("#recv_nick").val("");
			    	 }else{
			    		 alert("존재하지 않는 회원입니다.");
			    		 $("#recv_nick").val("");
			    	 }

		               },
		        		error:function(){
		                alert("에러입니다");
		               }
		     });
            
            
			}
		})//  다수에게 쪽지 보내기
		
		
		//답장 모달 띄우기
		$("#msgRE").click(function () {
			var nickname = $("#detailSend").val();
			$('.detailModal').hide();
			$("#modal").show();
			 $.ajax({
				 url:'./UserNickCheckAction.us',
			     type:'post',
			     data:{"nickname":nickname}, 
			     success:function(data){
			    	 if(data == 1){
			    		const box = document.getElementById("box");
						const newP = document.createElement('p');
			            newP.innerHTML = "<input type='text' id='boxAdd' value='"+nickname+"' readonly><i class='fas fa-times' onclick='remove(this)' style='float: left; margin-left: -22px; margin-top: 7px'></i>";
			            box.appendChild(newP);
			            RecvnickAdd += nickname + "/";
			            $("#recv_nick").val("");
			    	 }else{
			    		 alert("존재하지 않는 회원입니다.");
			    		 $("#recv_nick").val("");
			    	 }

		               },
		        		error:function(){
		                alert("에러입니다");
		               }
		     });
		});//답장 모달 띄우기
		
		
		
		
		// 쪽지 알림 
		$.ajax({
				 url:'./MsgAlarmAction.ms',
			     type:'post',
			     data:{"user_nick":"<%=user_nick%>"}, 
			     success:function(data){
			    	$("#circle1").val(data);
		               },
		        		error:function(){
		                alert("에러입니다");
		               }
		     }); // 읽음여부
		// 쪽지 알림	
		
	
		
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
			
			if(RecvnickAdd == ""){
				alert("받는 사람을 입력하세요");
				$("#recv_nick").focus();
				return false;
			}
			
			if(document.msgfr.msg_content.value == ""){
				alert("내용을 입력하세요");
				document.msgfr.msg_content.focus();
				return false;
			}
			
			
			if(RecvnickAdd != "" && document.msgfr.msg_content.value != ""){
			$("#recv_nick_list").val(RecvnickAdd);
			document.msgfr.submit();
			alert("쪽지를 성공적으로 보냈습니다.");
			}
			
		});// 폼 입력 유효성
		
		
		
		
		
		
		// 받는쪽지, 보내는쪽지 클릭시 해당 list불러오기
		var mt = "<%=msgTag%>";
		if(mt =="send"){
			$(".msgBtnS").addClass('active');//active 클래스 붙이기
		}else{
			$(".msgBtnR").addClass('active'); //active 클래스 붙이기
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
		
		
		
		<% 
		for(int i=0; i<msgList.size();i++){
			mdto = (MsgDTO) msgList.get(i);
			
		if(msgDiv == 0){
		%>// 받는 쪽지 내용 불러오기
		
		// 읽음여부
		$(".msgDetail<%=i%>").click(function() {
			
			
			$("#detailModal").show();
			$("#detailSend").val("<%=mdto.getSend_nick()%>"); 
			$("#detailSend_date").val("<%=mdto.getMsg_date()%>"); 
			$("#detailSend_content").val("<%=mdto.getMsg_content()%>"); 
			
			$.ajax({
				 url:'./MsgReadChkAction.ms',
			     type:'post',
			     data:{"msg_idx":"<%=mdto.getMsg_idx()%>"}, 
			     success:function(data){
			    	 $(".<%=mdto.getMsg_idx() %>").removeClass('chkcolor');
			    	 $(".<%=mdto.getMsg_idx() %>").addClass('chkcolor2');
		               },
		        		error:function(){
		                alert("에러입니다");
		               }
		       }); // 읽음여부
			
		})// 받는 쪽지 내용 불러오기
		<% 	}else{ %>
		// 보낸 쪽지 내용 불러오기
		$(".msgDetailSend<%=i%>").click(function() {
			<%
			String mchk;
			if(mdto.getMsg_chk() == 0){ 
				mchk = "읽지 않음";
			}else{
				mchk = "읽음";
			} %>
			 
			$("#detailModalSend").show();
			$("#detailRecv").val("<%=mdto.getSend_nick()%>"); 
			$("#detailRecv_date").val("<%=mdto.getMsg_date()%>");
			$("#detailRecv_chk").val("<%=mchk%>"); 
			$("#detailRecv_content").val("<%=mdto.getMsg_content()%>"); 
		})
		<% } %>
		
		 
		<%
		}%>// for문끝
		
		
		

		//쪽지 쓰기 모달 끄기
		$("#msgExit").click(function () {
			location.reload();
			 $('.searchModal').hide();
		});//쪽지 쓰기 모달 끄기
		
		//받은 쪽지 모달 끄기
		$("#msgExit2").click(function () {
			 $('.detailModal').hide();
		});//받은 쪽지 모달 끄기
		
         
		//보낸 모달 끄기
		$("#msgExit3").click(function () {
			 $('.detailModalSend').hide();
		});//보낸 모달 끄기
		
		
		
		
	
		
		// 쪽지 삭제
		$("#msgDel").click(function() {
  			if($("input:checkbox").is(":checked")){
  				var fr = document.listchkDel;
  				fr.submit();
  			}else{
  				alert("삭제할 글을 선택하세요");
  				return false;
  			}
  		});	// 쪽지 삭제
  		
  		
  		
//   		// 체크박스 전체선택
// 		 $(".allChk").change(function(){
// 	        if($(".allChk").prop("checked")){
// 	 			$('.allchk').prop("checked",true);
// 	        }else{
// 	        	$('.allchk').prop("checked",false);
// 	        }
// 	    });// 체크박스 전체선택
  		
		
	});
	
	 const remove = (obj) => {
         document.getElementById('box').removeChild(obj.parentNode);
     }// 받는사람 삭제
     
     
     
		
	 function checkSelectAll(checkbox)  {
		  const selectall 
		    = document.querySelector('input[name="selectall"]');
		  
		  if(checkbox.checked === false)  {
		    selectall.checked = false;
		  }
		}

		function selectAll(selectAll)  {
		  const checkboxes 
		     = document.getElementsByName('msg_idx');
		  
		  checkboxes.forEach((checkbox) => {
		    checkbox.checked = selectAll.checked
		  })
		}
	
	
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
						<td><img src="./img/msgRecv.png" style="width: 30px; margin-right: 10px; margin-top: 10px">받은 쪽지<input type="text" id="circle1" readonly onfocus="this.blur();" ></td> 
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
                  <form  action="./MsgDelAction.ms" method="post"  name="listchkDel">
                  	<input type="checkbox" name="selectall" class="allChk" style="zoom:1.5;float: left;margin-top: 3px;margin-left: 5px"  onclick='selectAll(this)'><p style="float: left;">전체선택</p>
					<button class="services-icon-wap btnSend" id="msgDel" style="margin-left: 30px"><i class="fas fa-times mx-2"></i>삭제하기</button>
						   <table class="table" style="margin-top: 30px"> 
							<thead> 
								<tr> 
								<% if(msgDiv == 0){ %>
									<th></th> 
									<th id="nickChk">보낸사람</th> 
									<th>내용</th> 
									<th>날짜</th> 
								<%}else{%>
									<th></th> 
									<th id="nickChk">받는사람</th> 
									<th>내용</th> 
									<th>읽음여부</th>
									<th>보낸날짜</th>
								<%} %>
								</tr> 
							</thead> 
							<tbody> 
							<% 
							for(int i=0; i<msgList.size();i++){
								mdto = (MsgDTO) msgList.get(i);
								
							%>
								
									<% if(msgDiv == 0){ 
										if(mdto.getMsg_chk() == 0){%>
										<tr class="<%=mdto.getMsg_idx() %> chkcolor"> 
										
											<td><input id="chkPro<%=i%>" class="allchk" type="checkbox" name="msg_idx" value="<%=mdto.getMsg_idx() %>" style="zoom:1.5;" onclick='checkSelectAll(this)'></td> 
											<td class="msgDetail<%=i%>" ><%=mdto.getSend_nick() %></td> 
											<td class="msgDetail<%=i%>" ><input id="msgContent" class="<%=mdto.getMsg_idx() %> chkcolor" value="<%=mdto.getMsg_content() %>" readonly onfocus="this.blur();"></td> 
											<td class="msgDetail<%=i%>" ><%=mdto.getMsg_date()%></td>
										</tr>
										<%}else{ %>
										<tr class="<%=mdto.getMsg_idx() %> chkcolor2"> 
				 							<td><input id="chkPro<%=i%>" class="allchk" type="checkbox"  name="msg_idx" value="<%=mdto.getMsg_idx() %>" style="zoom:1.5;" onclick='checkSelectAll(this)'></td> 
											<td class="msgDetail<%=i%>" ><%=mdto.getSend_nick() %></td> 
											<td class="msgDetail<%=i%>" ><input id="msgContent" style="color: #848484" value="<%=mdto.getMsg_content() %>" readonly onfocus="this.blur();"></td> 
											<td class="msgDetail<%=i%>" ><%=mdto.getMsg_date()%></td>
										</tr>
										<%} %>
									<%}else{%>
									<tr style="color: #848484"> 
										<td><input id="chkPro<%=i%>" class="allchk" type="checkbox" name="msg_idx" value="<%=mdto.getMsg_idx() %>" style="zoom:1.5;" onclick='checkSelectAll(this)'></td> 
										<td class="msgDetailSend<%=i%>"><%=mdto.getRecv_nick() %></td> 
										<td class="msgDetailSend<%=i%>"><input id="msgContent" style="color: #848484" value="<%=mdto.getMsg_content() %>" readonly onfocus="this.blur();"></td> 
										<td class="msgDetailSend<%=i%>"><%if(mdto.getMsg_chk() == 0){ %>
											읽지 않음
											<%}else{ %>
											읽음
											<%} %>
										</td>
										<td class="msgDetailSend<%=i%>"><%=mdto.getMsg_date()%></td>
									</tr>
									<%}
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
    
    
    
    <!-- 쪽지 쓰기 모달 Start -->
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
                    	<input type="hidden" name="write_recv" id="recv_nick_list" >
                    <div style="margin-top: 30px; width: 100%;">
                    	<h4 style="float: left; padding-top: 4px; margin-right: 15px">받는사람 : </h4>
                    	<div id="box">
                    		<div style="float: left;">
				            <input type="text" placeholder="받는 사람" id="recv_nick" style="width: 150px"> 
				        	</div>
				        </div>
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
    <!-- 쪽지 쓰기 모달 END -->
    
    
    
     <!-- 받은 쪽지 자세히 보기 Start -->
    <div id="detailModal" class="detailModal">
    <div class="detail-modal-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="row">
                <div class="page-header">
                	<img src="./img/msgRecv.png" style="width: 70px; margin-right: 10px; margin-top: 10px;float: left;">
		            <h1 style="float: left; margin-top: 15px">받은 쪽지</h1>
		            <img src="./img/exit.png" style="width: 35px; float: right;" id="msgExit2">
		        </div>
		        <hr>
                    	<input type="hidden" value="<%=user_nick %>" name="recv_nick">
                    <div style="margin-top: 30px; width: 100%">
                    	<h4 style="float: left; padding-top: 4px; margin-right: 15px">보낸 사람 : </h4>
                    	<input type="text" name="send_nick" id="detailSend" readonly onfocus="this.blur();">
                    </div>
                    <div style="margin-top: 10px; width: 100%; margin-bottom: 20px">
                    	<h6 style="float: left; margin-right: 10px; padding-top: 4px">날짜 :</h6>
                    	<input type="text" name="send_nick" id="detailSend_date" readonly onfocus="this.blur();" >
                    </div>
                    <div class="form-group">
		               <textarea name="msg_content" id="detailSend_content" cols="30" rows="10" class="form-control"  style="resize: none;" disabled="disabled"></textarea>
		               <button class="services-icon-wap btnSend" id="msgRE" style="float: right; margin-top: 10px"><i class="fa fa-envelope mx-2"></i>답장</button>
                    </div>
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
    <!-- 받은 쪽지 자세히 보기 End -->
    
    
     <!-- 보낸 쪽지 자세히 보기 Start -->
    <div id="detailModalSend" class="detailModalSend">
    <div class="detail-modal-Send-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="row">
                <div class="page-header">
                	<img src="./img/msgRecv.png" style="width: 70px; margin-right: 10px; margin-top: 10px;float: left;">
		            <h1 style="float: left; margin-top: 15px">보낸 쪽지</h1>
		            <img src="./img/exit.png" style="width: 35px; float: right;" id="msgExit3">
		        </div>
		        <hr>
                    <div style="margin-top: 30px; width: 100%">
                    	<h4 style="float: left; padding-top: 4px; margin-right: 15px">받는 사람 : </h4>
                    	<input type="text" name="recv_nick" id="detailRecv" readonly onfocus="this.blur();">
                    </div>
                    <div style="margin-top: 10px; width: 100%; margin-bottom: 10px">
                    	<h6 style="float: left; margin-right: 10px; padding-top: 4px">날짜 :</h6>
                    	<input type="text" id="detailRecv_date" readonly onfocus="this.blur();" >
                    </div>
                    <div style="width: 100%; margin-bottom: 20px">
                    	<h6 style="float: left; margin-right: 10px; padding-top: 4px">읽음여부 :</h6>
                    	<input type="text" id="detailRecv_chk" readonly onfocus="this.blur();" >
                    </div>
                    <div class="form-group" style="margin-bottom: 50px">
		               <textarea name="msg_content" id="detailRecv_content" cols="30" rows="10" class="form-control"  style="resize: none;" disabled="disabled"></textarea>
                    </div>
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
    <!-- 보낸 쪽지 자세히 보기 End -->
    
    
    
    
    <%
		}
    %>


    

<%@ include file="../inc/footer.jsp" %>
</body>

</html>