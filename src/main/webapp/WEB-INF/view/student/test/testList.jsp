<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>온라인 시험 | 시험 목록</title>
</head>
<body>
 	<div>
		<c:import url="/WEB-INF/view/student/inc/studentMenu.jsp"></c:import>
	</div>
	
	<h1>시험 목록</h1>
	<table>
		<tr>
			<th>시험번호</th>
			<th>시험명</th>
			<th>일자</th>
			<th>수정</th>
		</tr>
		<c:forEach var="t" items="${list}">	
			<tr>
				<td>${t.testNo}</td>
				<td>${t.testTitle}</td>
				<td>${t.testDate}</td>
				<td>
					<c:if test="${!takenTestList.isEmpty()}">
						<c:forEach var="tt" items="${takenTestList}">
							<c:if test="${tt != t.testNo}">
								<a href="${pageContext.request.contextPath}/student/test/testOne?testNo=${t.testNo}">응시</a>
							</c:if>
						</c:forEach>
						<c:forEach var="tt" items="${takenTestList}">
							<c:if test="${tt == t.testNo}">
								<a href="${pageContext.request.contextPath}/student/test/testPaper?testNo=${t.testNo}">답안확인</a>
							</c:if>
						</c:forEach>
					</c:if>
					<!-- paper 테이블이 비어 있는 초기 상태 고려 -->
					<c:if test="${takenTestList.isEmpty()}">
						<a href="${pageContext.request.contextPath}/student/test/testOne?testNo=${t.testNo}">응시</a>
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</table>
	<!-- 페이징 -->
	<div>
		<c:if test="${currentPage != 1}">
			<a href="${pageContext.request.contextPath}/student/test/testList?currentPage=1">처음</a>
		</c:if>
		<c:if test="${currentPage > 10}">
			<a href="${pageContext.request.contextPath}/student/test/testList?currentPage=${startPage-10}">이전</a>
		</c:if>
		<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<a href="${pageContext.request.contextPath}/student/test/testList?currentPage=${i}">${i}</a>
		</c:forEach>
		<c:if test="${currentPage+10 < lastPage}">
			<a href="${pageContext.request.contextPath}/student/test/testList?currentPage=${startPage+10}">다음</a>
		</c:if>		
		<c:if test="${currentPage != lastPage}">
			<a href="${pageContext.request.contextPath}/student/test/testList?currentPage=${lastPage}">마지막</a>
		</c:if>
	</div>
</body>
</html>