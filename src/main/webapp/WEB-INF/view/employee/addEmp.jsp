<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>온라인 시험 | 사원 추가</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		let idCheck = false;
		let allCheck = false;
	
		let empId = $('#empId');
		let empPw = $('#empPw');
		let empName = $('#empName');
		
		// 중복 확인
		$('#ckBtn').click(function(){
			$.ajax({
				url:'/online-test/idCheck'
				, type:'get'
				, data : {empId:$('#empId').val()}
				, success:function(model){ // model : 'YES' / 'NO'
					if(model=='YES') {
						// 사용가능한 아이디
						alert($('#empId').val()+'는 사용 가능한 아이디입니다');
						empId.attr('readonly', true);	// 사용 가능한 아이디면 그대로 쓰도록
						idCheck = true;
					} else {
						// 사용중인 아이디
						alert($('#empId').val()+'는 사용중인 아이디입니다');
						$('#empId').val('');
					}
				}
			});
		});
		
		// 폼 유효성 검사
		$('#btn').click(function() {
			if(!idCheck){
				alert('아이디 중복 여부를 확인해 주세요');
			}else if(empPw.val().length < 1 || empPw.val().trim() == ''){
				alert('비밀번호를 입력해 주세요');
			}else if(empName.val().length < 1 || empName.val().trim() == ''){
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
	<h1>사원 추가</h1>
	<div>${errorMsg}</div>
	
	<form method="post" action="${pageContext.request.contextPath}/employee/addEmp" id="form">
		<table>
			<tr>
				<td>아이디</td>
				<td>
					<input type="text" name="empId" id="empId">
					<button type="button" id="ckBtn">중복확인</button>
				</td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="empPw" id="empPw"></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="empName" id="empName"></td>
			</tr>	
		</table>
		<button type="button" id="btn">사원추가</button>
	</form>
</body>
</html>