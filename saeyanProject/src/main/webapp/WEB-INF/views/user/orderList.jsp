<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ page import="com.hk.saeyan.dto.OrderList"%>
<%@ page import="java.util.List"%>
<%
List<OrderList> user = (List<OrderList>) request.getAttribute("order");
%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
</head>
<body>
<c:choose>
<c:when test = "${user.orderNum ==0}">주문내역이 없습니다.</c:when>
<c:otherwise>
<c:forEach var="order" items="${order}">
	<c:out value="${order.snum }"/>
   <a href='processOne?orderNum=<c:out value="${order.orderNum }"/>'>${order. orderNum}</a>
		<br>
	</c:forEach>
	</c:otherwise>
	</c:choose>
<script>

window.onload = function(){	
	var abc = document.getElementById('abc');
	$(".tdn").mouseover(function(){  //마우스가 올라왔을때 색깔 빨간색으로
		$(this).css("color","red");
	});

	$(".tdn").mouseout(function(){  //마우스가 벗어났을때 색깔 검은색으로
		$(this).css("color","black");
	});
	
	$(".tdn").click(function(){ //클릭됬을때 get방식으로 페이지 이동
		console.log(this.innerText);
		console.log($(this).html());
		var url = "${url}"+"One?=order"+$(this).html();
		console.log(url);
		window.location.href=url;
	});
}
</script>
</body>
</html>