<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>신고하기</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<script src="./js/jquery-3.6.0.js"></script>
<script type="text/javascript">

		function check1(){
			
			var decl_reason = document.fr.decl_reason.value;
			
			if(decl_reason == ""){
				alert("신고사유를 선택하세요.");
				return false;
				}
			}

		$(document).ready(function(){
		
		// 라디오버튼 클릭시 이벤트 발생
	    $("input:radio[name=decl_reason]").click(function(){
	 
	        if($("input[name=decl_reason]:checked").val() == "6"){
	            $("input:text[name=decl_content]").attr("disabled",false);
	            // radio 버튼의 value 값이 6이라면 활성화
	 
	        }else if($("input[name=decl_reason]:checked").val() == "1" || "2" || "3" || "4" || "5"){
	              $("input:text[name=decl_content]").attr("disabled",true);
	            // radio 버튼의 value 값이 1,2,3,4,5이면 비활성화
	        }
	    });
		
	})
	


</script>

</head>

<body>
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/> 
<!-- 헤더파일들어가는 곳 -->
<%
	// 한글처리
	request.setCharacterEncoding("UTF-8");
	
	// 세션제어
	String user_nick = (String)session.getAttribute("user_nick");
%>
	
<%
	// 전달된 게시판번호 저장
	int board_num = Integer.parseInt(request.getParameter("board_num"));
	String decl_writer = request.getParameter("decl_writer");
	String board_sub = request.getParameter("board_sub");
	int board_type = Integer.parseInt(request.getParameter("board_type"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
			
%>
<div style="margin-left: 40%">
	<form action="declarationNormalAction.decl" name="fr" method="post" onsubmit ="return check1();">
	<br>
	<h2>'<%=board_sub %>' 입니다.<br>
	 신고사유를 선택해주세요</h2>
		<br>
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<input type="hidden" name="board_num" value="<%=board_num%>">
		<input type="hidden" name="user_nickname" value="<%=user_nick%>"><!-- 신고 하는사람 -->
		<input type="hidden" name="board_sub" value="<%=board_sub%>">
		<input type="hidden" name="board_type" value="<%=board_type%>">
		<input type="hidden" name="decl_state" value="1"> <!-- 신고처리 상태 1: 신고접수 2: 처리완료 -->
		
		작성자 : <br>
		<input type="text" name="decl_writer" value="<%=decl_writer%>" readonly><br> <!-- 신고당하는 글 작성자 -->
		제목 : <br>
		<input type="text" name="board_sub" value="<%=board_sub%>" readonly><br>
		<br><h5>• 신고사유</h5>
		<input type="radio" id="radio" value="1" name="decl_reason">부적절한 홍보 게시글 <br>
		<input type="radio" id="radio" value="2" name="decl_reason">음란성 또는 청소년에게 부적합한 내용<br>
		<input type="radio" id="radio" value="3" name="decl_reason">중고거래 게시글이 아니에요<br>
		<input type="radio" id="radio" value="4" name="decl_reason">전문 판매업자 같아요<br>
		<input type="radio" id="radio" value="5" name="decl_reason">사기 글이에요<br>
		<input type="radio" id="radio" value="6" name="decl_reason" >기타<br>

		<input type="text" name="decl_content" placeholder="기타사유를 입력하세요" maxlength="500" style="width: 350px; height: 50px"><br>
		<br>
		<input type="submit" class="btn btn-danger" style="margin-bottom: 2%; margin-left: 30%"  value="신고하기" >
	</form>
</div>


<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/footer.jsp"/> 
<!-- 푸터 들어가는 곳 -->
</body>
</html>