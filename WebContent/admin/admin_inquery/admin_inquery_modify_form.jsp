<%@page import="com.inquery.db.InqueryDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>1:1문의 수정</title>
<script type="text/javascript" src="./smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script src="./js/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="./assets/css/bootstrap.min.css">
<link rel="stylesheet" href="./css/admin.css">
<%@ include file="../../inc/top.jsp" %>

<script type="text/javascript">
$(function(){
	
	
	
	
		$('.li1').click(function(){
			// 왼쪽 사이드 메뉴바 토글
			$(this).next().fadeToggle('slow',function(){
				
			})
			
		});

	
});


</script>



</head>
<body>
	<h1 style="text-align: center;">1:1 문의 수정 폼</h1>

<%
	InqueryDTO inDTO = (InqueryDTO) request.getAttribute("inDTO");
	
%>

	
		<div id="ad-sidebar">
			
			<a href="./AdminBoard.ap">관리자 게시판	</a>
						
			<ul>
				<li class="li1">회원목록 조회</li>
				 <div class="li-1">
				 	<ul>
					<li><a href="./AdminUserList.au">전체</a></li>
					<li><a href="./AdminUserList.au?auth=1">일반회원</a></li>
					<li><a href="./AdminUserList.au?auth=2">관리자</a></li>
					</ul>
				 </div>					
				<li class="li1">1:1 문의 내역조회</li>
				 <div class="li-1">
				 	<ul>
					<li><a href="./InqueryAdminList.ai">전체</a></li>
					<li><a href="./InqueryAdminList.ai?check=0">답변 요청글</a></li>
					<li><a href="./InqueryAdminList.ai?check=1">답변 완료글</a></li>
					</ul>
				 </div>								
				<li class="li1">신고내역 조회</li>
				 <div class="li-1">
				 	<ul>
				 	<li><a href="./declarationList.decl">전체</a></li>	
				 	<li><a href="./decl_prod_list.decl?state=0">상품게시판</a></li>	
				 	<li><a href="./decl_normal_list.decl?state=1">일반게시판</a></li>
				 	</ul>	
				 </div>
							
			</ul>		
				
		</div>


		<div class="ad-content0">

	
		<form  name="fr" action="./InqueryAdminModify.ai" method="post">
		<input type="text" class="form-control" name="num" value="<%=inDTO.getInq_num() %>" readonly>
		<input type="text" class="form-control" name="name" value="<%=inDTO.getUser_nickname() %>" readonly>
		<input type="text" class="form-control" name="subject" value="<%=inDTO.getInq_sub()%>" placeholder="제목을 입력하세요"> 
		<textarea class="form-control" rows="20" name="content" id="smartEditor" style="width: 100%; height: 412px;">
		<%=inDTO.getInq_content() %>
		</textarea><br><br>
	
		<button class="btn btn-outline-success" type="button" id="savebutton" >수정</button>
		</form>	
	
		
</div>
	
	
<script type="text/javascript">
   var oEditors = []; 
   
   nhn.husky.EZCreator.createInIFrame({ 
      oAppRef : oEditors, 
      elPlaceHolder : "smartEditor", 
      sSkinURI : "./smarteditor2/SmartEditor2Skin.html",
      fCreator : "createSEditor2", 
      htParams : { 
         bUseToolbar : true, // 툴바 사용 여부
         bUseVerticalResizer : false, // 입력창 크기 조절바 사용 여부
         bUseModeChanger : false // 모드 탭(Editor | HTML | TEXT) 사용 여부

         } 
   });


   $(function() { 
      $("#savebutton").click(function() { 
         oEditors.getById["smartEditor"].exec("UPDATE_CONTENTS_FIELD", []); 
         
         var content = document.getElementById("smartEditor").value;
         
         if(document.fr.subject.value == ""){
            alert("제목을 입력해주세요");
            return false;
         }
          
         if(content == "" || content == null || content == '&nbsp;' || content == '<br>' || content == '<br/>' || content == '<p>&nbsp;</p>'){
            alert("본문을 작성해주세요."); 
            oEditors.getById["smartEditor"].exec("FOCUS"); 
            return; 
         } 
          
         document.fr.submit(); 
         
         }); 
      })
         
</script>



</body>
<div class="footer">
<%@ include file="../../inc/footer.jsp" %>
</div>
</html>