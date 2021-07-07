<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp" %>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/style.css">

</head>
<script type="text/javascript" src="./smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script src="./js/jquery-3.6.0.js"></script>
<%
	request.setCharacterEncoding("UTF-8");
%>

<body>
	<div class="container">
	<br><br>  
	<div style="margin:auto;  width: 800px;">
	
	<h1>FAQ 등록</h1> 
	
	<form action="./FAQAddAction.faq" method="post" name="fr">
	
		<div style="margin-top: 50px;">
			<select name="faq_cate" style="float: left;width: 20%;height: 50px">
	               <option value="etc">기타</option>
	               <option value="oper">운영정책</option>
	               <option value="uid">계정/인증</option>
	               <option value="sell">구매/판매</option>
	               <option value="proc">거래 품목</option>
	     </select>
	     <input class="form-control" type="text" name="faq_sub" placeholder="제목을 입력해주세요" style="height: 50px;float: left; width:80%">
		</div>
		<div style="color: #CEF6D8">z</div>
		<div>
			<textarea name="faq_content" id="smartEditor" style="width: 100%; height: 412px; background-color: white;"></textarea>
		</div>
		
		<div align="right">
	    	<button class="services-icon-wap btnSend" type="button" id="savebutton" >등록</button>
		</div>
	</form>

	</div>
	</div>
	<br><br>
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
<%@ include file="../inc/footer.jsp" %>