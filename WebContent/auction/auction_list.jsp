<%@page import="com.auction.db.AuctionDAO"%>
<%@page import="com.auction.bid.db.bidDAO"%>
<%@page import="com.auction.db.AuctionDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../inc/top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>auction_list.jsp</title>
</head>

<style>
	table, tr, td{
		border: 1px;
		margin-left: auto; 
		margin-right: auto; 
		text-align: center;
		
	}


</style>

<body>

<div class="container">
<!-- <h1>WenContent/prod_trade/prod_trade_list.jsp</h1> -->

<%
	String nick = (String)session.getAttribute("user_nick");
	
	List AuctionList = (List) request.getAttribute("AuctionList");
	int pageNum = Integer.parseInt(request.getAttribute("pageNum").toString());
	//System.out.println("@@@@@@@@@@@@@@@@@"+pageNum);
	
	
	bidDAO bDAO = new bidDAO(); 
	AuctionDTO aDTO = new AuctionDTO();
	AuctionDAO aDAO = new AuctionDAO();
%>

<br>
<br>
		<select onchange="if(this.value) location.href=(this.value);" name="auc">
					<option selected>선택</option>
					<option value="./AuctionList.ac?auc=0">팝니다</option>
					<option value="./AuctionList.ac?auc=1">거래완료</option>
			</select>
			<% if(user_nick != null){ %>
				<input type="button" value="경매 등록"
						onclick="location.href='AuctionRegister.ac'"><br>
				
			<%} %>			
			<table border="1" class="table" style="height: 500px">
	
		<%
			int size = AuctionList.size();
			int col = 6; //열
			int row = size / col +1; //행
			int num = (pageNum-1)*row*col;
			
			if(size > 0 && num <= size){
				
				for(int i=0;i<row;i++){
				%>	
				
				<tr>
					<% for(int j=0;j<col;j++){ 
						if(num >= size) break; 
						aDTO = (AuctionDTO)AuctionList.get(num);%>
					<td>
						<%
						 String imgfile = aDTO.getAuct_img();
					if(imgfile != null){
						imgfile =  aDTO.getAuct_img().split(",")[0];
					}
						 if((imgfile == null) || (imgfile.equals("null"))){
							 imgfile = "product_default.jpg"; 
						 }
						%>
					<div class="card-body">	
					<a href="./AuctionDetail.ac?num=<%=aDTO.getAuct_num()%>&pageNum=<%=pageNum%>">
						<img src="./upload/<%=imgfile%>"
							 width="150" height="150"><br>
						 <h5 class="contentHid" ><b><%=aDTO.getAuct_sub() %></b></h5>	 
						 <p style="margin-top: 10px"><%=aDTO.getUser_nick() %></p>	 
							 </a>
						<span id="maxPrice">
							 <h6 style="margin-top: 10px;font-size: 1vw;"><b>
							최고가 : <fmt:formatNumber value="<%=bDAO.getMaxPrice(aDTO.getAuct_num())%>" pattern="#,###,###"/>원</b></h6></span>
							<br>
							<h6 style="margin-top: -20px;font-size: 1vw;"><b>
							최저가 : <fmt:formatNumber value="<%=aDTO.getAuct_price()%>" pattern="#,###,###"/>원</b></h6>
							<h6 style="margin-top: 10px;font-size: 0.8vw; color: #59ab6e"> <%=aDAO.timeForToday(aDTO.getAuct_num()) %></h6>
						
							</div>
					</td>
				<%
				num++;
			if (size<=num) break;
			
				} // 안쪽 for %>
			</tr>
			<%} // 바깥for %>
			<% 
			}else{%>
		<tr>
			<td> 해당되는 상품이 없습니다.</td>
		</tr>
		<%}%>
				
	</table>
		

</div>
</body>
</html>
<%@ include file="../inc/footer.jsp" %>