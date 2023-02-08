<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>온라인 시험 | 문제 관리</title>
</head>
<body>
 	<h1>${testList.get(0).get("testTitle")}</h1>
 	<a href="${pageContext.request.contextPath}/teacher/test/addQuestion?testNo=${testList.get(0).get('testNo')}">문제추가</a>
 	<table>
 		<tr>
 			<th>문제번호</th>
 			<th>수정</th>
 			<th>문제</th>
 		</tr>
 		<c:forEach var="t" items="${testList}">	
			<tr>
				<td>${t.questionIdx}</td>
				<td>
					<a href="${pageContext.request.contextPath}/teacher/test/modifyQuestion">수정</a>
				</td>
				<td>${t.questionTitle}</td>
			</tr>
			<tr>
				<td colspan="2"></td>
				<td>
					<!-- 실행 시점이 달라서 반복문 돌리면서 i로 숫자 덧붙이는 건 불가능 -->
					<input type="radio" <c:if test="${t.exOX0 eq '정답'}">checked</c:if>>${t.exIdx0}. ${t.exTitle0}
					<input type="radio" <c:if test="${t.exOX1 eq '정답'}">checked</c:if>>${t.exIdx1}. ${t.exTitle1}
					<input type="radio" <c:if test="${t.exOX2 eq '정답'}">checked</c:if>>${t.exIdx2}. ${t.exTitle2}
					<input type="radio" <c:if test="${t.exOX3 eq '정답'}">checked</c:if>>${t.exIdx3}. ${t.exTitle3}
				</td>
			</tr>
			<!-- 
			<tr>
				<td colspan="3">
					<c:forEach var="e" items="${exList}">	
						<c:if test="${t.questionNo == e.questionNo}">
							<input type="radio" <c:if test="${e.exampleOX eq '정답'}">checked</c:if>>${e.exampleIdx}. ${e.exampleTitle}
						</c:if>
					</c:forEach>
				</td>
			</tr>
			 -->
		</c:forEach>
 	</table>
</body>
</html>