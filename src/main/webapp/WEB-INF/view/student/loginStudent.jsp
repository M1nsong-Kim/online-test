<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>온라인 시험 | 학생 로그인</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		let allCheck = false;
		
		let studentId = $('#studentId');
		let studentPw = $('#studentPw');
		
		$('#btn').click(function(){
			if(studentId.val().length < 1 || studentId.val().trim() == ''){
				alert('아이디를 입력해 주세요');
			}else if(studentPw.val().length < 1 || studentPw.val().trim() == ''){
				alert('비밀번호를 입력해 주세요');
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
  	<!-- 로그인 전 -->
	<c:if test="${loginStudent == null}">
		<h1>login Student</h1>
		<form method="post" action="${pageContext.request.contextPath}/loginStudent" id="form">
			<table>
				<tr>
					<td>아이디</td>
					<td>
						<input type="text" name="studentId" id="studentId">
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td>
						<input type="password" name="studentPw" id="studentPw">
					</td>
				</tr>
			</table>
			<button type="button" id="btn">로그인</button>
		</form>
	</c:if>

	<!-- 로그인 후 -->
	<c:if test="${loginStudent != null}">
		<div>
			<c:import url="/WEB-INF/view/student/inc/studentMenu.jsp"></c:import>
		</div>
		${loginStudent.studentName}님 반갑습니다
	</c:if>
</body>
</html>