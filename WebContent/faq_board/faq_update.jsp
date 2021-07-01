<%@page import="com.faq.db.FAQDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="./smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script src="./js/jquery-3.6.0.js"></script>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	FAQDTO fdto = (FAQDTO) request.getAttribute("fdto");
%>

<div class="container">
	<br><br>  
	<div style="margin:auto;  width: 800px;">

<h3>FAQ 수정</h3> 
	<form action="./FAQUpdateAction.faq" method="post" name="fr">
		<input type="hidden" name="faq_idx" value="<%=fdto.getFaq_idx() %>">  
		
		<div>
			카테고리
	             <select name="faq_cate">
	               <option value="etc"
	               	<%if(fdto.getFaq_cate().equals("etc")){ %>
	               		selected
	               	<%} %>
	               	>기타</option>
	               <option value="oper"
	               	<%if(fdto.getFaq_cate().equals("oper")){ %>
	               		selected
	               	<%} %>
	               	>운영정책</option>
	               <option value="uid"
	               	<%if(fdto.getFaq_cate().equals("etcuid")){ %>
	               		selected
	               	<%} %>
	               	>계정/인증</option>
	               <option value="sell"
	               	<%if(fdto.getFaq_cate().equals("sell")){ %>
	               		selected
	               	<%} %>
	               	>구매/판매</option>
	               <option value="proc"
	               	<%if(fdto.getFaq_cate().equals("proc")){ %>
	               		selected
	               	<%} %>
	               	>거래 품목</option>
	             </select>
	         </div>
	         <div>
				제목 
				<input type="text" name="faq_sub" value="<%=fdto.getFaq_sub()%>">
			</div>
			<div>
				<textarea name="faq_content" id="smartEditor" style="width: 100%; height: 412px;"><%=fdto.getFaq_content()%></textarea>
			</div>

		<div align="right">
	   	   <button type="button" id="savebutton" >저장</button>   
		</div>
	</form>
	
	</div>
	</div>

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