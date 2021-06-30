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
	<h1>WebContent/inquery/inquery_write_form.jsp</h1>

	<form  name="fr" action="./InqueryWriteAction.in" method="post">
		글쓴이 : <input type="text" name="name"> <br>
		제목 : <input type="text" id="subject" name="subject"><br> 
		<textarea class="form-control" rows="20" name="content" id="smartEditor" style="width: 100%; height: 412px;"></textarea><br>
	
		<button type="button" id="savebutton" >등록</button>
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