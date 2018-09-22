<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="com.spring.jamplan.model.TeamInfoVO"%>
<%@page import="com.spring.jamplan.model.PlanVO"%>
<%@page import="com.spring.jamplan.model.UserVO"%>

<%
	if ((String)session.getAttribute("id") == null)
		response.sendRedirect("/jamplan/home.do");
	String id = (String) session.getAttribute("id");
	
	if(session.getAttribute("planNo")!=null){
		System.out.print("===========================jsp 세션 초기화=======================");
		session.removeAttribute("planNo");
	}
	/* if( request.getAttribute("teamList") != null){
		List<TeamInfoVO> teamList = (List<TeamInfoVO>) request.getAttribute("teamList");
	} */
	
	
	
%>
    
<!DOCTYPE html>
<html lang="ko">
<head>



<script src="https://code.jquery.com/jquery-3.3.1.js"
	  integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
		  crossorigin="anonymous"></script>

<meta charset="UTF-8">
<meta name="description"
	content="A planner that helps you make more amused plan and share your own memory">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous"></script>
<!-- <script type="text/javascript"
	src="https://code.jquery.com/jquery-3.2.1.min.js"></script> -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- <link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous"> -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
	integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ"
	crossorigin="anonymous">
<link href="https://fonts.googleapis.com/css?family=Josefin+Sans:300, 400,700" rel="stylesheet">
    <link rel="stylesheet" href="./resources/myRoom/css/bootstrap.css">
    <link rel="stylesheet" href="./resources/myRoom/css/animate.css">
    <link rel="stylesheet" href="./resources/myRoom/css/owl.carousel.min.css">
    <!-- Theme Style -->
    <link rel="stylesheet" href="./resources/myRoom/css/style.css">
    
    <spring:url value="./resources/myRoom/js/myRoom.js" var="roomJs" />
	<spring:url value="./resources/myRoom/css/myRoom.css" var="roomCss" />
	<script src="${roomJs}"></script>
	<link href="${roomCss}" rel="stylesheet" />
	<script>
	// 메시지를 실시간으로 처리하기 위한 웹소켓 개통 부분
	<%-- var domain = "ws://localhost:8800/jamplan/jamplanWebSocket";
	function sendMessage() {
		webSocket = new WebSocket(domain);
		// 서버와 연결이 성공하면 자동으로 호출되는 메서드
		webSocket.onopen = function(event) {
			onOpen(event);
		};
		webSocket.onmessage = function(event) {
			onMessage(event);
		};
		webSocket.onerror = function(event) {
			onError(event);
		};
	}
	function onOpen(event) {
		webSocket.send('<%=id%>');
	}
	function onMessage(event) {
		$('#countLabel').append(event.data);
	}
	function onError(event) {
	} --%>
	// 메시지를 실시간으로 처리하기 위한 웹소켓 개통 부분 끝
	window.onload(function () {
		// 팀검색을 시도할 경우 업데이트 사항 보여주기를 멈추고 비슷한 이름들의 팀을 나열해서 보여준다.
		$('#s').on('keyup', function(event) {
			// updateSpace에 나오던 업데이트 작업을 중단한다.
			event.preventDefault();
			if(event.keyCode === 13) {
				alert("검색 keyup이벤트 일단 들어왔다.");
				var teamName = $('#s').val();
				
				// 테이블 형태로 바꿔주기 위해 기존에 있던 업데이트 사항들을
				// 지워준다.
				$('#planPost').empty();
				const searchTeamResult = '';
				
				alert('ajax 직전에 도착');
				
				$.ajax({
						url : '/jamplan/searchTeam.do',
						type : 'POST',
						data : {
							'teamName' : teamName
						},
						dataType : 'json',
						contentType : 'application/x-www-form-urlencoded; charset=utf-8',
						success : function(data) {
							alert("일단 ajax로 받아오긴 했음");
							$.each(data, function(index, item) {			
								searchTeamResult += '<div class="col-md-6">'
									+ '<a href="blog-single.html" class="blog-entry element-animate" data-animate-effect="fadeIn">'
									+ '<img src="./resources/myRoom/images/'${user.image}'" alt="Image placeholder">'
									+ '<div class="blog-content-body">'
									+ '<div class="post-meta">'
									+ '<span class="category">Food</span>'
									+ '<span class="mr-2">March 15, 2018 </span> &bullet;'
									+ '<span class="ml-2"><span class="fa fa-comments"></span> 3</span>'
									+ '</div><h2>There’s a Cool New Way for Men to Wear Socks and Sandals</h2>'
									+ '</div></a></div>';
							})
							//console.log("update 글 : " + update);
							tableHead += update;
							tableHead += tableTail;
							//$('tableTail').append(tableHead);
							$('#planPost').append(tableHead);
							},
						error : function() {
							alert("searchTeam ERROR");
						}
					});
			}
		});
	})
	
	</script>
