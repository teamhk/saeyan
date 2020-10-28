<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id=payck> 
<h3>결제가 완료되었습니다</h3>


			<table class="table table-bordered" id="tbl-product">
				<colgroup>
					<col style="width: 20%;" />
					<col style="width: 20%" />
					<col style="width: 20%" />
					<col style="width: 20%" />
					<col style="width: 20%" />
				</colgroup>
				<tr>

					<!--              <th><input type="checkbox" name="allCheck" id="allCheck" checked="checked"/></th>  -->
					<th>주문번호</th>
					<th>주문품목</th>
					<th>상품금액</th>
					<th>버블사용</th>
					<th>결제수단</th>
				</tr>
				<c:forEach var="payList" items="${payChk}">
				<tr>
					<td>${payList.orderNum}</td>
					<c:set var="itemStr" value="${payList.items}" />
						<c:set var="itemStr" value="${fn:replace(itemStr, '!@#', ':')}" />
						<c:set var="itemStr" value="${fn:replace(itemStr, '$%^', ',')}" />
						<c:set var="itemStr"
							value="${fn:substring(itemStr, 0, fn:length(itemStr)-1)}" />
					<td class='item'>${itemStr}</td>
					<td>${payList.pay_price}</td>
					<td>${payList.bubble}</td>
					<td>카카오페이</td>
				
				</tr>
				
				</c:forEach>
				
				
				</table>

				<input type='button' value='주문내역'onclick='location.href="/user/process"' /> 
				<input type='button' value='메인페이지'onclick='location.href="/"' /> 


</div>

</body>
</html>