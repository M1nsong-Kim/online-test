<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>LMS | 문제 수정</title>
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
		
		let questionIdx = $('#questionIdx');
		let questionTitle = $('#questionTitle');
		
		$('#btn').click(function(){
			if(questionIdx.val().length < 1 || questionIdx.val().trim() == '' || questionIdx.val() > 20){
				alert('문제 번호를 입력해 주세요. 1번부터 20번까지 가능합니다.');
				return;
			}else if(questionTitle.val().length < 1 || questionTitle.val().trim() == ''){
				alert('문제를 입력해 주세요');
				return;
			}
			
			for(let val = 1; val < 5; val++){	
				if($('#exampleTitle'+val).val().length < 1 || $('#exampleTitle'+val).val().trim() == ''){
					alert('모든 보기를 입력해 주세요');
					return;
				}
			}
						
			// 오답/정답
			let count = 0;
			for(let val = 1; val < 5; val++){
				console.log(val);
				if ($('#OX'+val).is(':checked')) {
				    $('#exampleOX'+val).val('정답');
				    count++;
				} else {
					$('#exampleOX'+val).val('오답');
				}
			}
			
			if(count == 1){	// 정답 1개만 인정			
				allCheck = true;
			}else{
				alert('정답 보기를 1개만 체크해 주세요');
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
		<c:import url="/WEB-INF/view/inc/teacherHeader.jsp"></c:import>
	</div>
	
	<main id="main" class="main">
		<div class="row justify-content-center">
			<div class="col-lg-8">
				<div class="card">
		            <div class="card-body">
		              <h5 class="card-title">문제 등록</h5>
					  <div>${errorMsg}</div>
		              <form method="post" action="${pageContext.request.contextPath}/teacher/test/modifyQuestion" id="form" class="my-5">
		              	<input type="hidden" name="questionNo" value="${list.get(0).get('questionNo')}">
		                <div class="row mb-3">
		                  <label for="inputEmail3" class="col-sm-2 col-form-label">문제번호</label>
		                  <div class="col-sm-10">
		                    <input type="number" name="questionIdx" value="${list.get(0).get('questionIdx')}" id="questionIdx" class="form-control">
		                  </div>
		                </div>
		                <div class="row mb-3">
		                  <label for="inputEmail3" class="col-sm-2 col-form-label">문제</label>
		                  <div class="col-sm-10">
		                    <input type="text" name="questionTitle" value="${list.get(0).get('questionTitle')}" id="questionTitle" class="form-control">
		                  </div>
		                </div>
		                <c:forEach var="m" items="${list}">
			                <div class="row mb-3 d-flex justify-content-end">
			                  <label for="inputEmail3" class="col-sm-2 col-form-label">보기${m.exampleIdx}<input type="hidden" name="exampleIdx" value="${m.exampleIdx}"></label>
			                  <div class="col-sm-6">
			                  	<input type="hidden" name="exampleNo" value="${m.exampleNo}">
			                  	<input type="text" name="exampleTitle" value="${m.exampleTitle}" id="exampleTitle${m.exampleIdx}" class="form-control">
								<input type="hidden" name="exampleOX" id="exampleOX${m.exampleIdx}">
			                  </div>
			                  <div class="col-sm-2">
								<input type="checkbox" id="OX${m.exampleIdx}" <c:if test="${m.exampleOX eq '정답'}">checked</c:if> class="form-check-input">정답
						 	  </div>
			                </div>
		                </c:forEach>
		                <div class="text-center">
							<button type="button" id="btn" class="btn btn-primary">수정</button>
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