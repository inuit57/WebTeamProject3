<%@page import="com.prod.db.ProdDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.prod.db.ProdDTO"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>prod_trade_list.jsp</title>
<!-- <script src="./js/jquery-3.6.0.js"></script> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

</head>
<style>
 	table, tr, td{ 
 		border: 1px; 
 		margin-left: auto;  
		margin-right: auto;  
 		text-align: center;
	}  
	
	


</style>


   <script type="text/javascript">
  
  	$(document).ready(function(){
  		$("#searchBtn").click(function() {
  			$("#searchProfr").submit();
  		});	
	});
  	 
  </script>

<body>

<div class="container">
<!-- <h1>WenContent/prod_trade/prod_trade_list.jsp</h1> -->

<%
	String nick = (String)session.getAttribute("user_nick");

	List productList = (List) request.getAttribute("productList");

	ProdDAO pDAO = new ProdDAO();
	//int cnt = pDAO.getProductCount();
	
	int cnt = productList.size(); 	
	
	//List productListWant = (List)request.getAttribute("productListWant");
	
	int pageNum = Integer.parseInt(request.getAttribute("pageNum").toString());
	int pageSize = Integer.parseInt(request.getAttribute("pageSize").toString());
	int currentPage = Integer.parseInt(request.getAttribute("currentPage").toString());
	
	String itemS = request.getParameter("item") ;
	String search_type = request.getParameter("search_type"); 
	String search_text = request.getParameter("search_text") ; 
	int item = -1 ; 
	if(itemS!= null && !itemS.equals("")){
		item =  Integer.parseInt( itemS);
	}
//	int item = -1 ;
// 	if(request.getParameter("item") !=null || !request.getParameter("item").equals("")){
// 		 item = Integer.parseInt( request.getParameter("item"));
// 	}
	
	ProdDTO pDTO = new ProdDTO();
%>

    <!-- Start Content -->
    <div class="container py-5">
        <div class="row">
		<div class="col-lg-3"  style="background-color:#f2fffe; text-align: center;">
		<% if(user_nick != null){ %>
		 <% if(user_profile == null || user_profile.equals("")){ %>
				<img class="profile1234" src="./img/default_image.png" >
			<%}else{ %>
				<img class="profile1234" src="./upload/<%=user_profile%>">
			<%} %>
                <h4 style="text-align:center; margin-bottom: 40px; color:#59ab6e"><%=user_nick %>님</h4>
             <%} %>   
		<h4 style="margin-top: 50px; margin-bottom: 20px">검색 조건 설정</h4>
		<form action="./ProductList.pr" method="get" id="searchProfr">
			<select name="item">
					<option value="" selected="selected">전체</option>
					<option value="0"
					<% if(item == 0){ %>
										selected
										<%} %>>디지털기기</option>
					<option value="1"
					<% if(item == 1){ %>
										selected
										<%} %>>생활가전</option>
					<option value="2"
					<% if(item == 2){ %>
										selected
										<%} %>>가구/인테리어</option>
					<option value="3"
					<% if(item == 3){ %>
										selected
										<%} %>>유아용품</option>
					<option value="4"
					<% if(item == 4){ %>
										selected
										<%} %>>생활/가공식품</option>
					<option value="5"
					<% if(item == 5){ %>
										selected
										<%} %>>스포츠/레저</option>
					<option value="6"
					<% if(item == 6){ %>
										selected
										<%} %>>여성잡화/의류</option>
					<option value="7"
					<% if(item == 7){ %>
										selected
										<%} %>>남성잡화/의류</option>
					<option value="8"
					<% if(item == 8){ %>
										selected
										<%} %>>게임/취미</option>
					<option value="9"
					<% if(item == 9){ %>
										selected
										<%} %>>뷰티/미용</option>
					<option value="10"
					<% if(item == 10){ %>
										selected
										<%} %>>반려동물용품</option>
					<option value="11"
					<% if(item == 11){ %>
										selected
										<%} %>>도서/티켓/음반</option>
					<option value="12"
					<% if(item == 12){ %>
										selected
										<%} %>>식물</option>
					<option value="13"
					<% if(item == 13){ %>
										selected
										<%} %>>기타 중고물품</option>
			</select>
			
			<select name="search_type">
				<option value="seller"
				<% if(search_type!=null && search_type.equals("seller")){ %> selected="selected" <%} %>
				>
					작성자
				</option>
				<option value="content"
				
				<% if(search_type!=null &&  !search_type.equals("seller")){ %> selected="selected" <%} %>
				>
					제목/내용
				</option>
			</select>
			<input class="form-control" type="text" name="search_text" placeholder="검색어를 입력하세요"
				<% if ( search_text != null){ %>
					value=<%= search_text %>
				<%} %>
			>
		    <i class="fa fa-search" id="searchBtn"  style="float: right; margin-top: -35px;font-size:30px; margin-right: 20px"></i>
			<br> 
			<input class="form-control" type="number" name="min_price" value="<%=request.getParameter("min_price")%>" style="width: 45%;float: left;"> 
			<h5 style="float: left;width: 10%;margin-top: 10px "> ~ </h5> 
			<input class="form-control" type="number" name="max_price" value="<%=request.getParameter("max_price")%>" style="width: 45%;float: left;">	
			<i class="fa fa-won-sign" style="width:10px;float: left; margin-top: -25px;font-size:13px"></i>
			<i class="fa fa-won-sign" style="width:10px;float: right;margin-top: -25px; margin-right: 42%;font-size:13px"></i>
			
			<input class="services-icon-wap btnSend" type="reset" value="조건 초기화">		
			</form>
	<input  class="services-icon-wap btn4321" type="button" value="상품 등록"
				onclick="location.href='ProductRegister.pr'" style="margin-top: 70px"><br>
			</div>
			
	<div class="col-lg-9">
		<div class="tbl">
	
		<%
			int size = productList.size();	
			int col = 5;
			//int row = (size/col)+((size%col>0)? 1:0);
			int row = 2 ;// (size/col)+((size%col>0)? 1:0);
			int num = (pageNum-1)*row*col; //0;
		
			if(size >0 && num <= size){	

			for(int i=0;i<row;i++){
		%>	
		<div class="tbl_tr">
		
			<% for(int j=0;j<col;j++){ 
				if(num >= size) break; 
				pDTO = (ProdDTO)productList.get(num);%>
				<%
				 String imgfile = pDTO.getProd_img();
			if(imgfile != null){
				imgfile =  pDTO.getProd_img().split(",")[0];
			}
				 if((imgfile == null) || (imgfile.equals("null"))){
					 imgfile = "product_default.jpg"; 
				 }
				%>
			<div class="col-md-4" style="float:left;">
            <div class="card mb-4 product-wap rounded-0" onclick="location.href='./ProductDetail.pr?num=<%=pDTO.getProd_num()%>&pageNum=<%=pageNum%>'">
            <div class="card rounded-0">
				<img class="card-img rounded-0 img-fluid" 
				     src="./upload/<%=imgfile%>" >
			</div>
			<div class="card-body">
					 <h5 class="contentHid" ><b><%=pDTO.getProd_sub() %></b></h5>
					 <p style="margin-top: 10px"><%=pDTO.getUser_nickname() %></p>
					  <h6 style="float: left;margin-top: 10px;"><b><fmt:formatNumber value="<%=pDTO.getProd_price()%>" pattern="#,###,###"/>원</b></h6>
					  <h6 style="float: right;margin-top: 10px;font-size: 14px; color: #59ab6e"> <%=pDAO.timeForToday(pDTO.getProd_num()) %></h6>

			</div>
			</div>
			</div>
		<%
			num++;
		if (size<=num) break;
		
			} %>
		</div>	
		<% }
		}else{%>
		<div>
			 해당되는 상품이 없습니다.
		</div>	 
		<%} %>
	</div>
