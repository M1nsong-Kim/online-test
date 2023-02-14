<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>온라인 시험 | 시험명 변경</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>	
	$(document).ready(function(){
		let allCheck = false;
		
		let testTitle = $('#testTitle');
		
		$('#btn').click(function(){
			if(testTitle.val().length < 1 || testTitle.val().trim() == ''){
				alert('시험명을 입력해 주세요');
			}else {
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
	<h1>문제 수정</h1>
	<div>${errorMsg}</div>
	<form method="post" action="${pageContext.request.contextPath}/teacher/test/modifyTest" id="form">
		<input type="hidden" name="testNo" value="${testNo}">
		<table>
			<tr>
				<td>시험명</td>
				<td><input type="text" name="testTitle" value="${testTitle}" id="testTitle"></td>
			</tr>
		</table>
		<button type="button" id="btn">수정</button>
	</form>
</body>
</html>