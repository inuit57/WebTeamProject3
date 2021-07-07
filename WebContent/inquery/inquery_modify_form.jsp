<%@page import="com.inquery.db.InqueryDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="./smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script src="./js/jquery-3.6.0.js"></script>
</head>
<body>
	<h1>1:1 문의 수정</h1>

<%
	
	InqueryDTO inDTO = (InqueryDTO) request.getAttribute("inDTO");
	
%>

		<form  name="fr" action="./InqueryModify.in" method="post">
		글번호 :  <input type="text" name="num" value="<%=inDTO.getInq_num() %>" readonly><br>
		글쓴이 : <input type="text" name="name"  value="<%=inDTO.getUser_nickname() %>" readonly>  <br>
		제목 : <input type="text" id="subject" name="subject" value="<%=inDTO.getInq_sub()%>" ><br> 
		<textarea class="form-control" rows="20" name="content" id="smartEditor" style="width: 100%; height: 412px;">
		<%=inDTO.getInq_content() %>
		</textarea><br>
	
		<button type="button" id="savebutton" >수정</button>
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






</body>
</html>