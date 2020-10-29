<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="../include/headerReal.jsp" %>
<div id="container">
<div class="tit-area">
				<h2>요금안내</h2>
				<p class="sub-tx">새얀은 가격정찰제로 운영됩니다</p>
			</div>

	<dl class="laun-bx01">
		
		<dd>
			<table class="data">
				<colgroup>
					<col style="width: 50%;">
					<col>
				</colgroup>
				<thead>
					<tr>
						<th scope="col">품목</th>
						<th scope="col">요금</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="pr" items="${price}">
			<tr>
				<td>${pr.pname}</td>
				<td>${pr.pprice}</td>
			</tr>
		</c:forEach>
				</tbody>
			</table>
		</dd>
	</dl>
</div>

</body>
</html>