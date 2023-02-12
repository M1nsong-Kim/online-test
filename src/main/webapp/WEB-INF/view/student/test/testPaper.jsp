<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>온라인 시험 | 답안지 확인</title>
</head>
<body>
	<div>
		<c:import url="/WEB-INF/view/student/inc/studentMenu.jsp"></c:import>
	</div>

	<div>${score}점/100점</div>
	<table>
 		<tr>
 			<th>문제번호</th>
 			<th colspan="4">문제</th>
 		</tr>
 		<c:forEach var="t" items="${testList}">	
			<tr>
				<td>${t.questionIdx}</td>
				<td>${t.questionTitle}</td>
			</tr>
			<tr>
				<td></td>
				<c:if test="${exList != null}">
					<td>
						<input type="radio" <c:if test="${t.exOX0 eq '정답'}">checked</c:if>>${t.exIdx0}. ${t.exTitle0}
					</td>
					<td>
						<input type="radio" <c:if test="${t.exOX1 eq '정답'}">checked</c:if>>${t.exIdx1}. ${t.exTitle1}
					</td>
					<td>
						<input type="radio" <c:if test="${t.exOX2 eq '정답'}">checked</c:if>>${t.exIdx2}. ${t.exTitle2}
					</td>
					<td>
						<input type="radio" <c:if test="${t.exOX3 eq '정답'}">checked</c:if>>${t.exIdx3}. ${t.exTitle3}
					</td>
				</c:if>
				<c:if test="${exList != null}">
					<td colspan="4"></td>
				</c:if>
			</tr>
			<tr>
				<td></td>
				<td>내가 선택한 답: ${t.answer}</td>
			</tr>
		</c:forEach>
 	</table>
</body>
</html>