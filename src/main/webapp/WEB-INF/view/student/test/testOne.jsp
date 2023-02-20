<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>LMS | 응시</title>
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
		$('#btn').click(function(){
			let checkbox = document.getElementsByName("answer");
			
			for(let i = 0; i < checkbox.length; i+=4){
				let count = 0;	// 문제마다 카운트 초기화
				
				for(let j = i; j < i+4; j++){
					console.log(checkbox[j]);
					if(checkbox[j].checked){	// 문제당 보기에 체크되어 있으면
						count++;				// count++
					}
				}
				
				if(count != 1){	// 1문제당 보기를 모두 돌았는데 정답을 1개 선택하지 않았다면
					alert('문제당 1개의 정답을 선택해 주세요');
					return;
				}
			}
			
			$('#form').submit();
		});
	});
</script>
</head>
<body>
 	<!-- header -->
	<div>
		<c:import url="/WEB-INF/view/inc/studentHeader.jsp"></c:import>
	</div>
	
	<main id="main" class="main">
		<div class="card container">
            <div class="card-body">
              <h5 class="card-title">${testList.get(0).get("testTitle")}</h5>
			  <div>${errorMsg}</div>
              <div class="d-flex justify-content-end">
				 <a href="${pageContext.request.contextPath}/teacher/test/addQuestion?testNo=${testList.get(0).get('testNo')}">문제추가</a>
              </div>
              <!-- Active Table -->
			<form method="post" action="${pageContext.request.contextPath}/student/test/testOne" id="form">
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
				 			<input type="hidden" name="questionNo" value="${t.questionNo}">
							<tr class="d-flex my-4">
								<td class="col-2 text-center">${t.questionIdx}</td>
								<td colspan="4">${t.questionTitle}</td>
							</tr>
							<tr class="d-flex my-4">
								<td class="col-2"></td>
								<td class="col-3">
									<input type="checkbox" name="answer" value="${t.exIdx0}" class="form-check-input">${t.exIdx0}. ${t.exTitle0}
								</td>
								<td class="col-3">
									<input type="checkbox" name="answer" value="${t.exIdx1}" class="form-check-input">${t.exIdx1}. ${t.exTitle1}
								</td>
								<td class="col-3">
									<input type="checkbox" name="answer" value="${t.exIdx2}" class="form-check-input">${t.exIdx2}. ${t.exTitle2}
								</td>
								<td class="col-3">
									<input type="checkbox" name="answer" value="${t.exIdx3}" class="form-check-input">${t.exIdx3}. ${t.exTitle3}
								</td>
							</tr>
						</c:forEach>
				 	</tbody>
				  </table>
				  <div class="text-center">
					  <button type="button" id="btn" class="btn btn-primary">답안지 제출</button>
				  </div>
				</div>
			 </form>
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