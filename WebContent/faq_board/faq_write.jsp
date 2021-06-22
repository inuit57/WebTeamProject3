<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="./smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script src="./js/jquery-3.6.0.js"></script>
<%
request.setCharacterEncoding("UTF-8");
%>

<body>
	<h3>자주묻는질문</h3> 
	
	<form action="./FAQAddAction.faq" method="post" name="fr">
	
		<div>
			카테고리 
			<select name="faq_cate">
	               <option value="etc">기타</option>
	               <option value="oper">운영정책</option>
	               <option value="uid">계정/인증</option>
	               <option value="sell">구매/판매</option>
	               <option value="proc">거래 품목</option>
	     </select>
		</div>
		<div>
			제목 
			<input type="text" name="faq_sub">
		</div>
		<div>
			<textarea name="faq_content" id="smartEditor" style="width: 100%; height: 412px;"></textarea>
		</div>
	    <button type="button" id="savebutton" >등록</button>
	
	</form>


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