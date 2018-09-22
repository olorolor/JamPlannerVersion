<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
	<%
		if(session.getAttribute("checkID") == null) {
			response.sendRedirect("./mainPage.jsp");
		};
	%>
	
	<%-- <% 
	String userId = (String)request.getParameter("id");
	System.out.println("id:" + userId);
	%> --%>
<html>
<head>
<title>Insert title here</title>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">

<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">

function likeFunc() {
	/* 유저가 하트를 체크했는지 안했는지 체크해주는 코드 써주기 : if~ */
	
	
	
	$.ajax({
		url : '/jamplan2/heartCheck.search',
		type : 'POST',
		dataType : "json",
		contentType : 'application/x-www-form-urlencoded; charset=utf-8',
		success:function(data){
			if(data.likeNo == 0){
				'<i class="far fa-heart" tyle= "color : #E75450;" ></i>';
			}
			else{
				'<i class="fas fa-heart " style= "color : #E75450;"  ></i>';
			}	
					
					
				consloe.log("output:" + output);
				$('output').append(output);
		},
		error:function(){
			alert("ajax통신 실패!!!");
		}
	});
	
}



</script>

</head>
<body>
	<!-- <style>
		#text1 { color : #E75450; }
	</style> -->
	<style>
	button {
		opacity: 0;
		
		}
	</style>
	
	<h3>스케쥴테스트</h3>
	<div>
		<h1><a href="javascript:likeFunc();"><i class="far fa-heart" id="noneHeart" style= "color : #E75450;" ></i></a></h1>
		<h1><i class="fas fa-heart " id="fullHeart" style= "color : #E75450;"  ></i></h1>
	</div>
	
	<div>
		
	</div>
	
	
	
	
</body>
</html>