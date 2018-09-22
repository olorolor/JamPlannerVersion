<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<spring:url value="/resources/viewAll/js/viewAll.js" var="calJs" />
<%--<spring:url value="/resources/viewAll/css/viewAll.css" var="calCss" /> --%>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"crossorigin="anonymous"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	
<script src="${calJs}"></script>
<%-- <link href="${calCss}" rel="stylesheet" />  --%>
<script type="text/javascript">
</script>
</head>

<body>
	

	<!-- <div id="saveput">testtest</div>
	palnTable 뿌려주기   
	<br><br>-->
	<div class="container">
   	 <button class="btn pull-right btn-primary" type="button" data-toggle="modal" data-target="#myModal">일정공개</button>
	</div>
	
	<div id="myModal" class="modal">
    <!--모달의 크기 결정-->
    <!-- modal-sm, modal-lg, 아무것도명시하지않으면 중간사이즈로 지정된다. -->
    <div class="modal-dialog">

        <!--모달의 들어갈 본 컨텐츠-->
        <div class="modal-content">
            <div class="modal-header">
                <h4>일정전체공개</h4>
                <button class="close" type="button" data-dismiss="modal">&times;</button> <!--data-dismiss="modal":창닫을수있는기능-->
            </div>
            <div class="modal-body">
                <form action="fileUpload.view" method="post" enctype="multipart/form-data">
					<input class="btn btn-outline-secondary" type="file" name="file" /><br/>
                <div class="alert alert-info">
					<input class="btn btn-outline-secondary" name="planName" placeholder="일정이름을 정해보세요" type="text">
				</div>
				  <div class="modal-footer"> <!-- row 태그는 container태그가아닌 이곳 modal-footer에서는 적용안된다.--></div>
                <div class="col-md-12">
					<input class="btn btn-outline-danger" type="submit" value="저장" />
                    
                </div>
				</form>
            </div>
          
                <!-- <div class="col-md-6">
                    <button class="btn btn-danger btn-block">취소</button>
                </div> -->
            </div>
        </div>
    </div>
	</div>
	
	<div class="container" id="viewput"></div> 
	
</body>
</html>