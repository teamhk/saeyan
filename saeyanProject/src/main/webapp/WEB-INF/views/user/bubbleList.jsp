<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hk.saeyan.dto.Members" %>
<%@ page import="com.hk.saeyan.dto.Bubble" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>Bubble 리스트</h2>
<div id='maindiv'>
	<table border='1'>
		<tr>
			<td>충전금액</td>
			<td>충전버블</td>
			<td>버블잔량</td>
			<td>버블사용</td>
			<td>날짜</td>
		</tr>
		<c:forEach items="${bub}" var="bubble"> <!-- 반복문으로 tr,td생성 -->
			<tr>
				<td>${bubble.b_price}</td>
				<td>${bubble.b_bubble}</td>
				<td>${bubble.bubble}</td>
				<td>${bubble.p_bubble}</td>
				<td><fmt:formatDate pattern="yyyy-MM-dd" value="${bubble.b_date}"/></td>

			</tr>
		</c:forEach>
	</table>
	</div>
	<div id='detail'>
	</div>
</body>
</html>