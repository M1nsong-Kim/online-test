<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>온라인 시험 | 응시</title>
</head>
<body>
 	<div>
		<c:import url="/WEB-INF/view/student/inc/studentMenu.jsp"></c:import>
	</div>
	
	<h1>${testList.get(0).get("testTitle")}</h1>
	<div>${errorMsg}</div>
	<form method="post" action="${pageContext.request.contextPath}/student/test/testOne" id="form">
	 	<table>
	 		<tr>
	 			<th>문제번호</th>
	 			<th colspan="4">문제</th>
	 		</tr>
	 		<c:forEach var="t" items="${testList}">	
	 			<input type="hidden" name="questionNo" value="${t.questionNo}">
				<tr>
					<td>${t.questionIdx}</td>
					<td>${t.questionTitle}</td>
				</tr>
				<tr>
					<td></td>
					<td>
						<input type="checkbox" name="answer" value="${t.exIdx0}">${t.exIdx0}. ${t.exTitle0}
					</td>
					<td>
						<input type="checkbox" name="answer" value="${t.exIdx1}">${t.exIdx1}. ${t.exTitle1}
					</td>
					<td>
						<input type="checkbox" name="answer" value="${t.exIdx2}">${t.exIdx2}. ${t.exTitle2}
					</td>
					<td>
						<input type="checkbox" name="answer" value="${t.exIdx3}">${t.exIdx3}. ${t.exTitle3}
					</td>
				</tr>
			</c:forEach>
	 	</table>
		<button type="submit">답안지 제출</button>
	</form>
	
	<script>
		// 유효성 검사: 체크된 길이가 20이 아니면(=답변을 20개 등록하지 않았다면) 돌려보내기
	</script>
</body>
</html>