<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>온라인 시험 | 문제 수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</head>
<body>
  	<h1>문제 수정</h1>
	<div>${errorMsg}</div>
	<form method="post" action="${pageContext.request.contextPath}/teacher/test/modifyQuestion" id="form">
		<input type="hidden" name="questionNo" value="${list.get(0).get('questionNo')}">
		<table>
			<tr>
				<td>문제번호</td>
				<td><input type="number" name="questionIdx" value="${list.get(0).get('questionIdx')}"></td>
			</tr>
			<tr>
				<td>문제</td>
				<td><input type="text" name="questionTitle" value="${list.get(0).get('questionTitle')}"></td>
			</tr>
			<c:forEach var="m" items="${list}">
				<tr>
					<td>
						보기${m.exampleIdx}<input type="hidden" name="exampleIdx" value="${m.exampleIdx}">
						<input type="hidden" name="exampleNo" value="${m.exampleNo}">
					</td>
					<td>
						<input type="text" name="exampleTitle" value="${m.exampleTitle}">
						<input type="hidden" name="exampleOX" id="exampleOX${m.exampleIdx}">
						<input type="checkbox" id="OX${m.exampleIdx}" <c:if test="${m.exampleOX eq '정답'}">checked</c:if>>정답
					</td>
				</tr>
			</c:forEach>
		</table>
		<button type="button" id="btn">수정</button>
	</form>
	
	<!-- 자바스크립트 -->
	<script>	
		$('#btn').click(function(){
			alert('머임');
			// 오답/정답
			for(let val = 1; val < 5; val++){
				console.log(val);
				if ($('#OX'+val).is(':checked')) {
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