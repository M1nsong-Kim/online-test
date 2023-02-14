<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>온라인 시험 | 강사 로그인</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		let allCheck = false;
		
		let teacherId = $('#teacherId');
		let teacherPw = $('#teacherPw');
		
		$('#btn').click(function(){
			if(teacherId.val().length < 1 || teacherId.val().trim() == ''){
				alert('아이디를 입력해 주세요');
			}else if(teacherPw.val().length < 1 || teacherPw.val().trim() == ''){
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
	<c:if test="${loginTeacher == null}">
		<h1>login Teacher</h1>
		<form method="post" action="${pageContext.request.contextPath}/loginTeacher" id="form">
			<table>
				<tr>
					<td>아이디</td>
					<td>
						<input type="text" name="teacherId" id="teacherId">
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td>
						<input type="password" name="teacherPw" id="teacherPw">
					</td>
				</tr>
			</table>
			<button type="button" id="btn">로그인</button>
		</form>
	</c:if>

	<!-- 로그인 후 -->
	<c:if test="${loginTeacher != null}">
		<div>
			<c:import url="/WEB-INF/view/teacher/inc/teacherMenu.jsp"></c:import>
		</div>
		${loginTeacher.teacherName}님 반갑습니다
	</c:if>
</body>
</html>