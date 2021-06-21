<%@page import="com.faq.db.FAQDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<!-- <script src="./js/jquery-3.6.0.js"></script> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<body>

 <%
 	request.setCharacterEncoding("UTF-8");
 
    List faqList = (List) request.getAttribute("faqList");
 
 	FAQDTO fdto = null;
  %>
  
  
    <script type="text/javascript">
  
  	$(document).ready(function(){
  		$("#chkDel").click(function() {
  			if($("input:checkbox").is(":checked")){
  				var fr = document.listchkDel;
  				fr.submit();
  			}else{
  				alert("삭제할 글을 선택하세요");
  			}
  		});	
	});
  	 
  </script>
  <script type="text/javascript">
	  function faqSearch() {
			
			if(document.searchFrom.faq_search.value == ""){
				alert("키워드를 입력해주세요");
				return false;
			}
	
				document.searchFrom.submit();
			
				
		}
  </script>
  
  

	<h3>자주묻는질문</h3> 
	
	<form action="./FAQSerchAction.faq" method="post" name="searchFrom">
	<input type="text" name="faq_search" placeholder="검색어를 입력해주세요">
    <input type="button" onclick="faqSearch()" id="searchBtn" style="margin-left:-30px;" value="검색"> 
    </form>
    
    
    <br><br>
    <a href="./FAQ.faq">전체 | </a>
    <a href="./FAQ.faq?tag=oper">운영정책 | </a>
    <a href="./FAQ.faq?tag=uid">계정,인증 | </a>
    <a href="./FAQ.faq?tag=sell">구매,판매 | </a>
    <a href="./FAQ.faq?tag=proc">거래 품목 | </a>
	<a href="./FAQ.faq?tag=etc">기타</a>
    <hr>
	<br>
	
	
	<input type="button" onclick="location.href='./FAQAdd.faq'" value="글쓰기">
	<input type="button" id="chkDel" value="선택  삭제">
	<br>
	<br>
	
	
	<form  action="./FAQDelAction.faq" method="post"  name="listchkDel">
	<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
	<% 
		
		for(int i=0; i<faqList.size();i++){
			fdto = (FAQDTO) faqList.get(i);
		%>
		
		  <div class="panel panel-default">
		    <div class="panel-heading" role="tab">
		      <div class="panel-title">
		        <input type="checkbox" name="faq_idx" value="<%=fdto.getFaq_idx() %>">
		        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapse<%=i %>" aria-expanded="false" aria-controls="collapse<%=i %>">
		         <h3><img src="./img/faq_q.png" style="width: 1.5vw"> <%=fdto.getFaq_sub() %></h3>
		        </a>
		      </div>
		    </div>
		    <div id="collapse<%=i %>" class="panel-collapse collapse" role="tabpanel" >
		      <div class="panel-body">
		        <h4><img src="./img/faq_a.png" style="width: 1.5vw; margin-bottom: 30px; margin-right: 15px "> <%=fdto.getFaq_content() %></h4>
		        <input type="button" onclick="location.href='./FAQUpdate.faq?idx=<%=fdto.getFaq_idx() %>'" id="chkUpdate" style="margin-top: 30px"  value="글수정">
		      </div>
		    </div>
		  </div>
		<%	
		}
		
	%>
	 </div>
	</form>



	
	
</body>
</html>