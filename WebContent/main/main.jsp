<%@page import="com.wish.db.WishDTO"%>
<%@page import="com.wish.db.WishDAO"%>
<%@page import="com.prod.db.ProdDAO"%>
<%@page import="com.auction.db.AuctionDAO"%>
<%@page import="com.prod.db.ProdDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../inc/top.jsp" %>


<!-- Modal -->
    <div class="modal fade bg-white" id="templatemo_search" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="w-100 pt-1 mb-5 text-right">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="" method="get" class="modal-content modal-body border-0 p-0">
                <div class="input-group mb-2">
                    <input type="text" class="form-control" id="inputModalSearch" name="q" placeholder="Search ...">
                    <button type="submit" class="input-group-text bg-success text-light">
                        <i class="fa fa-fw fa-search text-white"></i>
                    </button>
                </div>
            </form>
        </div>
    </div>



    <!-- Start Banner Hero -->
    <div id="template-mo-zay-hero-carousel" class="carousel slide" data-bs-ride="carousel">
        <ol class="carousel-indicators">
            <li data-bs-target="#template-mo-zay-hero-carousel" data-bs-slide-to="0" class="active"></li>
            <li data-bs-target="#template-mo-zay-hero-carousel" data-bs-slide-to="1"></li>
            <li data-bs-target="#template-mo-zay-hero-carousel" data-bs-slide-to="2"></li>
        </ol>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <div class="container">
                    <div class="row p-5">
                        <div class="mx-auto col-md-8 col-lg-6 order-lg-last">
                            <img class="img-fluid" src="./assets/img/about-hero.svg" alt="">
                        </div>
                        <div class="col-lg-6 mb-0 d-flex align-items-center">
                            <div class="text-align-left align-self-center">
                                <h1 class="h1 text-success"><b>ㄱ Market</b></h1>
                                <p>소중한 기억을 거래하는 안전한 
                                  <a rel="sponsored" class="text-success" >중고거래</a><br> 지금 바로
                                  <a rel="sponsored" class="text-success" >기억마켓</a>에서 만나보세요!
                                <br><small> Safe used goods for precious 
                                 <a rel="sponsored" class="text-success" >memories</a>.  <br>
                                  Let's meet at the <a rel="sponsored" class="text-success" >ㄱ market</a> now!</small>
                                  
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="container">
                    <div class="row p-5">
                        <div class="mx-auto col-md-8 col-lg-6 order-lg-last">
                            <img class="img-fluid" src="./assets/img/banner_img_03.jpg" alt="">
                        </div>
                        <div class="col-lg-6 mb-0 d-flex align-items-center">
                            <div class="text-align-left">
                                <h3 class="h2 text-success">거래간의 안전거래를 약속합니다.</h3>
                                <p>
                                    거래가 완료되면 <a rel="sponsored" class="text-success" >구매확정</a> 버튼을 눌러주세요!<br>
                                    비대면 거래 시 안전하게 거래 할 수 있는 
                                    <a rel="sponsored" class="text-success" >ㄱ 코인</a>을 이용해<br>
                                    더욱더 믿을 수 있는 <a rel="sponsored" class="text-success" >편리한 거래</a>를 시작해보세요. 
                                    <small>Safely conduct non-face-to-face transactions with 
                                    <a rel="sponsored" class="text-success" >ㄱ coins</a>! <br>
                                   	Start transactions that are more 
                                   	<a rel="sponsored" class="text-success" >reliable and convenient</a>.
                                    </small>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="container">
                    <div class="row p-5">
                        <div class="mx-auto col-md-8 col-lg-6 order-lg-last">
                            <img class="img-fluid" src="./img/title.png" alt="">
                        </div>
                        <div class="col-lg-6 mb-0 d-flex align-items-center">
                            <div class="text-align-left">
                                <h3 class="h2">기억을 공유해보세요. </h3>
                                <p>
                                   <a rel="sponsored" class="text-success" > ㄱ 마켓</a>
                                   에서는 가까운 이웃으로부터 <br> <a rel="sponsored" class="text-success" >기억</a>
                                   을 공유할 수 있는 공간을 제공합니다. <br>
                                    <a rel="sponsored" class="text-success" >소중한 기억</a>으로 새로운 인연을 만드세요!<br>
                                    <small>
                                    Provides space for sharing<a rel="sponsored" class="text-success" > memories</a>.<br>
									Create a new relationship with <a rel="sponsored" class="text-success" >precious memories</a>!
                                    </small>
                                   
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <a class="carousel-control-prev text-decoration-none w-auto ps-3" href="#template-mo-zay-hero-carousel" role="button" data-bs-slide="prev">
            <i class="fas fa-chevron-left"></i>
        </a>
        <a class="carousel-control-next text-decoration-none w-auto pe-3" href="#template-mo-zay-hero-carousel" role="button" data-bs-slide="next">
            <i class="fas fa-chevron-right"></i>
        </a>
    </div>
    <!-- End Banner Hero -->

	 <!-- Start Categories of The Month -->
    <section class="container py-5">
        <div class="row text-center pt-3">
            <div class="col-lg-6 m-auto">
                <h1 class="h1">Using the Memory Market</h1>
                <p>
                    <a href="./UserLogin.us" class="main-filled-button">Login</a>
                    <a href="./UserJoinChk.us" class="main-filled-button">Join in</a>
                </p>
            </div>
        </div>
        <div class="row">
            <div class="col-12 col-md-4 p-5 mt-3">
                <a href="#"><img src="./assets/img/category_img_01.jpg" class="rounded-circle img-fluid border"></a>
                <h5 class="text-center mt-3 mb-3">중고거래하기</h5>
                <p class="text-center"><a href="./ProductList.pr" class="main-filled-button">click!!</a></p>
            </div>
            <div class="col-12 col-md-4 p-5 mt-3">
                <a href="#"><img src="./assets/img/category_img_02.jpg" class="rounded-circle img-fluid border"></a>
                <h2 class="h5 text-center mt-3 mb-3">경매하기</h2>
               <p class="text-center">	<a href="./AuctionList.ac" class="main-filled-button"
               			style="text-align: center;">click!!</a></p>
            </div>
            <div class="col-12 col-md-4 p-5 mt-3">
                <a href="#"><img src="./assets/img/category_img_03.jpg" class="rounded-circle img-fluid border"></a>
                <h2 class="h5 text-center mt-3 mb-3">일반게시판</h2>
                	<p class="text-center"><a href="./board_List.bo" class="main-filled-button">click!!</a></p>
            </div>
        </div>
    </section>
    <!-- End Categories of The Month -->


 
