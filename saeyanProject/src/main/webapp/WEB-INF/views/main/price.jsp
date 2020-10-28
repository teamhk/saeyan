<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가격표</title>
</head>
<body>
<h4>가격표</h4>
<p>새얀은 가격정찰제로 운영됩니다<p>
<table>
	<tr>
		<td>품목</td>
		<td>기본요금</td>
	</tr>
	<c:forEach var="pr" items="${price}">
	<tr>
		<td>${pr.pname}</td>
		<td>${pr.pprice}</td>
	</tr>
	</c:forEach>
</table>


</body>
</html>