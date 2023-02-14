<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>온라인 시험 | 문제 수정</title>
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
  	<h1>문제 수정</h1>
	<div>${errorMsg}</div>
	<form method="post" action="${pageContext.request.contextPath}/teacher/test/modifyQuestion" id="form">
		<input type="hidden" name="questionNo" value="${list.get(0).get('questionNo')}">
		<table>
			<tr>
				<td>문제번호</td>
				<td><input type="number" name="questionIdx" value="${list.get(0).get('questionIdx')}" id="questionIdx"></td>
			</tr>
			<tr>
				<td>문제</td>
				<td><input type="text" name="questionTitle" value="${list.get(0).get('questionTitle')}" id="questionTitle"></td>
			</tr>
			<c:forEach var="m" items="${list}">
				<tr>
					<td>
						보기${m.exampleIdx}<input type="hidden" name="exampleIdx" value="${m.exampleIdx}">
						<input type="hidden" name="exampleNo" value="${m.exampleNo}">
					</td>
					<td>
						<input type="text" name="exampleTitle" value="${m.exampleTitle}" id="exampleTitle${m.exampleIdx}">
						<input type="hidden" name="exampleOX" id="exampleOX${m.exampleIdx}">
						<input type="checkbox" id="OX${m.exampleIdx}" <c:if test="${m.exampleOX eq '정답'}">checked</c:if>>정답
					</td>
				</tr>
			</c:forEach>
		</table>
		<button type="button" id="btn">수정</button>
	</form>
</body>
</html>