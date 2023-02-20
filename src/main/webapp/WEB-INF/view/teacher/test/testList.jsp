<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>LMS | 시험 관리</title>
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
	<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</head>
<body>
	<!-- header -->
	<div>
		<c:import url="/WEB-INF/view/inc/teacherHeader.jsp"></c:import>
	</div>
	
	<main id="main" class="main">
		<div class="card container">
            <div class="card-body">
              <h5 class="card-title">시험 목록</h5>
              <div class="d-flex justify-content-end">
	              <a href="${pageContext.request.contextPath}/teacher/test/addTest">시험등록</a>
              </div>
              <!-- Active Table -->
              <div class="my-1">
              	<table class="table table-borderless">
              		<tr class="d-flex">
						<th class="col-2">시험번호</th>
						<th class="col-5">시험명</th>
						<th class="col-2">실시일자</th>
						<th class="col-2">수정</th>
						<th class="col-2">삭제</th>
					</tr>
					<c:forEach var="t" items="${list}">	
						<tr class="d-flex">
							<td class="col-2">${t.testNo}</td>
							<td class="col-5"><a href="${pageContext.request.contextPath}/teacher/test/testOne?testNo=${t.testNo}">${t.testTitle}</a></td>
							<td class="col-2">${t.testDate}</td>
							<td class="col-2"><a href="${pageContext.request.contextPath}/teacher/test/modifyTest?testNo=${t.testNo}">수정</a></td>
							<td class="col-2"><a href="${pageContext.request.contextPath}/teacher/test/removeTest?testNo=${t.testNo}">삭제</a></td>
						</tr>
					</c:forEach>
				</table>
			  </div>
			  
				<!-- 페이징 -->
				<div class="my-5">
					<nav aria-label="Page navigation example">
		                <ul class="pagination justify-content-center">
		                	<!-- 이전 -->
							<c:if test="${currentPage <= 10}">
				                  <li class="page-item disabled">
									<a href="${pageContext.request.contextPath}/teacher/test/testList?currentPage=${startPage-10}" class="page-link" aria-label="Previous">&laquo;</a>
				                  </li>
							</c:if>
							<c:if test="${currentPage > 10}">
				                  <li class="page-item">
									<a href="${pageContext.request.contextPath}/teacher/test/testList?currentPage=${startPage-10}" class="page-link" aria-label="Previous">&laquo;</a>
				                  </li>
							</c:if>
							<!-- 1~10 -->
								<c:forEach var="i" begin="${startPage}" end="${endPage}">
									 <li class="page-item">
										<c:if test="${i == currentPage}">
											<a href="${pageContext.request.contextPath}/teacher/test/testList?currentPage=${i}" class="page-link active" style="display:inline-block;">${i}</a>
										</c:if>
					                </li>
					                <li class="page-item">
										<c:if test="${i != currentPage}">
											<a href="${pageContext.request.contextPath}/teacher/test/testList?currentPage=${i}" class="page-link" style="display:inline-block;">${i}</a>
										</c:if>
					                </li>
								</c:forEach>
		                  	<!-- 다음 -->
							<c:if test="${currentPage+10 < lastPage}">
				                  <li class="page-item">
									<a href="${pageContext.request.contextPath}/teacher/test/testList?currentPage=${startPage+10}" class="page-link" aria-label="Next">
										<span aria-hidden="true">&raquo;</span>
									</a>
				                  </li>
							</c:if>
							<c:if test="${currentPage+10 >= lastPage}">
				                  <li class="page-item disabled">
									<a href="${pageContext.request.contextPath}/teacher/test/testList?currentPage=${startPage+10}" class="page-link" aria-label="Next">
										<span aria-hidden="true">&raquo;</span>
									</a>
				                  </li>
							</c:if>	
		                </ul>
		            </nav>
				</div>
			</div>
		</div>
	</main>
	
	<!-- footer -->
	<div>
		<jsp:include page="/WEB-INF/view/inc/footer.jsp"></jsp:include>
	</div>
	
	  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Vendor JS Files -->
  <script src="${pageContext.request.contextPath}/assets/vendor/apexcharts/apexcharts.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/vendor/chart.js/chart.umd.js"></script>
  <script src="${pageContext.request.contextPath}/assets/vendor/echarts/echarts.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/vendor/quill/quill.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/vendor/simple-datatables/simple-datatables.js"></script>
  <script src="${pageContext.request.contextPath}/assets/vendor/tinymce/tinymce.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>