<!-- ///////////////////////////////////// 페이지 하단부 /////////////////////////////////////-->
</div>
	</div>
	<div align="center">
	<ul class="pagination pagination-lg justify-content-end">
	<%
		if(size != 0){
			int pageCount = cnt / pageSize + (cnt%pageSize == 0? 0 : 1);
			
			//한 화면에 보여줄 페이지 번호의 갯수 (페이지 블럭)
			int pageBlock = (size/(col*row))+1  ;
			if(pageBlock > 10) pageBlock = 10; 
			
			// 최대 : 5
			// 한페이지에 보이는 거 최대 갯수 : max_view_cnt =  col * row = 12 
			// 상품 갯수 : size 
			// 5보다 작은가?? size / max_view_cnt + 1 
					// 1 / 12  = 0 + 1 
					// 13 /12 = 1 +1 = 2 
			
			//페이지 블럭의 시작페이지 번호
			// ex) 1~10 페이지 : 1페이지, 11~20페이지 : 11페이지, 21~30페이지 : 21페이지
			int startPage = ((currentPage-1)/pageBlock)*pageBlock +1;
			
			//페이지 블럭의 끝 페이지 번호
			int endPage = startPage+pageBlock-1;
			
			if(endPage > pageCount){
				endPage = pageCount;
			}
			
			//이전 (해당 페이지블럭의 첫번째 페이지 호출)
			if(startPage > pageBlock){
				%>
				<li class="page-item">
				<a class="page-link rounded-0 mr-3 shadow-sm border-top-0 border-left-0 text-dark" href="ProductList.pr?pageNum=<%=startPage-pageBlock%>&item=<%=item%>">이전</a>
				</li>
				<%
			}
			//숫자1....5
			
			
			for(int i=startPage;i<=endPage;i++){
		
				if ( item > 0 ){
				%>
				<li class="page-item">
				<a class="page-link rounded-0 mr-3 shadow-sm border-top-0 border-left-0 text-dark" href="ProductList.pr?pageNum=<%=i%>&item=<%=item%>"><%=i %></a>
				</li>
				<%
				}else{
					%>
					<li class="page-item">
					<a class="page-link rounded-0 mr-3 shadow-sm border-top-0 border-left-0 text-dark" href="ProductList.pr?pageNum=<%=i%>"><%=i %></a>
					</li>
					<%
				}
			}
			//다음 (기존의 페이지 블럭보다 페이지의 수가 많을때)
			if(endPage < pageCount){
				%>
				<li class="page-item">
				<a class="page-link rounded-0 mr-3 shadow-sm border-top-0 border-left-0 text-dark" href="ProductList.pr?pageNum=<%=startPage+pageBlock%>&item=<%=item%>">다음</a>
				</li>
				<%
			}
		}
	%>
			</ul>
                    
</div>
</div>
</div>
</body>
</html>
<%@ include file="../inc/footer.jsp" %>