<%@page import="com.prod.db.ProdDTO"%>
<%@page import="com.prod.db.ProdDAO"%>
<%@page import="com.chat.db.chatDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.chat.db.chatDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="jquery/jquery-3.6.0.js"></script>
<script type="text/javascript">
		

	
		function goChat(i) {
			
			var val = document.getElementById('btn'+i).value;

			$(function(){
				$.ajax('./MakeSession.ch', {
					type: "POST",
					data : {val:val},
					async: false,
					success: function(data) {
						location.href = "./chat.ch";
					}
				});
			});
			


			
			
		}
	
	
	</script>

<style type="text/css">

body {
	background-color: #5BAC70;
	text-align: center;
	
}

#table {
	
}

</style>
<title>Insert title here</title>
</head>
<body>

	
	<%
	request.setCharacterEncoding("UTF-8");
	String seller = (String)session.getAttribute("seller");
	int prod_num = (Integer)session.getAttribute("prod_num");
	
	chatDAO cdao = new chatDAO();
	ProdDAO pdao = new ProdDAO();
	
	ProdDTO pdto = new ProdDTO();
	
	pdto = pdao.getProduct(prod_num);
	
	ArrayList<chatDTO> alist = cdao.getRoomList(seller, prod_num);
	
	int chatRoomNum = alist.size();
			
	
	%>
	
	<h1>나의 판매 채팅 리스트</h1>
	<h2>게시글 : <%=pdto.getProd_sub() %></h2>
	<% if(chatRoomNum == 0) { %>
		<h1>채팅이 없습니다.</h1>
	<% } else { %>
	
			<table id="table">
				<colgroup>
					<col width="300px" />
					<col width="300px" />
				</colgroup>
				<tr>
					<td>구매자</td>
					<td>채팅으로</td>
				</tr>
	<% 		for(int i = 0; i < alist.size(); i++) { %>
				<tr>
					<td><%=alist.get(i).getChat_buyer() %></td>
					<td>
					
					<input type="hidden" id="roomId<%=i %>" value="<%=alist.get(i).getChat_roomid()%>">
<%-- 					<button onclick="goChat(<%=alist.get(i).getChat_roomid()%>);">이동</button> --%>
					<button id="btn<%=i %>" onclick="goChat(<%=i %>);" value="<%=alist.get(i).getChat_roomid()%>">이동</button>
					
					</td>
				</tr>
	<% 		} %>
			</table>
	<%} %>
	
	
</body>
</html>