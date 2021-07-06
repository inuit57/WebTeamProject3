<%@page import="com.auction.db.AuctionDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>auction_list.jsp</title>
</head>
<body>

<div class="container">
<!-- <h1>WenContent/prod_trade/prod_trade_list.jsp</h1> -->

<%
	String nick = (String)session.getAttribute("user_nick");
	
	List AuctionList = (List) request.getAttribute("AuctionList");
	int pageNum = Integer.parseInt(request.getAttribute("pageNum").toString());
	//System.out.println("@@@@@@@@@@@@@@@@@"+pageNum);
	
	
	
	AuctionDTO aDTO = new AuctionDTO();
%>

<br>
<br>
		<select onchange="if(this.value) location.href=(this.value);" name="status">
					<option value="./AuctionList.ac" selected="selected">전체</option>
					<option value="./AuctionList.ac?auc=0" >팝니다</option>
					<option value="./AuctionList.ac?auc=1" >거래완료</option>
			</select>
	<input type="button" value="경매 등록"
				onclick="location.href='AuctionRegister.ac'"><br>
	<table border="1" class="table" style="height: 700px">
	
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
					<a href="./AuctionDetail.ac?num=<%=aDTO.getAuct_num()%>&pageNum=<%=pageNum%>">
						<img src="./upload/<%=imgfile%>"
							 width="150" height="150"><br>
							 <%=aDTO.getAuct_sub() %>
							 </a><br>
							 <%=aDTO.getAuct_price() %> <br>
							 <%=aDTO.getUser_nick() %>
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