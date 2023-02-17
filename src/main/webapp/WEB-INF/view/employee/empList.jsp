<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>LMS | 사원 목록</title>
<meta content="" name="description">
<meta content="" name="keywords">
	<!-- Google Fonts -->
	<link href="https://fonts.gstatic.com" rel="preconnect">
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
	<!-- Vendor CSS Files -->
	<link href="${pageContext.request.contextPath}/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/assets/vendor/quill/quill.snow.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/assets/vendor/quill/quill.bubble.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/assets/vendor/remixicon/remixicon.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/assets/vendor/simple-datatables/style.css" rel="stylesheet">
	
	<!-- Template Main CSS File -->
	<link href="assets/css/style.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</head>
<body>
	<!-- header -->
	<jsp:include page="/WEB-INF/view/inc/empHeader.jsp"></jsp:include>

	<!-- jstl 페이지 include -->
	<div>
		<c:import url="/WEB-INF/view/employee/inc/empMenu.jsp"></c:import>
	</div>

	<h1>Employee List</h1>
	<a href="${pageContext.request.contextPath}/employee/addEmp">사원등록</a>
	<table>
		<tr>
			<th>empId</th>
			<th>empName</th>
			<th>삭제</th>
		</tr>
		<!-- list라고만 적어서 javax.el.PropertyNotFoundException: Property [empId] not found on type [java.lang.String] 이 오류 떳음..^^ -->
		<c:forEach var="e" items="${list}">	
			<tr>
				<td>${e.empId}</td>
				<td>${e.empName}</td>
				<td><a href="${pageContext.request.contextPath}/employee/removeEmp?empNo=${e.empNo}">삭제</a></td>
			</tr>
		</c:forEach>
	</table>
	<!-- 검색 -->
	<form method="get" action="${pageContext.request.contextPath}/employee/empList">
		<input type="text" name="searchWord">
		<button type="submit">검색</button>
	</form>
	<!-- 페이징 -->
	<div>
		<c:if test="${currentPage != 1}">
			<a href="${pageContext.request.contextPath}/employee/empList?currentPage=1&searchWord=${searchWord}">처음</a>
		</c:if>
		<c:if test="${currentPage > 10}">
			<a href="${pageContext.request.contextPath}/employee/empList?currentPage=${startPage-10}&searchWord=${searchWord}">이전</a>
		</c:if>
		<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<a href="${pageContext.request.contextPath}/employee/empList?currentPage=${i}&searchWord=${searchWord}">${i}</a>
		</c:forEach>
		<c:if test="${currentPage+10 < lastPage}">
			<a href="${pageContext.request.contextPath}/employee/empList?currentPage=${startPage+10}&searchWord=${searchWord}">다음</a>
		</c:if>		
		<c:if test="${currentPage != lastPage}">
			<a href="${pageContext.request.contextPath}/employee/empList?currentPage=${lastPage}&searchWord=${searchWord}">마지막</a>
		</c:if>
	</div>
	
	<!-- footer -->
	<jsp:include page="/WEB-INF/view/inc/footer.jsp"></jsp:include>
</body>
</html>