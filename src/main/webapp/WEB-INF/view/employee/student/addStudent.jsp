<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>온라인 시험 | 학생 등록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
</head>
<body>
 	<h1>학생 등록</h1>
	<div>${errorMsg}</div>
	<form method="post" action="${pageContext.request.contextPath}/employee/student/addStudent" id="form">
		<table>
			<tr>
				<td>studentId</td>
				<td>
					<input type="text" name="studentId" id="studentId">
					<button type="button" id="ckBtn">중복확인</button>
				</td>
			</tr>
			<tr>
				<td>studentPw</td>
				<td><input type="password" name="studentPw"></td>
			</tr>
			<tr>
				<td>studentName</td>
				<td><input type="text" name="studentName"></td>
			</tr>	
		</table>
		<button type="button" id="btn">등록</button>
	</form>
	
	<script>
		$('#ckBtn').click(function(){
			$.ajax({
				url:'/online-test/idCheck'
				, type:'get'
				, data : {studentId:$('#studentId').val()}
				, success:function(model){ // model : 'YES' / 'NO'
					if(model=='YES') {
						// 사용가능한 아이디
						alert($('#studentId').val()+'는 사용 가능한 아이디입니다');
					} else {
						// 사용중인 아이디
						alert($('#studentId').val()+'는 사용중인 아이디입니다');
						$('#studentId').val('');
					}
				}
			});
		});
		
		/*
		$('#btn').click(function() {
			// 폼 유효성 검사
		});
		*/
	</script>
</body>
</html>