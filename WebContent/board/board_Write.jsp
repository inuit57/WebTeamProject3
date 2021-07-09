<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
</head>
<script type="text/javascript" src="./smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script src="./js/jquery-3.6.0.js"></script>

<body>
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/> 
<!-- 헤더파일들어가는 곳 -->
<%
	// 세션제어
	String user_nick = (String)session.getAttribute("user_nick");
%>
<%-- 	<%=user_nick %>님 환영합니다. --%>
<%

	if (user_nick == null) {
	%>
  		<script type="text/javascript">
			alert("로그인이 필요한 서비스입니다.");	
			location.href="@@@@@@@";
		</script>
	<%		
	}	
%>
<div class="container">
<br><br>
	<fieldset style="margin:auto;  width: 800px;">
		<form action="./BoardWriteAction.bo" method="post" name="fr" >
		<div>
		지역 : <select name="board_area">
					<option value="서울">서울</option>
					<option value="경기">경기</option>
					<option value="대전">대전</option>
					<option value="부산">부산</option>
					<option value="울산">울산</option>
					<option value="대구">대구</option>
					<option value="광주">광주</option>
					<option value="강원도">강원도</option>
					<option value="인천">인천</option>
			   </select>
		</div>
		<div>
			 <input type="hidden" name="user_nickname" value="<%=user_nick %>"> <br>
		제목 : <input type="text" name="board_sub" >
		</div>
		<br>
		<div>
		<textarea name="board_content" id="smartEditor" style="width: 100%; height: 412px;"></textarea><br>
		</div>
		<hr>
		
			<!-- <button type="button" id="savebutton" >등록</button> -->
			<div align="right">
			<input type="submit" class="btn btn-success" id="savebutton" value="글쓰기">
			</div>
		</form>
	</fieldset>	
	<br>
</div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/footer.jsp"/> 
<!-- 푸터 들어가는 곳 -->	
</body>
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
         
         if(document.fr.faq_sub.value == ""){
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

</html>