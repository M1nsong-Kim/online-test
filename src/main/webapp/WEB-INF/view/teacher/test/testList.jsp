<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>온라인 시험 | 시험 관리</title>
</head>
<body>
	<div>
		<c:import url="/WEB-INF/view/teacher/inc/teacherMenu.jsp"></c:import>
	</div>
	
	<h1>Test List</h1>
	<a href="${pageContext.request.contextPath}/teacher/test/addTest">시험등록</a>
	<table>
		<tr>
			<th>시험번호</th>
			<th>시험명</th>
			<th>실시일자</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
		<c:forEach var="t" items="${list}">	
			<tr>
				<td>${t.testNo}</td>
				<td><a href="${pageContext.request.contextPath}/teacher/test/testOne?testNo=${t.testNo}">${t.testTitle}</a></td>
				<td>${t.testDate}</td>
				<td><a href="${pageContext.request.contextPath}/teacher/test/modifyTest?testNo=${t.testNo}">수정</a></td>
				<td><a href="${pageContext.request.contextPath}/teacher/test/removeTest?testNo=${t.testNo}">삭제</a></td>
			</tr>
		</c:forEach>
	</table>
	<!-- 페이징 -->
	<div>
		<c:if test="${currentPage != 1}">
			<a href="${pageContext.request.contextPath}/teacher/test/testList?currentPage=1">처음</a>
		</c:if>
		<c:if test="${currentPage > 10}">
			<a href="${pageContext.request.contextPath}/teacher/test/testList?currentPage=${startPage-10}">이전</a>
		</c:if>
		<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<a href="${pageContext.request.contextPath}/teacher/test/testList?currentPage=${i}">${i}</a>
		</c:forEach>
		<c:if test="${currentPage+10 < lastPage}">
			<a href="${pageContext.request.contextPath}/teacher/test/testList?currentPage=${startPage+10}">다음</a>
		</c:if>		
		<c:if test="${currentPage != lastPage}">
			<a href="${pageContext.request.contextPath}/teacher/test/testList?currentPage=${lastPage}">마지막</a>
		</c:if>
	</div>
</body>
</html>