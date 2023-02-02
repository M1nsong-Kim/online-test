<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 로그인 전 -->
	<c:if test="${loginEmp == null}">
		<h1>login Employee</h1>
		<form method="post" action="${pageContext.request.contextPath}/loginEmp">
			<table>
				<tr>
					<td>아이디</td>
					<td>
						<input type="text" name="empId">
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td>
						<input type="password" name="empPw">
					</td>
				</tr>
			</table>
			<button type="submit">로그인</button>
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