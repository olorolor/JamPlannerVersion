<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>



<!DOCTYPE html>
<html>
<head>
<title>된다!!!</title>

	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	
	<spring:url value="/resources/search/js/search.js" var="calJs" />
	<spring:url value="/resources/search/css/search.css" var="calCss" />

	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"crossorigin="anonymous"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	
	<!-- 부트스트랩4 -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<!-- fontAwsome -->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
	
	
	<!-- css연결 -->
	<spring:url value="/resources/search/css/searchCss.css" var="searchCss" />
	<link href="${searchCss }" rel="stylesheet" />
	

	<script src="${calJs}"></script>
	<link href="${calCss}" rel="stylesheet" /> 
</head>






<body>

	<!-- nav -->
	<header>
		<div class="topnav fixed-top">
			<div class="topnav-centered">
			 <h2><strong><a href="#main" class="active">Jam Planner</a></strong></h2>
			</div>
			<div class="topnav-left">
				<a href="#planSearch">일정찾기</a>
				<a href="#companySearch">동행찾기</a>
			</div>
			<div class="topnav-right">
				<a href="#myroom">My Room</a>
				<a href="">My Team</a>
			</div>
		</div>
	</header>

	<!-- carousel -->
	<div id="myCarousel" class="carousel slide" data-ride="carousel">
    <ul class="carousel-indicators"> <!--indicators : 클릭했을때이동-->
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>  <!--data-slide-to="0" : 0번째 배열의 페이지로 이동하겠다는 의미, active : 먼저보여줄페이지의미-->
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
    </ul>

    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="/jamplan/resources/search/image/5.jpg" alt="" style="width:100%; height:500px;"> 
            <div class="carousel-caption"> <!--caption기능-->
                <h3>일정찾기!</h3>
                <p>다른사람들의 일정을 확인해보세요!!</p>
        </div>
        </div>
        <div class="carousel-item ">
            <img src="/jamplan/resources/search/image/swiss10.jpg" alt="" style="width:100%; height:500px;">
            <div class="carousel-caption"> <!--caption기능-->
                <h3>동행찾기!</h3>
                <p>사람들의 취향과 여행날짜를 확인하고 동행신청을 해보세요!!</p>
        </div>
        </div>
        <div class="carousel-item ">
            <img src="/jamplan/resources/search/image/swiss7.jpg" alt="" style="width:100%; height:500px;">
            <div class="carousel-caption"> <!--caption기능-->
                <h3>마터호른!</h3>
                <p>꿈꾸는듯한 풍경!!</p>
        </div>
        </div>
    </div>

    <a href="#myCarousel" class="carousel-control-prev" data-slide="prev">
        <span class="carousel-control-prev-icon"></span>
    </a>
    <a href="#myCarousel" class="carousel-control-next" data-slide="next">
        <span class="carousel-control-next-icon"></span></a>
	</div>

	<br><br>
	

	<!-- 검색 -->
		<div class="container-fluid justify-content-center">
		  <div class="row">
			<div class="col-md-4 moveSearch">
			
			
			
			    <div class="input-group"> 
			        <input type="text" class="form-control" placeholder="원하시는 일정을 검색해보세요!" />
			        <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">선택</button>
						<div class="dropdown-menu">
						    <a class="dropdown-item li1" href="#">제목</a>
							<a class="dropdown-item li1" href="#">날짜</a>
				 		</div>
					
			        <div class="input-group-append">
			            <button class="btn btn-warning tag">
			                    <i class="fas fa-search"></i>검색
			            </button>
			        </div>
			    </div>
			
	
				<!-- <div class="input-group">
					<input type="text" class="form-control" placeholder="원하시는 일정을 검색해보세요!" /> 
						 
						<div class="btn-group">
						    <div class="btn-group">
						      <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">
						     	 선택
						      </button>
						      <div class="dropdown-menu">
						        <a class="dropdown-item li1" href="#">제목</a>
						        <a class="dropdown-item li1" href="#">날짜</a>
						      </div>
						      <button class="btn btn-warning tag" type="button">
								<span><i class="fas fa-search"></i></span>
							  </button>
						    </div>
						  </div>


						
						요건 날짜달력가져올때쓰임
						<div class="input-group date"  id="dateCheck" style=" display : none;" >
							<input type="text" class="form-control">
							<span class="input-group-addon"><input type="date"></span>
						</div>



					
				</div> -->
			</div>
		</div>
	</div>

	<br>
	<br>
	
	<!-- 순서나열 -->
	<div class="col-sm-5">
		<div class="btn-group">
		  
			<button type="button" class="btn btn-outline-primary btn-lg clk" id="newDateClick">최신순</button>
			<button type="button" class="btn btn-outline-success btn-lg clk" id="readCountClick">조회순</button>
			<button type="button" class="btn btn-outline-warning btn-lg clk" id="goodCountClick">추천순</button>
			<button type="button" class="btn btn-outline-danger btn-lg clk" id="dateClick">제목</button>
		</div>
	</div>
	<!--  -->
	<br><br>
	<div class="container-fluid text-center conPadding">
	<div class="row" id="output"></div>
	</div>


	<!-- Footer -->
	
	<footer class="text-center">
		<div class="col-md-12">
		<a class="up-arrow" href="#myPage" data-toggle="tooltip" title="TOP"> <span class="glyphicon glyphicon-chevron-up"></span>
		</a><br> <br>
		<p>
			JAM Theme Made By <a href="https://www.jamplan.com" data-toggle="tooltip" title="Visit w3schools">www.jamplan.com</a>
		</p>
		</div>
	</footer> 
	

</body>
</html>