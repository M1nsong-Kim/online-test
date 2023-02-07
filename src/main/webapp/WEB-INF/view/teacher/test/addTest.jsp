<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>온라인 시험 | 시험 추가</title>
</head>
<body>
 	<h1>시험 추가</h1>
	<div>${errorMsg}</div>
	<form method="post" action="${pageContext.request.contextPath}/teacher/test/addTest">
		<table>
			<tr>
				<td>시험명</td>
				<td><input type="text" name="testTitle"></td>
			</tr>
		</table>
		<button type="submit">추가</button>
	</form>
</body>
</html>