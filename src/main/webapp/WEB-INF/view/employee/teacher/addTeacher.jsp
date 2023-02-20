<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>LMS | 강사 등록</title>
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
		let idCheck = false;
		let allCheck = false;
	
		let teacherId = $('#teacherId');
		let teacherPw = $('#teacherPw');
		let teacherName = $('#teacherName');
		
		// 중복 확인
		$('#ckBtn').click(function(){
			$.ajax({
				url:'/online-test/idCheck'
				, type:'get'
				, data : {teacherId:$('#teacherId').val()}
				, success:function(model){ // model : 'YES' / 'NO'
					if(model=='YES') {
						// 사용가능한 아이디
						alert($('#teacherId').val()+'는 사용 가능한 아이디입니다');
						teacherId.attr('readonly', true);	// 사용 가능한 아이디면 그대로 쓰도록
						idCheck = true;
					} else {
						// 사용중인 아이디
						alert($('#teacherId').val()+'는 사용중인 아이디입니다');
						$('#teacherId').val('');
					}
				}
			});
		});
		
		// 폼 유효성 검사
		$('#btn').click(function() {
			if(!idCheck){
				alert('아이디 중복 여부를 확인해 주세요');
			}else if(teacherPw.val().length < 1 || teacherPw.val().trim() == ''){
				alert('비밀번호를 입력해 주세요');
			}else if(teacherName.val().length < 1 || teacherName.val().trim() == ''){
				alert('이름을 입력해 주세요');
			}else{
				allCheck = true;
			}
			
			// 폼 제출
			if(allCheck){
				$('#form').submit();
			}
		});
	});
</script>
</head>
<body>
	<!-- header -->
	<div>
		<c:import url="/WEB-INF/view/inc/empHeader.jsp"></c:import>
	</div>
	
	<main id="main" class="main">
		<div class="row justify-content-center">
			<div class="col-lg-8">
				<div class="card">
		            <div class="card-body">
		              <h5 class="card-title">강사 등록</h5>
					  <div>${errorMsg}</div>
		              <form method="post" action="${pageContext.request.contextPath}/employee/teacher/addTeacher" id="form" class="my-5">
		                <div class="row mb-3">
		                  <label for="inputEmail3" class="col-sm-2 col-form-label">아이디</label>
		                  <div class="col-sm-8">
		                    <input type="text" name="teacherId" id="teacherId" class="form-control">
		                  </div>
		                  <div class="col-sm-2">
							<button type="button" id="ckBtn" class="btn btn-primary">중복확인</button>
						  </div>
		                </div>
		                <div class="row mb-3">
		                  <label for="inputEmail3" class="col-sm-2 col-form-label">비밀번호</label>
		                  <div class="col-sm-10">
		                    <input type="password" name="teacherPw" id="teacherPw" class="form-control">
		                  </div>
		                </div>
		                <div class="row mb-3">
		                  <label for="inputPassword3" class="col-sm-2 col-form-label">이름</label>
		                  <div class="col-sm-10">
		                    <input type="text" name="teacherName" id="teacherName" class="form-control">
		                  </div>
		                </div>
		                <div class="text-center">
							<button type="button" id="btn" class="btn btn-primary">등록</button>
		                </div>
		              </form><!-- End Horizontal Form -->

					</div>
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