<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>온라인 시험 | 시험 추가</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>	
	$(document).ready(function(){
		let allCheck = false;
		
		let testTitle = $('#testTitle');
		let questionTitle = $('#questionTitle');
		
		$('#btn').click(function(){
			if(testTitle.val().length < 1 || testTitle.val().trim() == ''){
				alert('시험명을 입력해 주세요');
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
 	<h1>시험 추가</h1>
	<div>${errorMsg}</div>
	<div>1번 문제와 함께 시험을 등록할 수 있습니다.</div>
	<form method="post" action="${pageContext.request.contextPath}/teacher/test/addTest" id="form">
		<table>
			<tr>
				<td>시험명</td>
				<td><input type="text" name="testTitle" id="testTitle"></td>
			</tr>
			<tr>
				<td>문제번호</td>
				<td><input type="number" name="questionIdx" value="1" disabled></td>
			</tr>
			<tr>
				<td>문제</td>
				<td><input type="text" name="questionTitle" id="questionTitle"></td>
			</tr>
			<c:forEach var="i" begin="1" end="4">
				<tr>
					<td>
						보기${i}
						<input type="hidden" name="exampleIdx" value="${i}">
					</td>
					<td>
						<input type="text" name="exampleTitle" id="exampleTitle${i}">
						<input type="hidden" name="exampleOX" id="exampleOX${i}">
						<input type="checkbox" id="OX${i}">정답
					</td>
				</tr>
			</c:forEach>
		</table>
		<button type="button" id="btn">추가</button>
	</form>
</body>
</html>