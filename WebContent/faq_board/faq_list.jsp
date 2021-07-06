<%@page import="com.user.db.UserDAO"%>
<%@page import="com.faq.db.FAQDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../inc/top.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <title>중고거래(이름미정)</title> -->
<meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" href="./css/style.css">

<!-- <script src="./js/jquery-3.6.0.js"></script> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>


</head>
<body>
 <%
 	request.setCharacterEncoding("UTF-8");
    List faqList = (List) request.getAttribute("faqList");
 
 	FAQDTO fdto = null;
 	UserDAO udao = new UserDAO(); 
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
  

<div class="container">
<br><br>  

	<div style="margin:auto;  width: 800px;">
	<div align="center">
	<h1 style="margin-bottom: 80px">자주 묻는 질문</h1> 
	
	<form class="form-inline" action="./FAQSerchAction.faq" method="post" name="searchFrom">
	 <div class="form-group">
		<input class="form-control" type="text" name="faq_search" placeholder="검색어를 입력해주세요" style="height: 50px">
		<i class="fa fa-search" onclick="faqSearch()" id="searchBtn"  style="float: right; margin-top: -40px;font-size:30px; margin-right: 20px"></i>
	 </div> 
    </form>
    </div>
    <hr>
    <div align="center" class="aTag">
	    <a href="./FAQ.faq">전체  </a>|
	    <a href="./FAQ.faq?tag=oper">운영정책  </a>|
	    <a href="./FAQ.faq?tag=uid">계정,인증  </a>|
	    <a href="./FAQ.faq?tag=sell">구매,판매  </a>|
	    <a href="./FAQ.faq?tag=proc">거래 품목  </a>|
		<a href="./FAQ.faq?tag=etc">기타</a>
    </div>
	<br>
	
	<% if( udao.isAdmin(user_nick)){ %>
		<input type="button" onclick="location.href='./FAQAdd.faq'" value="글쓰기">
		<input type="button" id="chkDel" value="선택  삭제">
		<hr>
	<%} %>
	
	<form  action="./FAQDelAction.faq" method="post"  name="listchkDel">
	<div class="accoContent" style="margin-bottom: 150px">
	<ul class="accordion">
	<% 
		for(int i=0; i<faqList.size();i++){
			fdto = (FAQDTO) faqList.get(i);
		%>
		   <li class="item">
		  	 <h2 class="accordionTitle">
		      <% if( udao.isAdmin(user_nick)){ %>
		        <input type="checkbox" name="faq_idx" value="<%=fdto.getFaq_idx() %>">
		      <%} %>
		        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapse<%=i %>" aria-expanded="false" aria-controls="collapse<%=i %>">
		         <img src="./img/faq_q.png" style="width: 1.5vw"> <%=fdto.getFaq_sub() %>
		        </a>
		      <span class="accIcon"></span>
		     </h2>
		    <div id="collapse<%=i %>" class="text panel-collapse collapse" role="tabpanel" >
		      <div class="panel-body">
		        <h4><img src="./img/faq_a.png" style="width: 1.5vw; margin-bottom: 30px; margin-right: 15px "> <%=fdto.getFaq_content() %></h4>
		        <!--  글 수정 버튼 -->
		        <% if( udao.isAdmin(user_nick)){ %>
		        	<input type="button" onclick="location.href='./FAQUpdate.faq?idx=<%=fdto.getFaq_idx() %>'" id="chkUpdate" style="margin-top: 30px"  value="글수정">
		        <%} %>
		      </div>
		    </div>
		  </li>
		<%	
		}
	%>
	</ul>
	</div>
	</form>
	
	</div>
</div>

	<%@ include file="../inc/footer.jsp" %>
	<script  src="./js/script.js"></script>