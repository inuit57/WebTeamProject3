<%@page import="com.board.db.boardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<script type="text/javascript" src="./smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script src="./js/jquery-3.6.0.js"></script>
<body>
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/> 
<!-- 헤더파일들어가는 곳 -->
<%
	// 세션제어
	
	// 전달된 정보저장
	boardDTO bDTO = (boardDTO)request.getAttribute("bDTO");
	String pageNum = request.getParameter("pageNum");
%>

<div class="container">
<br><br>

	<fieldset style="margin:auto;  width: 800px;">
		<form action="./BoardModifyAction.bo?board_num=<%=bDTO.getBoard_num() %>&pageNum=<%=pageNum %>" name="fr" method="post">
			제목 : <input type="text" name="board_sub" value="<%=bDTO.getBoard_sub()%>" > <br>
			지역 :
				<select name="board_area" >
					<option value="서울"
					<%if(bDTO.getBoard_area().equals("서울")){ %>selected<%} %>
					>서울</option>
					<option value="경기"
					<%if(bDTO.getBoard_area().equals("경기")){ %>selected<%} %>
					>경기</option>
					<option value="대전"
					<%if(bDTO.getBoard_area().equals("대전")){ %>selected<%} %>
					>대전</option>
					<option value="부산"
					<%if(bDTO.getBoard_area().equals("부산")){ %>selected<%} %>
					>부산</option>
					<option value="울산"
					<%if(bDTO.getBoard_area().equals("울산")){ %>selected<%} %>
					>울산</option>
					<option value="대구"
					<%if(bDTO.getBoard_area().equals("대구")){ %>selected<%} %>
					>대구</option>
					<option value="광주"
					<%if(bDTO.getBoard_area().equals("광주")){ %>selected<%} %>
					>광주</option>
					<option value="강원도"
					<%if(bDTO.getBoard_area().equals("강원도")){ %>selected<%} %>
					>강원도</option>
					<option value="인천"
					<%if(bDTO.getBoard_area().equals("인천")){ %>selected<%} %>
					>인천</option>
			   </select> <br>
			<a>내용</a>  <br>
			<textarea name="board_content" id="smartEditor" style="width: 100%; height: 412px;">
				<%=bDTO.getBoard_content() %>
				</textarea>
			<hr>
			<button type="button" id="savebutton">수정하기</button>
		</form>
	</fieldset>
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
         
         var board_content = document.getElementById("smartEditor").value;
         
         if(document.fr.board_sub.value == ""){
            alert("제목을 입력해주세요");
            return false;
         }
          
         if(board_content == "" || board_content == null || board_content == '&nbsp;' || board_content == '<br>' || board_content == '<br/>' || board_content == '<p>&nbsp;</p>'){
            alert("본문을 작성해주세요."); 
            oEditors.getById["smartEditor"].exec("FOCUS"); 
            return; 
         } 
          
         document.fr.submit(); 
         
         }); 
      })
         
</script>
</html>