<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</head>
<body>
 	<h1>시험 추가</h1>
	<div>${errorMsg}</div>
	<a href="">보기 추가/수정</a>
	<div>한 문제당 5점씩, 총 20문제를 등록할 수 있습니다. 현재 문제 개수 ${questionCount}/20</div>
	<form method="post" action="${pageContext.request.contextPath}/teacher/test/addQuestion" id="form">
		<input type="hidden" name="testNo" value="${testNo}">
		<table>
			<tr>
				<td>문제번호</td>
				<td><input type="number" name="questionIdx"></td>
			</tr>
			<tr>
				<td>문제</td>
				<td><input type="text" name="questionTitle"></td>
			</tr>
			<c:forEach var="i" begin="1" end="4">
				<tr>
					<td>
						보기${i}
						<input type="hidden" name="exampleIdx" value="${i}">
					</td>
					<td>
						<input type="text" name="exampleTitle">
						<input type="hidden" name="exampleOX" id="exampleOX${i}">
						<input type="checkbox" id="OX${i}">정답
					</td>
				</tr>
			</c:forEach>
		</table>
		<button type="button" id="btn">추가</button>
	</form>
	
	<!-- 자바스크립트 -->
	<script>	
	$('#btn').click(function(){
		// 오답/정답
		for(let val = 1; val < 5; val++){
			console.log(val);
			if ($('#OX'+val).is(':checked') == true) {
			    $('#exampleOX'+val).val('정답');
			} else {
				$('#exampleOX'+val).val('오답');
			}
		}
		// 폼 제출
		$('#form').submit();
	});
	</script>
</body>
</html>