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
	<c:if test="${loginTeacher == null}">
		<h1>login Teacher</h1>
		<form method="post" action="${pageContext.request.contextPath}/loginTeacher">
			<table>
				<tr>
					<td>아이디</td>
					<td>
						<input type="text" name="teacherId">
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td>
						<input type="password" name="teacherPw">
					</td>
				</tr>
			</table>
			<button type="submit">로그인</button>
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