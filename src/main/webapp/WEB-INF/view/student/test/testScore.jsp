<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>온라인 시험 | 내 성적 확인</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
</head>
<body>
	<div>
		<c:import url="/WEB-INF/view/student/inc/studentMenu.jsp"></c:import>
	</div>
	
	<h1>내 성적</h1>
	<canvas id="myChart" style="width:100%;max-width:600px"></canvas>
	
	<script>
		// 모델 데이터 가져온 후에 아래 차트가 그려져야 한다 -> 동기로 처리해야 한다
		// async값을 false로 변경,  참고 https://api.jquery.com/jquery.ajax
		let xModel = []; // 키배열
		let yModel = []; // 값배열
		$.ajax({
			async : false // 동기처리
			, url : '/online-test/testScore'
			, type : 'get'
			, success : function(model) {
				for(let attr in model) { 
					xModel.push(attr);
					yModel.push(model[attr]);
				}
			}
		});
	</script>

	<!-- 차트 그리기 -->
 	<script>
		var xValues = xModel;	// 시험회차
		var yValues = yModel;	// 점수
		console.log(xValues);
		console.log(yValues);
		
		new Chart("myChart", {
		  type: "line",
		  data: {
		    labels: xValues,
		    datasets: [{
		      fill: false,
		      lineTension: 0,
		      backgroundColor: "rgba(0,0,255,1.0)",
		      borderColor: "rgba(0,0,255,0.1)",
		      data: yValues
		    }]
		  },
		  options: {
		    legend: {display: false},
		    scales: {
		      yAxes: [{ticks: {min: 0, max:100}}],
		    }
		  }
		});
	</script>
</body>
</html>