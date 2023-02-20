<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>LMS | 답안지 확인</title>
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
</head>
<body>
	<!-- header -->
	<div>
		<c:import url="/WEB-INF/view/inc/studentHeader.jsp"></c:import>
	</div>

	<main id="main" class="main">
		<div class="card container">
            <div class="card-body">
			  <div>${errorMsg}</div>
			  <h5 class="card-title">${score}점/100점</h5>
				<div class="my-1">
              	<table class="table table-borderless">
              		<thead>
	              		<tr class="d-flex">
			 			<th class="col-2 text-center">문제번호</th>
			 			<th colspan="4">문제</th>
			 		</tr>
			 		</thead>
			 		<tbody>
				 		<c:forEach var="t" items="${testList}">	
							<tr class="d-flex my-4">
								<td class="col-2 text-center">${t.questionIdx}</td>
								<td colspan="4">${t.questionTitle}</td>
							</tr>
							<tr class="d-flex my-4">
								<td class="col-2 text-center"></td>
								<c:if test="${exList != null}">
									<td class="col-2">
										<input type="radio" <c:if test="${t.exOX0 eq '정답'}">checked</c:if>>${t.exIdx0}. ${t.exTitle0}
									</td>
									<td class="col-2">
										<input type="radio" <c:if test="${t.exOX1 eq '정답'}">checked</c:if>>${t.exIdx1}. ${t.exTitle1}
									</td>
									<td class="col-2">
										<input type="radio" <c:if test="${t.exOX2 eq '정답'}">checked</c:if>>${t.exIdx2}. ${t.exTitle2}
									</td>
									<td class="col-2">
										<input type="radio" <c:if test="${t.exOX3 eq '정답'}">checked</c:if>>${t.exIdx3}. ${t.exTitle3}
									</td>
								</c:if>
								<c:if test="${exList != null}">
									<td colspan="4"></td>
								</c:if>
							</tr>
							<tr class="d-flex my-4">
								<td class="col-2 text-center"></td>
								<td colspan="4">내가 선택한 답: ${t.answer}</td>
							</tr>
						</c:forEach>
			 		</tbody>
			 	</table>
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