<%@page import="com.user.db.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="./inc/JS/top.js"></script>


<link href="./img/title.png" rel="shortcut icon" type="image/x-icon">
<title>기억마켓</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="apple-touch-icon" href="./assets/img/apple-icon.png">
    <link rel="shortcut icon" type="image/x-icon" href="../assets/img/favicon.ico">

    <link rel="stylesheet" href="./assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="./assets/css/templatemo.css">
    <link rel="stylesheet" href="./assets/css/custom.css">

    <!-- Load fonts style after rendering the layout styles -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
    <link rel="stylesheet" href="./assets/css/fontawesome.min.css">
    
    <link rel="stylesheet" href="./assets/css/templatemo-breezed.css">
    
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
   
</head>

<body>

<%
   request.setCharacterEncoding("UTF-8");
   
   String user_nick = (String) session.getAttribute("user_nick");
   String user_profile = (String) session.getAttribute("user_profile");
   
%>


<script>
   $(document).ready(function () {
      
      
      // 쪽지 알림 
      $.ajax({
             url:'./MsgAlarmAction.ms',
              type:'post',
              data:{"user_nick":"<%=user_nick%>"}, 
              success:function(data){
                 
                if(data.trim() == 0){
                   $("#circle2").addClass('circle10');
                }else{
                   $("#circle2").removeClass('circle10');
                   $("#circle2").val(data);
                }
             
                
                
                     },
                    error:function(){
                      alert("에러입니다");
                     }
           }); // 읽음여부
      // 쪽지 알림   
      
   });
   
   

   
</script>


<nav class="navbar navbar-expand-lg bg-dark navbar-light d-none d-lg-block" id="templatemo_nav_top" style="position: sticky; top:0px; left: 0px; z-index: 9999; width: 100%;">
        <div class="container text-light">
            <div class="w-100 d-flex justify-content-between">
                <div>
                    <i class="far fa-paper-plane  mx-2"></i>
                    <a class="navbar-sm-brand text-light text-decoration-none" href="mailto:info@company.com">info@company.com</a>
                    <i class="fa fa-phone mx-2"></i>
                    <a class="navbar-sm-brand text-light text-decoration-none" href="tel:010-020-0340" style="margin-right: 10px">010-020-0340</a>
                    <a class="text-light" href="https://fb.com/templatemo" target="_blank" rel="sponsored"><i class="fab fa-facebook-f fa-sm fa-fw me-2"></i></a>
                    <a class="text-light" href="https://www.instagram.com/" target="_blank"><i class="fab fa-instagram fa-sm fa-fw me-2"></i></a>
                    <a class="text-light" href="https://twitter.com/" target="_blank"><i class="fab fa-twitter fa-sm fa-fw me-2"></i></a>
                    <a class="text-light" href="https://www.linkedin.com/" target="_blank"><i class="fab fa-linkedin fa-sm fa-fw"></i></a>
                </div>
                <div> 
                   <%
                  if (user_nick != null) {
                     %>

                     <a href="#" style="margin-right: 30px" id="atag" onclick="openWindowInfo();"><%=user_nick %>님</a>
                     <a href="./UserLogoutAction.us" style="margin-right: 30px" id="atag">로그아웃</a>
                     <a href="./Payment.pa" style="margin-right: 30px" id="atag">충전</a>
                     <a href="./MsgListAction.ms">
                           <i class="fa fa-envelope" aria-hidden="true" id="atag"></i>
                           <input type="text" class="circle10" id="circle2" readonly onfocus="this.blur();" >
                     </a>

                     <%
                  }%>
                    
                </div>
            </div>
        </div>
    </nav>
    <!-- Close Top Nav -->


    <!-- Header -->
    <nav class="navbar navbar-expand-lg navbar-light shadow" style="position: sticky; top:40px; left: 0px; z-index: 9999; width: 100%; background-color: white;">
        <div class="container d-flex justify-content-between align-items-center" >

            <a class="navbar-brand text-success logo h1 align-self-center" href="./Main.do">
                <img src="./img/logo_1.png" style="width: 200px">
            </a>

            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#templatemo_main_nav" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="align-self-center collapse navbar-collapse flex-fill  d-lg-flex justify-content-lg-between" id="templatemo_main_nav">
                <div class="flex-fill">
                    <ul class="nav navbar-nav d-flex justify-content-between mx-lg-auto">
                        <li class="nav-item">
                           <a class="nav-link" href="./ProductList.pr">Shop</a>
                        </li>
                        <li class="nav-item">
                           <a class="nav-link" href="./AuctionList.ac">Auction</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="./board_List.bo">Board</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="./FAQ.faq">FAQ</a>
                        </li>
                             
                    <%
                      UserDAO admin = new UserDAO();
                        if(admin.isAdmin(user_nick) == true){ %>
                        <li class="nav-item">
                           <a class="nav-link" href="./AdminBoard.ap">관리자</a>
                        </li>
                        <%} %>
                         
                    </ul>
                </div>
                <div class="navbar align-self-center d-flex">
                    <div class="d-lg-none flex-sm-fill mt-3 mb-4 col-7 col-sm-auto pr-3">
                        <div class="input-group">
                            <input type="text" class="form-control" id="inputMobileSearch" placeholder="Search ...">
                            <div class="input-group-text">
                                <i class="fa fa-fw fa-search"></i>
                            </div>
                        </div>
                    </div>
                   
                    
                    
                    <%
                    
                   
                  if (user_nick == null) {
                     %>
                     <a href="./UserLogin.us">LOGIN </a>
                     <p>&emsp; &emsp;</p>
                     <a href="./UserJoinChk.us">JOIN</a>
                     <%
                  }else{
                     %>
                     
                     
                     <% 
                  }
                    %>
                    
                    
                    
                    
                </div>
            </div>

        </div>
    </nav>
    <!-- Close Header -->