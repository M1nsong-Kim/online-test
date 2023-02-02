<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 	<!-- jstl 페이지 include -->
	<div>
		<c:import url="/WEB-INF/view/employee/inc/empMenu.jsp"></c:import>
	</div>

	<h1>Teacher List</h1>
	<a href="${pageContext.request.contextPath}/employee/teacher/addTeacher">강사등록</a>
	<table>
		<tr>
			<th>teacherId</th>
			<th>teacherName</th>
			<th>삭제</th>
		</tr>
		<c:forEach var="t" items="${list}">	
			<tr>
				<td>${t.teacherId}</td>
				<td>${t.teacherName}</td>
				<td><a href="${pageContext.request.contextPath}/employee/teacher/removeTeacher?teacherNo=${t.teacherNo}">삭제</a></td>
			</tr>
		</c:forEach>
	</table>
	<!-- 검색 -->
	<form method="get" action="${pageContext.request.contextPath}/employee/teacher/teacherList">
		<input type="text" name="searchWord">
		<button type="submit">검색</button>
	</form>
	<!-- 페이징 -->
	<div>
		<c:if test="${currentPage != 1}">
			<a href="${pageContext.request.contextPath}/employee/teacher/teacherList?currentPage=1&searchWord=${searchWord}">처음</a>
		</c:if>
		<c:if test="${currentPage > 10}">
			<a href="${pageContext.request.contextPath}/employee/teacher/teacherList?currentPage=${startPage-10}&searchWord=${searchWord}">이전</a>
		</c:if>
		<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<a href="${pageContext.request.contextPath}/employee/teacher/teacherList?currentPage=${i}&searchWord=${searchWord}">${i}</a>
		</c:forEach>
		<c:if test="${currentPage+10 < lastPage}">
			<a href="${pageContext.request.contextPath}/employee/teacher/teacherList?currentPage=${startPage+10}&searchWord=${searchWord}">다음</a>
		</c:if>		
		<c:if test="${currentPage != lastPage}">
			<a href="${pageContext.request.contextPath}/employee/teacher/teacherList?currentPage=${lastPage}&searchWord=${searchWord}">마지막</a>
		</c:if>
	</div>
</body>
</html>