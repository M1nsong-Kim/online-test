<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>온라인 시험 | 직원 로그인</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		let allCheck = false;
		
		let empId = $('#empId');
		let empPw = $('#empPw');
		
		$('#btn').click(function(){
			if(empId.val().length < 1 || empId.val().trim() == ''){
				alert('아이디를 입력해 주세요');
			}else if(empPw.val().length < 1 || empPw.val().trim() == ''){
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
	<c:if test="${loginEmp == null}">
		<h1>login Employee</h1>
		<form method="post" action="${pageContext.request.contextPath}/loginEmp" id="form">
			<table>
				<tr>
					<td>아이디</td>
					<td>
						<input type="text" name="empId" id="empId">
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td>
						<input type="password" name="empPw" id="empPw">
					</td>
				</tr>
			</table>
			<button type="button" id="btn">로그인</button>
		</form>
	</c:if>

	<!-- 로그인 후 -->
	<c:if test="${loginEmp != null}">
		<div>
			<c:import url="/WEB-INF/view/employee/inc/empMenu.jsp"></c:import>
		</div>
		${loginEmp.empName}님 반갑습니다
	</c:if>
</body>
</html>