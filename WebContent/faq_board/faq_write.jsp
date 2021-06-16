<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	 <fieldset>
     <legend> 관리자 상품등록 하기</legend>
     <form action="./GoodsAddAction.ag" method="post" enctype="multipart/form-data">
       <table border="1">
         <tr>
           <td>카테고리</td>
           <td>
             <select name="category">
               <option value="outwear">외투</option>
               <option value="fulldress">정장/신사복</option>
               <option value="Tshirts">티셔츠</option>
               <option value="shirts">와이셔츠</option>
               <option value="pants">바지</option>
               <option value="shoes">신발</option>
             </select>
           </td>
         </tr>
         
         <tr>
           <td>상품이름</td>
           <td>
             <input type="text" name="name">
           </td>           
         </tr>
         <tr>
           <td>판매가격</td>
           <td>
             <input type="text" name="price">
           </td>
         </tr>
         <tr>
           <td>색상</td>
           <td>
             <input type="text" name="color">
           </td>
         </tr>
         <tr>
           <td>수량</td>
           <td>
             <input type="text" name="amount">
           </td>
         </tr>
         <tr>
           <td>크기</td>
           <td>
             <input type="text" name="size">
           </td>
         </tr>
         <tr>
           <td>제품정보</td>
           <td>
              <input type="text" name="content">
           </td>
         </tr>
         <tr>
           <td>제품이미지1(메인)</td>
           <td>
              <input type="file" name="file1" accept="image/*,.pdf">           
              
           </td>
         </tr>
           <tr>
           <td>제품이미지2</td>
           <td>
             <input type="file" name="file2">
           </td>
         </tr>
           <tr>
           <td>제품이미지3</td>
           <td>
             <input type="file" name="file3">
           </td>
         </tr>
           <tr>
           <td>제품이미지4</td>
           <td>
             <input type="file" name="file4">
           </td>
         </tr>
       
        <tr>
          <td colspan="2">
            <input type="submit" value="상품등록">
            <input type="reset" value="상품초기화">
          </td>
        </tr>
       </table>     
     </form>   
   </fieldset>
   
   
   
   
   



</body>
</html>