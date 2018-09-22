<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="com.spring.jamplan.model.TeamInfoVO" %>
<%@ page import="com.spring.jamplan.model.UserVO" %>


<%  
    session.setAttribute("id", "thkim9198");   
	session.setAttribute("teamNo", "3");
	UserVO user = (UserVO)request.getAttribute("user");
 %>
<!DOCTYPE html>
<html>
	<head>
		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"crossorigin="anonymous"></script>
		<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		
		
		<spring:url value="/resources/myInfo/js/myInfoJs.js" var="myInfoJs" />
		<spring:url value="/resources/myInfo/css/myInfoCss.css" var="myInfoCss" />
	
		<script src="${myInfoJs }"></script>
		<link href="${myInfoCss}" rel="stylesheet" />
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="X-UA-Compatible" content="ie=edge">
		
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/drawer/3.2.2/css/drawer.min.css">
		<!-- jquery & iScroll -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/iScroll/5.2.0/iscroll.min.js"></script>
		<!-- drawer.js -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/drawer/3.2.2/js/drawer.min.js"></script>
		
		<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
		
		<style>
		/*구글 한글폰트 불러오는 곳*/
		@import url(//fonts.googleapis.com/earlyaccess/jejumyeongjo.css);
    
		* {
			font-family: 'Jeju Myeongjo', serif;
			font-weight: 600;
		}
		/*구글 한글폰트 불러오는 부분 끝*/
		</style>
		<script>
			
		</script>
		
		<title>Jam Planner</title>
	</head>
	<body>
		<header>
	    	<!-- top bar 들어가는 부분 -->
			<div class="topnav">
			  <!-- Centered link -->
			  <div class="topnav-centered">
			    <h2><strong><a href="#home" class="active">Jam Planner</a></strong></h2>
			  </div>
			  <!-- Right-aligned links -->
			  <div class="topnav-right">
			    <a href="#search">Message</a>
			    <a href="#myInfo">My Info</a>
			    <a href="#about">Search</a>
			  </div>
			</div>
		</header>
		<section class="container-fluid">
			<div id="main-container" class="row content">
				<div class="col-sm-2 sidenav">
					<h1>사이드바</h1>
					<ul class="nav nav-pills flex-column">
				        <li class="nav-item active"><a class="nav-link" href="#section1">Main</a></li>
				        <li class="nav-item"><a class="nav-link" href="#section2">My Room</a></li>
				        <li class="nav-item"><a class="nav-link" href="#section3">Search</a></li>
				        <li class="nav-item"><a class="nav-link" href="#section3">Photos</a></li>
				    </ul><br>
				    <div class="input-group">
				      	<input type="text" class="form-control" placeholder="Search Blog..">
				        <span class="input-group-btn">
				       		<button class="btn btn-primary" type="button">
				        		<i class="fas fa-search"></i>
				        	</button>
				        </span>
				    </div>
				</div>
				<div class="col-sm-10">
					</br></br>
					<ul class="nav nav-tabs" id="myTab" role="tablist">
							
						<li class="nav-item">
							<a class="nav-link active" id="teamManage-tab" data-toggle="tab" href="#teamManage" role="tab" aria-controls="profile" aria-selected="false">
								팀 관리</a></li>	
						<li class="nav-item">
                        	<a class="nav-link" id="info-tab" data-toggle="tab" href="#info" role="tab" aria-controls="home" aria-selected="true">
                                          내 정보</a></li>
						<div class="search-container">
							<form action="/">
								<input type="text" placeholder="Search ..." name="search">
							    <button type="submit">검색</button>
							</form>
						</div>
					</ul>
					<div class="tab-content" id="myTabContent">
						<div class="tab-pane fade show active" value="teamManage.mp" id="teamManage" role="tabpanel" aria-labelledby="teamManage-tab">
						  <div style="display:block;width:100%;">
						      <table id="leaderTable" class="table table-borderless table-hover">
                                  <thead>
                                    <tr>
                                      <th scope="col">팀명</th>
                                      <th scope="col">팀 지우기</th>
                                    </tr>
                                  </thead>
                                  <tbody>
                                  <c:forEach items="${teamListAsLeader }" var="team" varStatus="status">
                                    <tr>
                                	  <td><c:out value="${team.teamName }" escapeXml="false"/></td>
                                      <td><button id="<c:out value="${status.index}"/>" class="btn btn-outline-danger btn-rounded" type="submit">지우기</button></td>
                                    </tr>
                                  </c:forEach>
                                  </tbody>
                              </table>						      
						      <table id="memberTable" class="table table-borderless table-hover">
                                  <thead>
                                    <tr>                                    
                                      <th scope="col">팀명</th>
                                      <th scope="col">팀 나가기</th>
                                    </tr>
                                  </thead>
                                  <tbody>
                                  <c:forEach items="${teamListAsMember }" var="team" varStatus="status">
                                    <tr>                                    
                                      <td><c:out value="${team.teamName }" escapeXml="false"/></td>
                                      <td><button id="<c:out value="${status.index}"/>" class="btn btn-outline-danger btn-rounded" type="submit">나가기</button></td>
                                    </tr>
                                  </c:forEach>
                                  </tbody>
                              </table>                              
						  </div>
						</div>
						<div class="tab-pane fade" value="info.mp" id="info" role="tabpanel" aria-labelledby="info-tab">
                            <div style="display:flex;width:100%;">
                                <form id="imageForm" action="imageUpload.info" method="post" enctype="multipart/form-data">
                                    <div><img id="imagePreview" src="<spring:url value='/image/${user.image }'/>" width="200" height="200"></div>
                                    <label id="imageSearch">사진 찾기<input id="image" type="file" name="file" accept="image/*"></label>                              
                                    <button id="imageUpload" class="btn btn-primary btn-rounded" type="submit">프로필 사진 등록</button>
                                </form>
                                <form autocomplete="off" id="infoForm" name="updateInfo" action="updateMyInfo.info" method="post">
                                    <div style="width: 80%;margin-right:10%">
                                        <p>아이디</p>
                                        <input name="id" value="${id }" readonly autofocus>
                                    </div>
                                    <div style="width: 80%;margin-right:10%">
                                        <p>이메일</p>
                                        <input type="text" id="email" name="email" value="${user.email }">
                                    </div>
                                    <div style="width:30%;margin-right:17%">
                                        <p>비밀번호 확인</p>
                                        <input id="password" name="pass" type="password" value="${user.pass }">
                                    </div>                      
                                    <div style="width:37%;margin-right:6%">
                                        <p>비밀번호</p>
                                        <input id="prePassword" type="password" value="${user.pass }">
                                    </div>                                    
                                    <div style="width:37%;margin-right:10%">
                                        <p>가입일</p>
                                        <input type="text" readonly name="signDate" value="${user.signDate }">
                                    </div>
                                    <div class="autocomplete" style="width:37%;margin-right:6%">
                                        <p>국적</p>
                                        <input id="myNation" type="text" name="nation" value="${user.nation }">
                                    </div>
                                    <div style="width:37%;margin-right:10%;margin-bottom:5%">
                                      <p>성별</p>
                                      	  <div class="custom-control custom-radio">
	                                          <input type="radio" class="custom-control-input" id="female" name="gender" value="f" checked>
	                                          <label class="custom-control-label" for="female">여자</label>                                      
	                                      </div>
	                                      <div class="custom-control custom-radio">
	                                          <input type="radio" class="custom-control-input" id="male" name="gender" value="m">
	                                          <label class="custom-control-label" for="male">남자</label>
	                                      </div>
	                                </div>
                                    <div style="width:37%;margin-right:6%">
                                        <p>나이</p>
                                        <input type="text" id="age" name="age" value="${user.age }">
                                    </div>
                                    <div style="width:37%;margin-right:6%">
                                        <p>여행 타입</p>
                                        <div class="sel sel--black-panther">
										  <select name="travelType" id="select-profession">
										    <option value="나홀로">나홀로</option>
										    <option value="friend">친구들과 함께</option>
										    <option value="가족과 함께">가족과 함께</option>
										    <option value="동행 구하기">동행 구하기</option>
										    <option value="연인과 함께">연인과 함께</option>
										  </select>
										</div>
                                    </div>
                                    </br></br>
                                    <div style="width:37%;margin-right:25%">
                                    	<button class="btn success" type="submit">정보 수정</button>
                                    </div>
                                </form> 
                            </div>
                        </div>
					</div>
				</div>
			</div>
		</section>
		<footer class="container-fluid">
  			<p>Footer Text</p>
		</footer>
	</body>
</html>

<!-- 
<ul class="nav nav-tabs">
							<li><a href="#calendar" data-toggle="tab" class="nav-link active">
									Calendar</a></li>
							<li><a href="#map" data-toggle="tab" class="nav-link">
									Map</a></li>
							<li><a href="#planTable" data-toggle="tab" class="nav-link">
									PlanTable</a></li>
							<li><a href="viewAll" data-toggle="tab" class="nav-link">
									View all</a></li>
						</ul>
						<div class="tab-content">
							<div class="tab-pane container active" value = "calendarajax.mp" id="calendar"></div>
							<div class="tab-pane container fade" value = "mapajax.mp" id="map"></div>
							<div class="tab-pane container fade" value = "plantableajax.mp" id="planTable"></div>
							<div class="tab-pane container fade" value = "viewallajax.mp" id="viewAll"></div>
						</div>
 -->