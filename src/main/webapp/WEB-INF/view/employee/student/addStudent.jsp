<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>온라인 시험 | 학생 등록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		let idCheck = false;
		let allCheck = false;
	
		let studentId = $('#studentId');
		let studentPw = $('#studentPw');
		let studentName = $('#studentName');
		
		// 중복 확인
		$('#ckBtn').click(function(){
			if(studentId.val().length < 1 || studentId.val().trim() == ''){
				alert('아이디를 입력해 주세요');
				return;
			}
			
			$.ajax({
				url:'/online-test/idCheck'
				, type:'get'
				, data : {studentId:$('#studentId').val()}
				, success:function(model){ // model : 'YES' / 'NO'
					if(model=='YES') {
						// 사용가능한 아이디
						alert($('#studentId').val()+'는 사용 가능한 아이디입니다');
						studentId.attr('readonly', true);	// 사용 가능한 아이디면 그대로 쓰도록
						idCheck = true;
					} else {
						// 사용중인 아이디
						alert($('#studentId').val()+'는 사용중인 아이디입니다');
						$('#studentId').val('');
					}
				}
			});
		});

		// 폼 유효성 검사
		$('#btn').click(function() {
			if(!idCheck){
				alert('아이디 중복 여부를 확인해 주세요');
			}else if(studentPw.val().length < 1 || studentPw.val().trim() == ''){
				alert('비밀번호를 입력해 주세요');
			}else if(studentName.val().length < 1 || studentName.val().trim() == ''){
				alert('이름을 입력해 주세요');
			}else{
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
 	<h1>학생 등록</h1>
	<div>${errorMsg}</div>
	<form method="post" action="${pageContext.request.contextPath}/employee/student/addStudent" id="form">
		<table>
			<tr>
				<td>아이디</td>
				<td>
					<input type="text" name="studentId" id="studentId">
					<button type="button" id="ckBtn">중복확인</button>
				</td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="studentPw" id="studentPw"></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="studentName" id="studentName"></td>
			</tr>	
		</table>
		<button type="button" id="btn">등록</button>
	</form>
</body>
</html>