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
	<c:if test="${loginStudent == null}">
		<h1>login Student</h1>
		<form method="post" action="${pageContext.request.contextPath}/loginStudent">
			<table>
				<tr>
					<td>아이디</td>
					<td>
						<input type="text" name="studentId">
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td>
						<input type="password" name="studentPw">
					</td>
				</tr>
			</table>
			<button type="submit">로그인</button>
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