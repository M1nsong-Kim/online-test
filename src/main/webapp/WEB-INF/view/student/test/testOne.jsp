<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>온라인 시험 | 응시</title>
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
 	<div>
		<c:import url="/WEB-INF/view/student/inc/studentMenu.jsp"></c:import>
	</div>
	
	<h1>${testList.get(0).get("testTitle")}</h1>
	<div>${errorMsg}</div>
	<form method="post" action="${pageContext.request.contextPath}/student/test/testOne" id="form">
	 	<table>
	 		<tr>
	 			<th>문제번호</th>
	 			<th colspan="4">문제</th>
	 		</tr>
	 		<c:forEach var="t" items="${testList}">	
	 			<input type="hidden" name="questionNo" value="${t.questionNo}">
				<tr>
					<td>${t.questionIdx}</td>
					<td>${t.questionTitle}</td>
				</tr>
				<tr>
					<td></td>
					<td>
						<input type="checkbox" name="answer" value="${t.exIdx0}">${t.exIdx0}. ${t.exTitle0}
					</td>
					<td>
						<input type="checkbox" name="answer" value="${t.exIdx1}">${t.exIdx1}. ${t.exTitle1}
					</td>
					<td>
						<input type="checkbox" name="answer" value="${t.exIdx2}">${t.exIdx2}. ${t.exTitle2}
					</td>
					<td>
						<input type="checkbox" name="answer" value="${t.exIdx3}">${t.exIdx3}. ${t.exTitle3}
					</td>
				</tr>
			</c:forEach>
	 	</table>
		<button type="button" id="btn">답안지 제출</button>
	</form>
</body>
</html>