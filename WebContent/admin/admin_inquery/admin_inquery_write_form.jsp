<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>1:1 문의 답변 작성</title>
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



	
	
	<%
	 int num = Integer.parseInt(request.getParameter("num"));
	String nick = (String) session.getAttribute("user_nick");
	%>
		
				<div id="col-lg-3">
			
				<h1 class="h2 pb-4">관리자 게시판</h1>
						
			<ul class="list-unstyled templatemo-accordion">
			<li  class="pb-3">
			<a class="collapsed d-flex justify-content-between h3 text-decoration-none" href="#">
				회원목록 조회
				<i class="fa fa-fw fa-chevron-circle-down mt-1"></i>
                        </a>
				 	<ul id="collapseTwo" class="collapse list-unstyled pl-3">
					<li><a class="text-decoration-none" href="./AdminUserList.au">전체</a></li>
					<li><a class="text-decoration-none" href="./AdminUserList.au?auth=1">일반회원</a></li>
					<li><a class="text-decoration-none" href="./AdminUserList.au?auth=2">관리자</a></li>
					</ul>
					</li>				
				<li class="pb-3">
				<a class="collapsed d-flex justify-content-between h3 text-decoration-none" href="#">
				1:1 문의 내역조회
				 <i class="pull-right fa fa-fw fa-chevron-circle-down mt-1"></i>
                        </a>
				 	<ul id="collapseTwo" class="collapse list-unstyled pl-3">
					<li><a class="text-decoration-none" href="./InqueryAdminList.ai">전체</a></li>
					<li><a class="text-decoration-none" href="./InqueryAdminList.ai?check=0">답변 요청글</a></li>
					<li><a class="text-decoration-none" href="./InqueryAdminList.ai?check=1">답변 완료글</a></li>
					</ul>
				</li>
											
				<li class="pb-3">
				<a class="collapsed d-flex justify-content-between h3 text-decoration-none" href="#">
				신고내역 조회
				<i class="pull-right fa fa-fw fa-chevron-circle-down mt-1"></i>
                        </a>
				 	<ul id="collapseTwo" class="collapse list-unstyled pl-3">				 		
				 	<li><a  class="text-decoration-none" href="./decl_prod_list.decl?state=0">상품게시판</a></li>	
				 	<li><a  class="text-decoration-none" href="./decl_normal_list.decl?state=1">일반게시판</a></li>
				 	</ul>	
					</li>
			</ul>		
				
		</div>		
		<div class="ad-content0">
		<br>
		<h1 style="text-align: center; ">1:1 문의 답변글 작성</h1>
		<br>
		
		<form  name="fr" action="./InqueryAdminWriteAction.ai" method="post">
		<input type="hidden" name="num" value="<%=num%>">
		<input type="text" class="form-control" name="name" value="<%=nick %>" placeholder="nickname">
		<input type="text" class="form-control" name="subject" placeholder="제목을 입력하세요">
		<textarea class="form-control" rows="20" name="content" id="smartEditor" style="width: 100%; height: 412px;"></textarea><br>
			<br><br>
		<button class="btn btn-outline-success" type="button" id="savebutton" >등록</button>
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