<title>Jam Planner</title>
</head>
<body>
    <header role="banner">
      <div class="top-bar">
        <div class="container">
          <div class="row">
            <div class="col-5 social">
              <a href="#"><i class="fab fa-google-drive"></i></a>
              <a href="#"><i class="fab fa-facebook"></i></a>
              <a href="#"><i class="fab fa-instagram"></i></a>
              <a href="#"><i class="fab fa-youtube-play"></i></a>
            </div>
            <div class="col-7 social">
            	<a href="#" style="float:right;"><i class="fas fa-search"></i></a>
            	<a href="#" style="float:right;"><i class="far fa-user-circle"></i></a>
            	<a href="#" id="envelope" style="float:right;"><i class="far fa-envelope-open"></i></a>
            </div>
          </div>
        </div>
      </div>

      <div class="container logo-wrap">
        <div class="row pt-5">
          <div class="col-12 text-center">
            <a class="absolute-toggle d-block d-md-none" data-toggle="collapse" href="#navbarMenu" role="button" aria-expanded="false" aria-controls="navbarMenu"><span class="burger-lines"></span></a>
            <h1 class="site-logo"><a href="index.html">Jam Planner</a></h1>
          </div>
        </div>
      </div>
      
      <nav class="navbar navbar-expand-md  navbar-light bg-light">
        <div class="container">
          
         
          <!-- <div class="collapse navbar-collapse" id="navbarMenu">
            <ul class="navbar-nav mx-auto">
              <li class="nav-item">
                <a class="nav-link active" href="index.html">Home</a>
              </li>
              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="category.html" id="dropdown04" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Travel</a>
                <div class="dropdown-menu" aria-labelledby="dropdown04">
                  <a class="dropdown-item" href="category.html">Asia</a>
                  <a class="dropdown-item" href="category.html">Europe</a>
                  <a class="dropdown-item" href="category.html">Dubai</a>
                  <a class="dropdown-item" href="category.html">Africa</a>
                  <a class="dropdown-item" href="category.html">South America</a>
                </div>

              </li>
              <li class="nav-item">
                <a class="nav-link" href="about.html">About</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="contact.html">Contact</a>
              </li>
            </ul>
            
          </div> -->
        </div>
      </nav>
    </header>
    <!-- END header -->

    <section class="site-section pt-5">
      <div class="container">
        <div class="row">
          <div class="col-md-12">

            <div class="owl-carousel owl-theme home-slider">
              <div>
                <a href="blog-single.html" class="a-block d-flex align-items-center height-lg" style="background-image: url('./resources/myRoom/images/img_1.jpg'); ">
                  <div class="text half-to-full">
                    <div class="post-meta">
                      <span class="category">Lifestyle</span>
                      <span class="mr-2">March 15, 2018 </span> &bullet;
                      <span class="ml-2"><i class="far fa-thumbs-up"></i> 3</span>
                    </div>
                    <h3>There’s a Cool New Way for Men to Wear Socks and Sandals</h3>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quidem nobis, ut dicta eaque ipsa laudantium!</p>
                  </div>
                </a>
              </div>
              <div>
                <a href="blog-single.html" class="a-block d-flex align-items-center height-lg" style="background-image: url('./resources/myRoom/images/img_2.jpg'); ">
                  <div class="text half-to-full">
                    <div class="post-meta">
                      <span class="category">Lifestyle</span>
                      <span class="mr-2">March 15, 2018 </span> &bullet;
                      <span class="ml-2"><span class="fa fa-comments"></span> 3</span>
                    </div>
                    <h3>There’s a Cool New Way for Men to Wear Socks and Sandals</h3>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quidem nobis, ut dicta eaque ipsa laudantium!</p>
                  </div>
                </a>
              </div>
              <div>
                <a href="blog-single.html" class="a-block d-flex align-items-center height-lg" style="background-image: url('./resources/myRoom/images/img_3.jpg'); ">
                  <div class="text half-to-full">
                    <div class="post-meta">
                      <span class="category">Lifestyle</span>
                      <span class="mr-2">March 15, 2018 </span> &bullet;
                      <span class="ml-2"><span class="fa fa-comments"></span> 3</span>
                    </div>
                    <h3>There’s a Cool New Way for Men to Wear Socks and Sandals</h3>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quidem nobis, ut dicta eaque ipsa laudantium!</p>
                  </div>
                </a>
              </div>
            </div>
            
          </div>
        </div>
        <div class="row">
          <div class="col-md-6 col-lg-4">
            <a href="blog-single.html" class="a-block d-flex align-items-center height-md" style="background-image: url('./resources/myRoom/images/img_2.jpg'); ">
              <div class="text">
                <div class="post-meta">
                  <span class="category">Lifestyle</span>
                  <span class="mr-2">March 15, 2018 </span> &bullet;
                  <span class="ml-2"><span class="fa fa-comments"></span> 3</span>
                </div>
                <h3>There’s a Cool New Way for Men to Wear Socks and Sandals</h3>
              </div>
            </a>
          </div>
          <div class="col-md-6 col-lg-4">
            <a href="blog-single.html" class="a-block d-flex align-items-center height-md" style="background-image: url('./resources/myRoom/images/img_3.jpg'); ">
              <div class="text">
                <div class="post-meta">
                  <span class="category">Travel</span>
                  <span class="mr-2">March 15, 2018 </span> &bullet;
                  <span class="ml-2"><span class="fa fa-comments"></span> 3</span>
                </div>
                <h3>There’s a Cool New Way for Men to Wear Socks and Sandals</h3>
              </div>
            </a>
          </div>
          <div class="col-md-6 col-lg-4">
            <a href="blog-single.html" class="a-block d-flex align-items-center height-md" style="background-image: url('./resources/myRoom/images/img_4.jpg'); ">
              <div class="text">
                <div class="post-meta">
                  <span class="category">Food</span>
                  <span class="mr-2">March 15, 2018 </span> &bullet;
                  <span class="ml-2"><span class="fa fa-comments"></span> 3</span>
                </div>
                <h3>There’s a Cool New Way for Men to Wear Socks and Sandals</h3>
              </div>
            </a>
          </div>
        </div>
      </div>


    </section>
    <!-- END section -->
    

    <section class="site-section py-sm">
      <div class="container">
        <div class="row">
          <div class="col-md-6">
            <h2 class="mb-4">Update</h2>
            <div class="search-form-wrap">
              <form class="search-form">
                <div class="form-group">
                  <span class="icon fa fa-search"></span>
                  <input type="text" class="form-control" id="s" name="teamName" placeholder="팀을 검색해보세요.">
                </div>
              </form>
            </div>
          </div>
        </div>
        <div class="row blog-entries">
          <div class="col-md-12 col-lg-8 main-content">
            <div id="planPost" class="row">
              <div class="col-md-6">
                <a href="blog-single.html" class="blog-entry element-animate" data-animate-effect="fadeIn">
                  <img src="./resources/myRoom/images/img_5.jpg" alt="Image placeholder">
                  <div class="blog-content-body">
                    <div class="post-meta">
                      <span class="category">Food</span>
                      <span class="mr-2">March 15, 2018 </span> &bullet;
                      <span class="ml-2"><span class="fa fa-comments"></span> 3</span>
                    </div>
                    <h2>There’s a Cool New Way for Men to Wear Socks and Sandals</h2>
                  </div>
                </a>
              </div>
              <div class="col-md-6">
                <a href="blog-single.html" class="blog-entry element-animate" data-animate-effect="fadeIn">
                  <img src="./resources/myRoom/images/img_6.jpg" alt="Image placeholder">
                  <div class="blog-content-body">
                    <div class="post-meta">
                      <span class="category">Travel</span>
                        <span class="mr-2">March 15, 2018 </span> &bullet;
                        <span class="ml-2"><span class="fa fa-comments"></span> 3</span>
                      </div>
                    <h2>There’s a Cool New Way for Men to Wear Socks and Sandals</h2>
                  </div>
                </a>
              </div>

              <div class="col-md-6">
                <a href="blog-single.html" class="blog-entry element-animate" data-animate-effect="fadeIn">
                  <img src="./resources/myRoom/images/img_7.jpg" alt="Image placeholder">
                  <div class="blog-content-body">
                    <div class="post-meta">
                      <span class="category">Travel, Asia</span>
                      <span class="mr-2">March 15, 2018 </span> &bullet;
                      <span class="ml-2"><span class="fa fa-comments"></span> 3</span>
                    </div>
                    <h2>There’s a Cool New Way for Men to Wear Socks and Sandals</h2>
                  </div>
                </a>
              </div>
              <div class="col-md-6">
                <a href="blog-single.html" class="blog-entry element-animate" data-animate-effect="fadeIn">
                  <img src="./resources/myRoom/images/img_8.jpg" alt="Image placeholder">
                  <div class="blog-content-body">
                    <div class="post-meta">
                      <span class="category">Travel</span>
                      <span class="mr-2">March 15, 2018 </span> &bullet;
                      <span class="ml-2"><span class="fa fa-comments"></span> 3</span>
                    </div>
                    <h2>There’s a Cool New Way for Men to Wear Socks and Sandals</h2>
                  </div>
                </a>
              </div>

              <div class="col-md-6">
                <a href="blog-single.html" class="blog-entry element-animate" data-animate-effect="fadeIn">
                  <img src="./resources/myRoom/images/img_9.jpg" alt="Image placeholder">
                  <div class="blog-content-body">
                    <div class="post-meta">
                      <span class="category">Travel</span>
                      <span class="mr-2">March 15, 2018 </span> &bullet;
                      <span class="ml-2"><span class="fa fa-comments"></span> 3</span>
                    </div>
                    <h2>There’s a Cool New Way for Men to Wear Socks and Sandals</h2>
                  </div>
                </a>
              </div>
              <div class="col-md-6">
                <a href="blog-single.html" class="blog-entry element-animate" data-animate-effect="fadeIn">
                  <img src="./resources/myRoom/images/img_10.jpg" alt="Image placeholder">
                  <div class="blog-content-body">
                    <div class="post-meta">
                      <span class="category">Lifestyle</span>
                      <span class="mr-2">March 15, 2018 </span> &bullet;
                      <span class="ml-2"><span class="fa fa-comments"></span> 3</span>
                    </div>
                    <h2>There’s a Cool New Way for Men to Wear Socks and Sandals</h2>
                  </div>
                </a>
              </div>

              <div class="col-md-6">
                <a href="blog-single.html" class="blog-entry element-animate" data-animate-effect="fadeIn">
                  <img src="./resources/myRoom/images/img_11.jpg" alt="Image placeholder">
                  <div class="blog-content-body">
                    <div class="post-meta">
                      <span class="category">Lifestyle</span>
                      <span class="mr-2">March 15, 2018 </span> &bullet;
                      <span class="ml-2"><span class="fa fa-comments"></span> 3</span>
                    </div>
                    <h2>There’s a Cool New Way for Men to Wear Socks and Sandals</h2>
                  </div>
                </a>
              </div>
              <div class="col-md-6">
                <a href="blog-single.html" class="blog-entry element-animate" data-animate-effect="fadeIn">
                  <img src="./resources/myRoom/images/img_12.jpg" alt="Image placeholder">
                  <div class="blog-content-body">
                    <div class="post-meta">
                      <span class="category">Food</span>
                      <span class="mr-2">March 15, 2018 </span> &bullet;
                      <span class="ml-2"><span class="fa fa-comments"></span> 3</span>
                    </div>
                    <h2>There’s a Cool New Way for Men to Wear Socks and Sandals</h2>
                  </div>
                </a>
              </div>
            </div>

            <div class="row">
              <div class="col-md-12 text-center">
                <nav aria-label="Page navigation" class="text-center">
                  <ul class="pagination">
                    <li class="page-item  active"><a class="page-link" href="#">Prev</a></li>
                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item"><a class="page-link" href="#">Next</a></li>
                  </ul>
                </nav>
              </div>
            </div>


            <div class="row mb-5 mt-5">

              <div class="col-md-12">
                <h2 class="mb-4">More Blog Posts</h2>
              </div>
        
              <div class="col-md-12">

                <div class="post-entry-horzontal">
                  <a href="blog-single.html">
                    <div class="image element-animate"  data-animate-effect="fadeIn" style="background-image: url(./resources/myRoom/images/img_10.jpg);"></div>
                    <span class="text">
                      <div class="post-meta">
                        <span class="category">Travel</span>
                        <span class="mr-2">March 15, 2018 </span> &bullet;
                        <span class="ml-2"><span class="fa fa-comments"></span> 3</span>
                      </div>
                      <h2>There’s a Cool New Way for Men to Wear Socks and Sandals</h2>
                    </span>
                  </a>
                </div>
                <!-- END post -->

                <div class="post-entry-horzontal">
                  <a href="blog-single.html">
                    <div class="image element-animate"  data-animate-effect="fadeIn" style="background-image: url(./resources/myRoom/images/img_11.jpg);"></div>
                    <span class="text">
                      <div class="post-meta">
                        <span class="category">Lifestyle</span>
                        <span class="mr-2">March 15, 2018 </span> &bullet;
                        <span class="ml-2"><span class="fa fa-comments"></span> 3</span>
                      </div>
                      <h2>There’s a Cool New Way for Men to Wear Socks and Sandals</h2>
                    </span>
                  </a>
                </div>
                <!-- END post -->

                <div class="post-entry-horzontal">
                  <a href="blog-single.html">
                    <div class="image element-animate"  data-animate-effect="fadeIn" style="background-image: url(./resources/myRoom/images/img_12.jpg);"></div>
                    <span class="text">
                      <div class="post-meta">
                        <span class="category">Food</span>
                        <span class="mr-2">March 15, 2018 </span> &bullet;
                        <span class="ml-2"><span class="fa fa-comments"></span> 3</span>
                      </div>
                      <h2>There’s a Cool New Way for Men to Wear Socks and Sandals</h2>
                    </span>
                  </a>
                </div>
                <!-- END post -->

              </div>
            </div>

            

          </div>

          <!-- END main-content -->
          <div class="col-md-12 col-lg-4 sidebar">
            
            <!-- END sidebar-box -->
            <div class="sidebar-box">
              <div class="bio text-center">
                <img src="<spring:url value='/image/${userVO.image }'/>" width="200" height="200" alt="Image Placeholder" class="img-fluid">
                <div class="bio-body">
                  <h2>'${userVO.id }'</h2>
                  <p>Team List</p>
                  <div id="teamList">
                  </div>
                  <p><a href="#" class="btn btn-primary btn-sm" data-toggle="modal"
							data-target="#fullHeightModal">+Team</a>
					 <div class="modal fade myModal" id="fullHeightModal" tabindex="-1"
							role="document" aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-full-height" role="dialog">
								<div class="modal-content">
									<div class="modal-header modal-header-color">
										<h4 class="modal-title w-100" id="myModalLabel">
											팀을 만들어보세요</strong></h4>
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
									</div>
									<div class="modal-body">
										<form id="makeTeamForm" name="makeTeamForm" method="get">
											<input type="hidden" name="id" id="id" value="<%=id%>">
											<div class="alert alert-info">
												<input name="teamName" id="teamName"
													placeholder="팀이름을 정해보세요" type="text">
												<button id="validationCheck" type="button"
													class="btn btn-xs btn-secondary">중복 확인</button>
											</div>
											<div class="row modal-footer justify-content-center">
												<button type="button" id="inputForm" class="btn btn-primary">추가</button>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
                 	 <a href="#" class="btn btn-primary btn-sm" data-toggle="modal"
							data-target=".addPlan">+Plan</a></p>
                </div>
              </div>
            </div>
            <!-- END sidebar-box -->  
            <div class="sidebar-box">
              <h3 class="heading">Categories</h3>
              <ul class="categories">
                <li><a href="#">Courses <span>(12)</span></a></li>
                <li><a href="#">News <span>(22)</span></a></li>
                <li><a href="#">Design <span>(37)</span></a></li>
                <li><a href="#">HTML <span>(42)</span></a></li>
                <li><a href="#">Web Development <span>(14)</span></a></li>
              </ul>
            </div>
            <!-- END sidebar-box -->

            <div class="sidebar-box">
              <h3 class="heading">Tags</h3>
              <ul class="tags">
                <li><a href="#">Travel</a></li>
                <li><a href="#">Adventure</a></li>
                <li><a href="#">Food</a></li>
                <li><a href="#">Lifestyle</a></li>
                <li><a href="#">Business</a></li>
                <li><a href="#">Freelancing</a></li>
                <li><a href="#">Travel</a></li>
                <li><a href="#">Adventure</a></li>
                <li><a href="#">Food</a></li>
                <li><a href="#">Lifestyle</a></li>
                <li><a href="#">Business</a></li>
                <li><a href="#">Freelancing</a></li>
              </ul>
            </div>
          </div>
          <!-- END sidebar -->
        </div>
      </div>
    </section>
  
    <footer class="site-footer">
      <div class="container">
        <div class="row mb-5">
          <div class="col-md-4">
            <h3>Paragraph</h3>
            <p>
              <img src="./resources/myRoom/images/img_1.jpg" alt="Image placeholder" class="img-fluid">
            </p>

            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nisi, accusantium optio unde perferendis eum illum voluptatibus dolore tempora, consequatur minus asperiores temporibus reprehenderit.</p>
          </div>
          <div class="col-md-6 ml-auto">
            <div class="row">
              <div class="col-md-7">
                <h3>Latest Post</h3>
                <div class="post-entry-sidebar">
                  <ul>
                    <li>
                      <a href="">
                        <img src="./resources/myRoom/images/img_6.jpg" alt="Image placeholder" class="mr-4">
                        <div class="text">
                          <h4>There’s a Cool New Way for Men to Wear Socks and Sandals</h4>
                          <div class="post-meta">
                            <span class="mr-2">March 15, 2018 </span> &bullet;
                            <span class="ml-2"><span class="fa fa-comments"></span> 3</span>
                          </div>
                        </div>
                      </a>
                    </li>
                    <li>
                      <a href="">
                        <img src="./resources/myRoom/images/img_3.jpg" alt="Image placeholder" class="mr-4">
                        <div class="text">
                          <h4>There’s a Cool New Way for Men to Wear Socks and Sandals</h4>
                          <div class="post-meta">
                            <span class="mr-2">March 15, 2018 </span> &bullet;
                            <span class="ml-2"><span class="fa fa-comments"></span> 3</span>
                          </div>
                        </div>
                      </a>
                    </li>
                    <li>
                      <a href="">
                        <img src="./resources/myRoom/images/img_4.jpg" alt="Image placeholder" class="mr-4">
                        <div class="text">
                          <h4>There’s a Cool New Way for Men to Wear Socks and Sandals</h4>
                          <div class="post-meta">
                            <span class="mr-2">March 15, 2018 </span> &bullet;
                            <span class="ml-2"><span class="fa fa-comments"></span> 3</span>
                          </div>
                        </div>
                      </a>
                    </li>
                  </ul>
                </div>
              </div>
              <div class="col-md-1"></div>
              
              <div class="col-md-4">

                <div class="mb-5">
                  <h3>Quick Links</h3>
                  <ul class="list-unstyled">
                    <li><a href="#">About Us</a></li>
                    <li><a href="#">Travel</a></li>
                    <li><a href="#">Adventure</a></li>
                    <li><a href="#">Courses</a></li>
                    <li><a href="#">Categories</a></li>
                  </ul>
                </div>
                
                <div class="mb-5">
                  <h3>Social</h3>
                  <ul class="list-unstyled footer-social">
                    <li><a href="#"><span class="fa fa-twitter"></span> Twitter</a></li>
                    <li><a href="#"><span class="fa fa-facebook"></span> Facebook</a></li>
                    <li><a href="#"><span class="fa fa-instagram"></span> Instagram</a></li>
                    <li><a href="#"><span class="fa fa-vimeo"></span> Vimeo</a></li>
                    <li><a href="#"><span class="fa fa-youtube-play"></span> Youtube</a></li>
                    <li><a href="#"><span class="fa fa-snapchat"></span> Snapshot</a></li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
          </div>
        </div>
      </div>
    </footer>
    <!-- END footer -->
    
    <!-- loader -->
    <div id="loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#f4b214"/></svg></div>

	<script src="./resources/myRoom/js/jquery-3.2.1.min.js"></script>
    <script src="./resources/myRoom/js/jquery-migrate-3.0.0.js"></script>
    <script src="./resources/myRoom/js/popper.min.js"></script>
	<script src="./resources/myRoom/js/bootstrap.min.js"></script>
    <script src="./resources/myRoom/js/owl.carousel.min.js"></script>
    <script src="./resources/myRoom/js/jquery.waypoints.min.js"></script>
    <script src="./resources/myRoom/js/jquery.stellar.min.js"></script>

    
    <script src="./resources/myRoom/js/main.js"></script>
  </body>
</html>