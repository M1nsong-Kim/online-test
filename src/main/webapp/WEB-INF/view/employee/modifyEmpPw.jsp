<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>온라인 시험 | 직원 비밀번호 변경</title>
<meta content="" name="description">
<meta content="" name="keywords">
	<!-- Google Fonts -->
	<link href="https://fonts.gstatic.com" rel="preconnect">
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
	<!-- Vendor CSS Files -->
	<link href="${pageContext.request.contextPath}/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/assets/vendor/quill/quill.snow.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/assets/vendor/quill/quill.bubble.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/assets/vendor/remixicon/remixicon.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/assets/vendor/simple-datatables/style.css" rel="stylesheet">
	
	<!-- Template Main CSS File -->
	<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		let allCheck = false;
		
		let oldPw = $('#oldPw');
		let newPw = $('#newPw');
		let newPwCk = $('#newPwCk');
		
		$('#btn').click(function(){
			if(oldPw.val().length < 1 || oldPw.val().trim() == ''){
				alert('현재 비밀번호를 입력해 주세요');
			}else if(newPw.val().length < 1 || newPw.val().trim() == ''){
				alert('새 비밀번호를 올바르게 입력해 주세요');
			}else if(newPw.val() != newPwCk.val()){
				alert('비밀번호가 일치하지 않습니다');
			}else {
				allCheck = true;
			}
			if(allCheck){
				$('#form').submit();
			}
		});
	});
</script>
</head>
<body>
	<!-- header -->
	<div>
		<c:import url="/WEB-INF/view/inc/empHeader.jsp"></c:import>
	</div>

 	<h1>${loginEmp.empName} 님 비밀번호 수정</h1>
 	<form method="post" action="${pageContext.request.contextPath}/employee/modifyEmpPw" id="form">
 		<table>
 			<tr>
 				<td>현재 비밀번호</td>
 				<td><input type="password" name="oldPw" id="oldPw"></td>
 			</tr>
 			<tr>
 				<td>새 비밀번호</td>
 				<td><input type="password" name="newPw" id="newPw"></td>
 			</tr>
 			<tr>
 				<td>새 비밀번호 확인</td>
 				<td><input type="password" name="newPwCk" id="newPwCk"></td>
 			</tr>
 		</table>
 		<button type="button" id="btn">수정</button>
 	</form>
</body>
</html>