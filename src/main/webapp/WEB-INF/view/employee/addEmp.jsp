<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>온라인 시험 | 사원 추가</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
</head>
<body>
	<h1>사원 추가</h1>
	<div>${errorMsg}</div>
	
	<form method="post" action="${pageContext.request.contextPath}/employee/addEmp" id="form">
		<table>
			<tr>
				<td>empId</td>
				<td>
					<input type="text" name="empId" id="empId">
					<button type="button" id="ckBtn">중복확인</button>
				</td>
			</tr>
			<tr>
				<td>empPw</td>
				<td><input type="password" name="empPw"></td>
			</tr>
			<tr>
				<td>empName</td>
				<td><input type="text" name="empName"></td>
			</tr>	
		</table>
		<button type="submit" id="btn">사원추가</button>
	</form>
	
	<script>
		$('#ckBtn').click(function(){
			$.ajax({
				url:'/online-test/idCheck'
				, type:'get'
				, data : {empId:$('#empId').val()}
				, success:function(model){ // model : 'YES' / 'NO'
					if(model=='YES') {
						// 사용가능한 아이디
						alert($('#empId').val()+'는 사용 가능한 아이디입니다');
					} else {
						// 사용중인 아이디
						alert($('#empId').val()+'는 사용중인 아이디입니다');
						$('#empId').val('');
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