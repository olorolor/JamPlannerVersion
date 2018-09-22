<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%   String id=(String)session.getAttribute("id"); %>
<!DOCTYPE html>
<html lang="en">

<head>
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
     <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
   <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
   <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
   <spring:url value="/resources/mainPage/js/mainPageJs.js" var="mainPageJs" />
   <spring:url value="/resources/mainPage/css/mainPageCss.css" var="mainPageCss" />
   <script src="${mainPageJs}"></script>
   <link href="${mainPageCss}" rel="stylesheet" />
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
     <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" ></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>Document</title>

</head>
<body>
<!--네비게이션-->

      <nav class="navbar fixed-top navbar-expand-sm navbar-light bg-light">
        <a href="home.do" class="navbar-brand">
            <i class="far fa-calendar-alt"></i>&nbsp;&nbsp;jamplan
        </a>
        <button class="navbar-toggler" data-toggle="collapse" data-target="#myNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>
        <!--메뉴 모음-->
        <div class="collapse navbar-collapse justify-content-end" id="myNavbar">
        <!-- 모달버튼 -->
            <ul class="nav navbar-nav">
               <%
               if(id==null)
               {
               %>
                <li class="nav-item active" data-toggle="modal" data-target="#myModalLogin"><a class="nav-link" href="#login">login</a></li>
                <%   
               }
               else{ 
                %>
                <li class="nav-item dropdown">
                 <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
                    <%=id%>
                     <i class="fas fa-user"></i>
                 </a>
                 <div class="dropdown-menu" style=>
                 
                      <a class="dropdown-item" id="myroomBtn" href="#">My room</a>
                      <a class="dropdown-item" href="#">My page</a>
                      <a class="dropdown-item" href="#">Message</a>
                 </div>
                </li>
                <li class="nav-item active"><a class="nav-link" href="logout.do">logout</a></li>
                <%
                }
                %>
                <li class="nav-item" data-toggle="modal" data-target="#myModalJoin"><a class="nav-link" href="#">join</a></li>
                <li class="nav-item" data-toggle="modal" data-target="#myModalSns"><a class="nav-link" href="#">Search</a></li>
            </ul>
         <!-- 모달버튼 끝 -->
        </div>
        </nav>
       
      <!--Carousel-->
          <div id="myCarousel" class="carousel slide" data-ride="carousel">
              <ul class="carousel-indicators">
                  <li data-target="#myCarousel" data-slide-to="0" class="active" ></li>
                  <li data-target="#myCarousel" data-slide-to="1"></li>
                  <li data-target="#myCarousel" data-slide-to="2"></li>
              </ul>
           <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="/jamplan/resources/mainPage/img/carousel1.jpg"  alt="cat">
                <div class="carousel-caption">
                    <h1>새로운 여행</h1>
                    <p>상상속의 여행을 현실로 만들어 보세요</p>
                </div>
            </div>
            <div class="carousel-item">
                    <img src="/jamplan/resources/mainPage/img/carousel2.jpg" alt="cat">
                    <div class="carousel-caption">
                        <h1>단체플래너</h1>
                        <p>팀을 이루어 함께 여행 계획을 세워 보세요</p>
                    </div>
            </div>
            <div class="carousel-item">
                    <img src="/jamplan/resources/mainPage/img/carousel2.jpg" alt="cat">
                    <div class="carousel-caption">
                        <h1>고양이</h1>
                        <p>고양이와 강아지는 친구입니다.</p>
                    </div>
            </div>
        </div>

        <a href="#myCarousel" class="carousel-control-prev" data-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </a>
        <a href="#myCarousel" class="carousel-control-next" data-slide="next">
            <span class="carousel-control-next-icon"></span>
        </a>
    </div>
      
   
      <div class="container text-center output" id="search">
       <div class="row">
        <div class="col-md-12">
           <div class="main_top">
            <div class="wrap">
               <div class="main_top_title">
                  나만의 여행 플래너 잼플랜!      
               </div>
               <div class="main_top_desc">
                  쉽고 빠르게 여행을 계획하세요.
               </div>
               
               <div class="search_area">
                  <div class="input-group">
                      <input type= "text" class="search_input" id="city_search" placeholder="국가명, 도시명으로 검색">
                      <div class="input-group-prepend">
                        <button id="searchBtn" class="btn btn-default" type="submit">
                         <i class="fas fa-search"></i>
                        </button>
                     </div>
                  </div>
                  <div id="city_autocomplete"></div>
                  <div class="latest_search">
                           추천도시 : <a href="" class="latest_a">뉴욕</a>
                                 ,<a href="" class="latest_a">타이베이</a>
                                 ,<a href="" class="latest_a">타이베이</a>
                  </div>
               <div class="clear"></div>
               </div>
            </div>
         </div>
         </div>   
           </div>
        </div> 
             
     <!--모달창 login-->
                <div id="myModalLogin" class="modal">
                    <!--모달의 크기 결정-->
                    <!--modal-sm, modal-lg-->
                    <div class="modal-dialog">
            
                        <!-- 모달의 본 컨텐츠 login-->
                        <div class="modal-content">
                            <!--헤더 , 바디, 푸터-->
                            <div class="modal-header">
                                <h4 class="modal-title">login</h4>
                                <button id=closeLogin class="close" type="button" data-dismiss="modal">&times;</button>
                            </div>
                            <div class="modal-body">  
                            
                             <form class="login" action="login.do" method="post" onsubmit="return loginCheck()">
                                <div class="form-group col-sm-12">
                                  <label for="usr1">ID:</label>
                                     <input type="text" class="form-control" id="usr1" name="id">
                                </div>
                              <div class="form-group col-sm-12">
                                  <label for="pwd1">비밀번호:</label>
                                  <input type="password" class="form-control" id="pwd1" name="pass">
                              </div>
                              <div class="col-sm-12">
                                    <button type=submit class="btn btn-outline-primary btn-block">로그인</button>
                                </div>                 
                           </form>
                           
                            </div>
                            <!--modal-footer 에는 row를 쓸 필요가 없다 -->
                            <div class="modal-footer"> 
                               <div class="col-sm-12">
                               <button type="button" onclick="location.href='${url}'" class="btn btn-outline-success btn-block">네이버 아이디로 로그인</button>                               
                               <button id=findA class="btn btn-outline-danger btn-block" data-toggle="modal" data-target="#myModalJoin">아이디/비밀번호 찾기</button>                              
                               </div>
                                
                            </div>
                        </div>
                    </div>
                </div>
                
       <!--모달창  join-->
                <div id="myModalJoin" class="modal">
                    <!--모달의 크기 결정-->
                    <!--modal-sm, modal-lg-->
                    <div class="modal-dialog">
            
                        <!-- 모달의 본 컨텐츠 join-->
                        <div class="modal-content">
                            <!--헤더 , 바디, 푸터-->
                            
                               
                            <div class="modal-header in">
                                <h4 class="modal-title">join</h4>
                                <button id=closeJoin class="close" type="button" data-dismiss="modal">&times;</button>
                            </div>
                            
                            <div class="modal-body in">
                             
                                 <div class="form-group col-sm-12">
                                  <label for="email">Email:</label>
                                     <input type="text" class="form-control" id="email" name="email">
                                </div>
                                <div class="form-group col-sm-12">
                                  <label for="usr2">ID:</label>
                                     <input type="text" class="form-control" id="usr2" name="id">
                                     <button id="idck" class="btn btn-outline-secondary btn-block">중복체크</button>
                                </div>
                              <div class="form-group col-sm-12">
                                  <label for="pwd2">비밀번호:</label>
                                  <input type="password" class="form-control" id="pwd2" name="pass">
                              </div>
                              <div class="col-sm-12">
                                    <button type=submit id=joinB class="btn btn-outline-primary btn-block">회원가입</button>
                                </div>                              
                              
                            
                            
                            </div>
                            <!--modal-footer 에는 row를 쓸 필요가 없다 -->
                            <div class="modal-footer"> 
                                <div class="col-sm-12">
                                 <button type="button" onclick="location.href='${url}'" class="btn btn-outline-success btn-block">네이버 아이디로 회원가입</a></button>
                                  <button class="btn btn-outline-danger btn-block">아이디/비밀번호 찾기</button>
                               </div>                              
                            </div>
                        </div>
                        <div>
                    </div>
                </div>
                </div>
      <!--    모달창 ID/PW 찾기-->
                   <div id="myModalFind" class="modal">
                    <!--모달의 크기 결정-->
                    <!--modal-sm, modal-lg-->
                    <div class="modal-dialog">
            
                        <!-- 모달의 본 컨텐츠 login-->
                        <div class="modal-content">
                            <!--헤더 , 바디, 푸터-->
                            <div class="modal-header">
                                <h4 class="modal-title">ID/PW 찾기</h4>
                                <button class="close" type="button" data-dismiss="modal">&times;</button>
                            </div>
                            <div class="modal-body">  
                            
                             <form class="login" action="login.do" method="post" onsubmit="return loginCheck()">
                                <div class="form-group col-sm-12">
                                  <label for="usr1">ID:</label>
                                     <input type="text" class="form-control" id="usr3" name="id">
                                </div>
                              <div class="form-group col-sm-12">
                                  <label for="pwd1">비밀번호:</label>
                                  <input type="password" class="form-control" id="pwd3" name="pass">
                              </div>
                              <div class="col-sm-12">
                                    <button type=submit class="btn btn-outline-primary btn-block">로그인</button>
                                </div>                 
                           </form>
                           
                            </div>
                            <!--modal-footer 에는 row를 쓸 필요가 없다 -->
                            <div class="modal-footer"> 
                               <div class="col-sm-12">
                               <button type="button" onclick="location.href='${url}'" class="btn btn-outline-success btn-block">네이버 아이디로 로그인</button>
                               <button class="btn btn-outline-danger btn-block">아이디/비밀번호 찾기</button>                              
                               </div>
                                
                            </div>
                        </div>
                    </div>
                </div>
         
                <!--모달창 snslogin-->
            <!--   <div id="myModalSns" class="modal">  -->
                    <!--모달의 크기 결정-->
                    <!--modal-sm, modal-lg-->
                 <!--    <div class="modal-dialog"> -->
            
                        <!-- 모달의 본 컨텐츠 sns-->
                     <!--    <div class="modal-content">
                            헤더 , 바디, 푸터
                            <div class="modal-header" align="center">
                                <h4 class="modal-title" align="center">네이버 로그인</h4>
                                <button class="close" type="button" data-dismiss="modal">&times;</button>
                            </div>
                            <div class="modal-body">
                                <p>본 구역에 내용을 삽입하세요</p>
                                <img src="/jamplan/resources/mainPage/img/dog.jpg" alt="dog">
                            </div>
                            modal-footer 에는 row를 쓸 필요가 없다
                            <div class="modal-footer"> 
                                <div class="col-md-6">
                                    <button class="btn btn-default btn-block">확인</button>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-danger btn-block">취소</button>
                                </div> 
                            </div>
                        </div> -->
                  <!--   </div>
                </div> -->
</body>
</html>