<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<script src="./js/jquery-3.6.0.js"></script>


<body>

	<h3>자주묻는질문</h3> 
	
	<form action="./FAQAddAction.faq" method="post" >
	
		<table border="1">
	         <tr>
	           <td>카테고리</td>
	           <td>
	             <select name="faq_cate">
	               <option value="etc">기타</option>
	               <option value="oper">운영정책</option>
	               <option value="uid">계정/인증</option>
	               <option value="sell">구매/판매</option>
	               <option value="proc">거래 품목</option>
	             </select>
	           </td>
	         </tr>
	         
	         <tr>
	           <td>제목</td>
	           <td>
	             <input type="text" name="faq_sub">
	           </td>           
	         </tr>
	         <tr>
	           <td>내용</td>
	           <td>
	             <input type="text" name="faq_content">
	           </td>
	         </tr>
	         
	         <tr>
	         	<td>첨부파일</td>
	           <td>
	             <input type="file" name="faq_file">
	           </td>
	         <tr>
	         <tr>
	          <td colspan="2">
	            <input type="submit" value="상품등록">
	            <input type="reset" value="상품초기화">
	          </td>
	        </tr>
	       </table>     
	
	</form>
   
   
   
   



</body>
</html>