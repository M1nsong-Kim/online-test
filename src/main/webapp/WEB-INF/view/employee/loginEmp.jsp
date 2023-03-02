<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>LMS | 직원 로그인</title>
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
<script>
	$(document).ready(function(){
		let allCheck = false;
		
		let empId = $('#empId');
		let empPw = $('#empPw');
		
		$('#btn').click(function(){
			if(empId.val().length < 1 || empId.val().trim() == ''){
				alert('아이디를 입력해 주세요');
			}else if(empPw.val().length < 1 || empPw.val().trim() == ''){
				alert('비밀번호를 입력해 주세요');
			}else {
				allCheck = true;
			}
			if(allCheck){
				$('#form').submit();
			}
		});
	});
</script>
</head>
<body>
	<!-- 로그인 전 -->
	<c:if test="${loginEmp == null}">
	  <main>
	    <div class="container">	
	      <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
	        <div class="container">
	          <div class="row justify-content-center">
	            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">
	
	              <div class="d-flex justify-content-center py-4">
	                <a href="index.html" class="logo d-flex align-items-center w-auto">
	                  <img src="assets/img/logo.png" alt="">
	                  <span class="d-none d-lg-block">LMS</span>
	                </a>
	              </div><!-- End Logo -->
	              
	              <div class="card mb-3">
	              
					<!-- 탭 -->
	              <ul class="nav nav-tabs d-flex" id="myTabjustified" role="tablist">
	                <li class="nav-item flex-fill" role="presentation">
	                  <button class="nav-link w-100 active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home-justified" type="button" role="tab" aria-controls="home" aria-selected="true">직원</button>
	                </li>
	                <li class="nav-item flex-fill" role="presentation">
	                  <button class="nav-link w-100" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile-justified" type="button" role="tab" aria-controls="profile" aria-selected="false" onclick = "location.href='${pageContext.request.contextPath}/loginTeacher'">강사</button>
	                </li>
	                <li class="nav-item flex-fill" role="presentation">
	                  <button class="nav-link w-100" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact-justified" type="button" role="tab" aria-controls="contact" aria-selected="false" onclick = "location.href='${pageContext.request.contextPath}/loginStudent'">학생</button>
	                </li>
	              </ul>

	                <div class="card-body">
	
	                  <div class="pt-4 pb-2">
	                    <h5 class="card-title text-center pb-0 fs-4">직원 로그인</h5>
	                    <p class="text-center small">아이디와 비밀번호를 입력하세요</p>
	                  </div>
	
	                  <form method="post" action="${pageContext.request.contextPath}/loginEmp" id="form" class="row g-3 needs-validation" novalidate>
	
	                    <div class="col-12">
	                      <label for="yourUsername" class="form-label">아이디</label>
	                      <div class="input-group has-validation">
	                        <input type="text" name="empId" id="empId" class="form-control" value="admin">
	                      </div>
	                    </div>
	
	                    <div class="col-12">
	                      <label for="yourPassword" class="form-label">비밀번호</label>
	                      <input type="password" name="empPw" id="empPw" class="form-control" value="1234">
	                    </div>
	
	                    <div class="col-12">
	               	      <button type="button" id="btn" class="btn btn-primary w-100">로그인</button>
	                    </div>
	                    <div class="col-12">
	                      <p class="text-center small mb-0">계정은 입사 후 자동으로 등록됩니다.</p>
	                    </div>
	                  </form>
	
	                </div>
	              </div>
	
	              <div class="credits">
	                <!-- All the links in the footer should remain intact. -->
	                <!-- You can delete the links only if you purchased the pro version. -->
	                <!-- Licensing information: https://bootstrapmade.com/license/ -->
	                <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/ -->
	                Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
	              </div>
	
	            </div>
	          </div>
	        </div>
	      </section>
	    </div>
	  </main>
	</c:if>

	<!-- 로그인 후 -->
	<c:if test="${loginEmp != null}">
		<div>
			<c:import url="/WEB-INF/view/inc/empHeader.jsp"></c:import>
		</div>
	</c:if>
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