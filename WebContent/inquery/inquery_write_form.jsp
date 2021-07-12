<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="./smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script src="./js/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="./css/admin.css">
<%@ include file="../inc/top.jsp" %>

<style>

.cont1{
	 width: 85%;
    padding: 20px;
    margin-bottom: 20px;
    float:right;  
    overflow: hidden;
    height: 1000px;
    text-align: center;

}

button{
	clear:both;

}

.cont1 a{
	text-decoration: none;
	color:black;
}

.cont1 a:hover{
	background-color: green;
	color:white;
}



</style>


</head>
<body>
<%
String nick = (String) session.getAttribute("user_nick");
%>

	<h1 style="margin-top: 3%; text-align: center;">1:1 문의글 작성</h1>
<div class="cont1">

	<form  name="fr" action="./InqueryWriteAction.in" method="post">
	<input type="text" class="form-control" name="name" value="<%=nick %>" placeholder="nickname" readonly>
	<input type="text" class="form-control" id="subject" name="subject" placeholder="제목을 입력하세요">
		
	<textarea class="form-control" rows="20" name="content" id="smartEditor" style="width: 100%; height: 412px;"></textarea><br><br>

	<button class="btn btn-outline-success" type="button" id="savebutton" >작성</button>
	</form>	
	
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

</div>
</body>
<div class="footer">
<%@ include file="../inc/footer.jsp" %>
</div>
</html>