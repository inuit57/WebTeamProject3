<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>신고하기</title>
<script src="./js/jquery-3.6.0.js"></script>
<script type="text/javascript">

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
	<%=user_nick %>님 환영합니다.

<%
	// 전달된 게시판번호 저장
	int board_num = Integer.parseInt(request.getParameter("board_num"));
	String decl_writer = request.getParameter("decl_writer");
	String board_sub = request.getParameter("board_sub");
	int board_type = Integer.parseInt(request.getParameter("board_type"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
			
%>
	<h1>'<%=board_sub %>' 입니다.<br>
	 신고사유를 선택해주세요</h1>
	<form action="declarationNormalAction.decl" method="post">
		
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
		신고사유 <br>
		<input type="radio" value="1" name="decl_reason">부적절한 홍보 게시글 <br>
		<input type="radio" value="2" name="decl_reason">음란성 또는 청소년에게 부적합한 내용<br>
		<input type="radio" value="3" name="decl_reason">중고거래 게시글이 아니에요<br>
		<input type="radio" value="4" name="decl_reason">전문 판매업자 같아요<br>
		<input type="radio" value="5" name="decl_reason">사기 글이에요<br>
		<input type="radio" value="6" name="decl_reason" >기타<br>
		기타사유 입력<br>
		<input type="text" name="decl_content" placeholder="기타사유를 입력하세요" maxlength="500" style="width: 300px; height: 50px"><br>
<!--  		<textarea rows="5" cols="20" name="textarea" placeholder="기타사유를 입력하세요" ></textarea>  -->
		<br>
		<input type="submit" value="신고하기">
		
	</form>



<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/footer.jsp"/> 
<!-- 푸터 들어가는 곳 -->
</body>
</html>