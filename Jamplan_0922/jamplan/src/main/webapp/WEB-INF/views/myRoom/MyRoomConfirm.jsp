<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="com.spring.jamplan.model.TeamInfoVO"%>
<%@page import="com.spring.jamplan.model.PlanVO"%>
<%-- <%@page import="com.spring.jamplan.myroom.CalendarVO"%> --%>

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

<spring:url value="/resources/myRoom/js/myRoom.js" var="roomJs" />
<spring:url value="/resources/myRoom/css/myRoom.css" var="roomCss" />


<script src="https://code.jquery.com/jquery-3.3.1.js"
	  integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
		  crossorigin="anonymous"></script>
<script src="${roomJs}"></script>
<link href="${roomCss}" rel="stylesheet" />


<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<!-- 웹페이지에 대한 설명 -->
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
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto:regular,bold,italic,thin,light,bolditalic,black,medium&amp;lang=en">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
	integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ"
	crossorigin="anonymous">

<title>Walnut Planner</title>
</head>
<body>
	<header>
		<nav class="navbar fixed-top navbar-expand-sm navbar-dark">
			<a href="#" class="navbar-brand"> Walnut Planner </a>
			<button class="navbar-toggler" data-toggle="collapse"
				data-target="#collapsibleNavbar">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse justify-content-end"
				id="collapsibleNavbar">
				<ul class="nav navbar-nav">
					<li class="nav-item active">
						<!-- <button type="button" class="btn btn-primary" id = "messageBut">Message</button> -->
						<!--모달 버튼  -->
						<button type="button" class="btn btn-primary btn-rounded" id ="messageBut"  data-toggle="modal" data-target="#messageModal">Message <span id="countLabel" class="label label-primary"></span></button>
					</li>
					<li class="nav-item active"><a><i class="material-icons nav-link">account_circle</i></a></li>
					<li class="nav-item active"><a><i class="material-icons nav-link">search</i></a></li>
				</ul>
			</div>
		</nav>
		<!--------------------------- 외부에서 가져온 모달 예제 -->
						<div class="modal fade myModal" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-full-height" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<h4 class="modal-title w-100" id="myModalLabel">메세지</strong></h4>
										<button type="button" class="close" data-dismiss="modal"aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
									</div>
									<div id = "messageContent" class="modal-body">
									</div>
								</div>
							</div>
						</div>
		<!---------------------------외부에서 가져온 모달 예제 끝 -->
	</header>
	<section>
	
	
		<div id="main-container" class="container-fluid text-center">
			<div class="row">
				<div id="teamListSpace" class="col-md-3">
					<h4><strong>팀 리스트</strong></h4>
					
					<div id="teamList"></div>
					<div>
					</br>
						<!-- teamList 자리 -->
						<button type="button"
							class="btn btn-outline-primary btn-sm btn-rounded" data-toggle="modal"
							data-target="#fullHeightModal"><strong>+TEAM</strong></button>
						<!-- 외부에서 가져온 모달 예제 -->
						<div class="modal fade myModal" id="fullHeightModal" tabindex="-1"
							role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-full-height" role="document">
								<div class="modal-content">
									<div class="modal-header">
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
						<!-- 외부에서 가져온 모달 예제 끝 -->
						
						<!-- 일정 만들기위한 모달 -->
						<button id="addPlan" type="button"
							class="btn btn-outline-primary btn-sm btn-rounded" data-toggle="modal"
							data-target=".addPlan"><strong>+PLAN</strong></button>
						<div class="modal fade addPlan" id="fullHeightModal" tabindex="-1"
							role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-full-height" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<h4 class="modal-title w-100" id="myModalLabel">일정을 추가해보세요</h4>
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
									</div>
									<div id="addPlanTable" class="modal-body">
										<div id="planSpace"></div>
										<form id="makePlanForm" name="makePlanForm" method="get">
											<input type="hidden" name="id" id="id" value="<%=id%>">
											<input type="hidden" name="teamName" id="teamNameByTable" value=''>
											<div class="alert alert-info">
												<input name="planName" id="planName"
													placeholder="일정 이름을 정해보세요" type="text">
											</div>
											<div class="row modal-footer justify-content-center">
												<button type="button" id="planAddModal" class="btn btn-primary">추가</button>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
						<!-- 일정 만들기위한 모달 종료-->
					</div>
				</div>
				<div class="col-md-6">
					<div id="teamSearch">
						<div class="span12">
							<form name="searchForm" id="custom-search-form" class="form-search form-horizontal pull-right">
								<div class="input-append span12 row">
									<input type="text" id="searchTeamName" name="teamName" class="search-query" placeholder="어떤 팀을 찾으세요?">
									<div id="searchButtonParent">
									<button id="searchButton" type="button" class="btn">
										<i class="fas fa-search"></i>
									</button>
									</div>
								</div>
							</form>
						</div>
					</div>
					<div id="updateSpace">
						<div class="media p-3" id = "teamListSearch">
							<img
								src="http://alumnes.org/wp-content/uploads/2017/06/fa-user-circle-o-c0a2bd7a.png"
								alt="John Doe" class="mr-3 mt-3 rounded-circle"
								style="width: 60px;">
							<div class="media-body">
								<h4>planName</h4>
								<p>일정에 변화가 있어요. 확인해 보세요.</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<aside class="col-md-3">
		
	</aside>
	<!-- Footer -->
	<footer class="text-center">
		<hr class="featurette-divider">
		<a class="up-arrow" href="#myPage" data-toggle="tooltip"
			title="TO TOP">
			<div>
				<ul>
					<li><a href="#">About developers</a></li>
					<li><a href="#">About Walnut</a></li>
					<li><a href="#">About here</a></li>
				</ul>
			</div>
		</a> <br>
		<br>
		<p></p>
	</footer>
</body>
</html>