<%
	ProdDAO pDAO = new ProdDAO();

    
                                    		
    WishDAO wDAO = new WishDAO();
%>

<%
	//for(int i=0; i<size;i++){
		
   	List prodList = (List)pDAO.getProductList();
   	ProdDTO pDTO = new ProdDTO();
		
		//if(size <= 3) break; %>
    <!-- Start Featured Product -->
    <section class="bg-light" >
        <div class="container py-5">
            <div class="row text-center py-3">
                <div class="col-lg-6 m-auto">
                    <h1 class="h1">Today's memories</h1>
                    <p>
                        실시간으로 올라오는 오늘의 기억을 만나보세요.
                    </p>
                </div>
            </div>
           
           <div  style="display: flex; margin-left: 13%; margin-top: 10px;"">
           <%for(int i=0; i<prodList.size(); i++){ %> 
            <div class="row">
                <div class="col-12 col-md-4 mb-4">
                    <div class="card h-100" style="width: 300px; margin-left: 10px;">
                        <a href="shop-single.html">
                 
	 				 <%
	 					pDTO = (ProdDTO)prodList.get(i);
	 				
                 		String imgfile = pDTO.getProd_img();
                 		
                 			if(imgfile != null){
                 				imgfile = pDTO.getProd_img().split(",")[0];
                 				System.out.println("@@@@@@@@@dfsdfasdfasdfsafd@"+imgfile);
                 			}
                 			if((imgfile == null)  || (imgfile.equals("null"))){
                 				imgfile = "product_default.jpg"; 
                 			} %>
                            <img src="./upload/<%=imgfile%>" class="card-img-top">
                        </a>
                        <div class="card-body">
                            <ul class="list-unstyled d-flex justify-content-between">
                                <li>
                                    <a href="shop-single.html" class="h2 text-decoration-none text-dark">${prodList.prod_sub }</a>
                                </li>
                                <li class="text-muted text-right">
                                 <fmt:formatNumber value="<%= pDTO.getProd_price() %>" pattern="#,###,###"/>원
                                </li>
                            </ul>
                            <p class="card-text">
								<%= pDTO.getProd_content() %>
                            </p>
                            <p class="text-muted"></p>
                        </div>
                        
                        
                    </div>
                
                </div>
              </div>
              <%} %>
          </div>
 	</div>
    </section>
   
    <!-- End Featured Product -->

<%@ include file="../inc/footer.jsp" %>
