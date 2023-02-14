<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>온라인 시험 | 강사 등록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		let idCheck = false;
		let allCheck = false;
	
		let teacherId = $('#teacherId');
		let teacherPw = $('#teacherPw');
		let teacherName = $('#teacherName');
		
		// 중복 확인
		$('#ckBtn').click(function(){
			$.ajax({
				url:'/online-test/idCheck'
				, type:'get'
				, data : {teacherId:$('#teacherId').val()}
				, success:function(model){ // model : 'YES' / 'NO'
					if(model=='YES') {
						// 사용가능한 아이디
						alert($('#teacherId').val()+'는 사용 가능한 아이디입니다');
						teacherId.attr('readonly', true);	// 사용 가능한 아이디면 그대로 쓰도록
						idCheck = true;
					} else {
						// 사용중인 아이디
						alert($('#teacherId').val()+'는 사용중인 아이디입니다');
						$('#teacherId').val('');
					}
				}
			});
		});
		
		// 폼 유효성 검사
		$('#btn').click(function() {
			if(!idCheck){
				alert('아이디 중복 여부를 확인해 주세요');
			}else if(teacherPw.val().length < 1 || teacherPw.val().trim() == ''){
				alert('비밀번호를 입력해 주세요');
			}else if(teacherName.val().length < 1 || teacherName.val().trim() == ''){
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
 	<h1>강사 등록</h1>
	<div>${errorMsg}</div>
	<form method="post" action="${pageContext.request.contextPath}/employee/teacher/addTeacher" id="form">
		<table>
			<tr>
				<td>아이디</td>
				<td>
					<input type="text" name="teacherId" id="teacherId">
					<button type="button" id="ckBtn">중복확인</button>
				</td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="teacherPw" id="teacherPw"></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="teacherName" id="teacherName"></td>
			</tr>	
		</table>
		<button type="button" id="btn">등록</button>
	</form>
</body>
</html>