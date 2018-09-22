<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="fileUpload.search" method="post" enctype="multipart/form-data">
		파일 : <input type="file" name="file" /><br/>
		<input type="submit" value="서버전달" />
	</form>
	
<!-- <script>
	function fnAction(url) {
		var frm = document.getElementById("multiform");
		frm.action = url;
		frm.submit;
	}
</script> -->
</body>
</html>