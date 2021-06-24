<%@page import="com.prod.db.ProdDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.prod.db.ProdDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>prod_trade_list.jsp</title>
</head>
<body>

<h1>WenContent/prod_trade/prod_trade_list.jsp</h1>


<%
	List productList = (List) request.getAttribute("productList");

//request.setAttribute("productListCount", pDAO.getProductCount());
//int productListCount = (int)request.getAttribute("productListCount");
//request.setAttribute("productListWant", pDAO.getProductList(startRow,pageSize));
//ArrayList productListWant = (ArrayList) request.getAttribute("productListWant");
	ProdDAO pDAO = new ProdDAO();
	int cnt = pDAO.getProductCount();
	
	List productListWant = (List)request.getAttribute("productListWant");
	
	int pageNum = Integer.parseInt(request.getAttribute("pageNum").toString());
	int pageSize = Integer.parseInt(request.getAttribute("pageSize").toString());
	int currentPage = Integer.parseInt(request.getAttribute("currentPage").toString());
	
	int item = -1 ;
	if(request.getParameter("item") !=null){
		 item = Integer.parseInt( request.getParameter("item"));
	}
	//System.out.println(item);
	
	ProdDTO pDTO = new ProdDTO();

%>
		<a href="./main.bo">메인</a>
		<!-- int값으로 selected 값...하 안돼요  -->
		<select onchange="if(this.value) location.href=(this.value);" name="category">
					<option value="./ProductList.pr" selected="selected">카테고리</option>
					<option value="./ProductList.pr?">전체</option>
					<option value="./ProductList.pr?item=0"
					<% if(item == 0){ %>
										selected
										<%} %>>디지털기기</option>
					<option value="./ProductList.pr?item=1"
					<% if(item == 1){ %>
										selected
										<%} %>>생활가전</option>
					<option value="./ProductList.pr?item=2"
					<% if(item == 2){ %>
										selected
										<%} %>>가구/인테리어</option>
					<option value="./ProductList.pr?item=3"
					<% if(item == 3){ %>
										selected
										<%} %>>유아용품</option>
					<option value="./ProductList.pr?item=4"
					<% if(item == 4){ %>
										selected
										<%} %>>생활/가공식품</option>
					<option value="./ProductList.pr?item=5"
					<% if(item == 5){ %>
										selected
										<%} %>>스포츠/레저</option>
					<option value="./ProductList.pr?item=6"
					<% if(item == 6){ %>
										selected
										<%} %>>여성잡화/의류</option>
					<option value="./ProductList.pr?item=7"
					<% if(item == 7){ %>
										selected
										<%} %>>남성잡화/의류</option>
					<option value="./ProductList.pr?item=8"
					<% if(item == 8){ %>
										selected
										<%} %>>게임/취미</option>
					<option value="./ProductList.pr?item=9"
					<% if(item == 9){ %>
										selected
										<%} %>>뷰티/미용</option>
					<option value="./ProductList.pr?item=10"
					<% if(item == 10){ %>
										selected
										<%} %>>반려동물용품</option>
					<option value="./ProductList.pr?item=11"
					<% if(item == 11){ %>
										selected
										<%} %>>도서/티켓/음반</option>
					<option value="./ProductList.pr?item=12"
					<% if(item == 12){ %>
										selected
										<%} %>>식물</option>
					<option value="./ProductList.pr?item=13"
					<% if(item == 13){ %>
										selected
										<%} %>>기타 중고물품</option>
			</select>

	<table border="1">
	
		<%
			int size = productList.size();	
			int col = 6;
			//int row = (size/col)+((size%col>0)? 1:0);
			int row = 2 ;// (size/col)+((size%col>0)? 1:0);
			int num = (pageNum-1)*row*col; //0;
		
			if(size >0 && num <= size){	
			
			for(int i=0;i<row;i++){
		%>	
		
		<tr>
			<% for(int j=0;j<col;j++){ 
				if(num >= size) break; 
				pDTO = (ProdDTO)productList.get(num);%>
			<td>
				<%
				 String imgfile = pDTO.getProd_img().split(",")[0];
				 if((imgfile == null) || (imgfile.equals("null"))){
					 imgfile = "product_default.jpeg"; 
				 }
				%>
			<a href="./ProductDetail.pr?num=<%=pDTO.getProd_num()%>">
				<img src="./upload/<%=imgfile%>"
					 width="150" height="150"><br>
					 <%=pDTO.getProd_sub() %>
					 </a><br>
					 <%=pDTO.getProd_price() %>
			
			</td>
		<%
			num++;
		if (size<=num) break;
		
			} %>
		</tr>
		<% }
		}else{%>
		<tr>
			<td> 해당되는 상품이 없습니다.</td>
		</tr>
		<%} %>
	</table>
		
	<input type="button" value="글쓰기"
				onclick="location.href='ProductRegister.pr'">
		
<!-- ///////////////////////////////////// 페이지 하단부 /////////////////////////////////////-->



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
				<a href="ProductList.pr?pageNum=<%=startPage-pageBlock%>&item=<%=item%>">[이전]</a>
				<%
				
			}
			//숫자1....5
			
			for(int i=startPage;i<=endPage;i++){
		
				if ( item > 0 ){
				%>
				<a href="ProductList.pr?pageNum=<%=i%>&item=<%=item%>">[<%=i %>]</a>
				<%
				}else{
					%>
					<a href="ProductList.pr?pageNum=<%=i%>">[<%=i %>]</a>
					<%
				}
				
				////////////////옵션별 페이징 처리(상품 갯수만큼 페이징 처리하기)////////////////
				//./ProductList.pr?item=< %=pDTO.getProd_category()% >
			}
			//다음 (기존의 페이지 블럭보다 페이지의 수가 많을때)
			if(endPage < pageCount){
				%>
				
				<a href="ProductList.pr?pageNum=<%=startPage+pageBlock%>&item=<%=item%>">[다음]</a>
				
				<%
				
			}
			
			
			
		}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	%>




















</body>
</html>