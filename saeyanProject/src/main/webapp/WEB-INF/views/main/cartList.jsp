<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.hk.saeyan.dto.Cart"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	Cart user = (Cart) request.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.js"
	integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
	crossorigin="anonymous"></script>
</head>
<body>
	<script type="text/javascript">
        function itemSum(){
 			console.log("시작");
           var sum = 0;
           var count = $(".chkbox").length;
           var seq= $('input[name="cart_seq"]');
           console.log(seq);
           console.log(count);
           for(var i=0; i < count; i++ ){
               if( $(".chkbox")[i].checked == true ){
                sum += Number($(".chkbox").eq(i).val());
               }
           }
           console.log(sum);
           $("#total_sum").val(sum);
  
           
        }

        $(function(){
            $("#order").click(function () {
                if( $("#total_sum").val()==0){
					alert("품목을 선택해주세요");
				} else {              
                var ok= confirm("결제 하시겠습니까?");
                if(ok){
                	 var count = $(".chkbox").length;
                     var seq= $('input[name="cart_seq"]');
                     for(var i=0; i < count; i++ ){
                         if( $(".chkbox")[i].checked == true ){	
                        	 var seq_val = seq.eq(i).val();
                             seq.eq(i).prop("value",seq_val+"Y");
                             console.log(seq.eq(i).val());
                         } else {
                        	 var seq_val = seq.eq(i).val();
                             seq.eq(i).prop("value",seq_val+"N");
                             console.log(seq.eq(i).val());
                         }
                     }
					$("#cartform").submit();
                }
                else{
                	return false;
                    }
                }
            });
		});

       
</script>
<h3>장바구니</h3>
<%-- <c:choose> --%>
<%-- <c:when test ="${user.items eq null}">장바구니가 비어있습니다.</c:when> --%>
<%-- <c:otherwise> --%>
 
	<form id="cartform" method="post" action="cart">
		<div class="container">
			
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
					<th>checkbox</th>
					<th>세탁소</th>
					<th>품목</th>
					<th>가격</th>
				</tr>

				<c:forEach var="cart" items="${cartList}">
					<tr>
						<!--                 	 <td><input type="checkbox" name="choice" checked="checked"></td> -->
						<td class="product-close"><input type="checkbox"
							name="chkbox" onClick="itemSum()" class="chkbox" id="id"
							value="${cart.pay_cart}" /></td>
						<td>${cart.sname}</td>
						<c:set var="itemStr" value="${cart.items}" />
						<c:set var="itemStr" value="${fn:replace(itemStr, '!@#', ':')}" />
						<c:set var="itemStr" value="${fn:replace(itemStr, '$%^', ',')}" />
						<c:set var="itemStr"
							value="${fn:substring(itemStr, 0, fn:length(itemStr)-1)}" />
						<td class='item'>${itemStr}</td>
						<td>${cart.pay_cart}</td>
						<td><input type="button" value="삭제" onclick="location.href='delete?cart_seq=${cart.cart_seq}'">
					</tr>
					<input type="hidden" name="cart_seq" value="${cart.cart_seq}" />
				</c:forEach>
			</table>
<!-- 			<script> -->
<!-- //        $(".chkbox").click(function(){ -->
<!-- //         $("#allCheck").prop("checked", false); -->
<!-- //       }); -->
<!--      </script> -->
			<input type="text" class="total-cart-p" id="total_sum"name="pay_cart" /> 
			<input type='button' value='계속빨래하기' onclick='location.href="/stores/map"' /> 
			<input type='button' id='order' value='구매하기' />
		</div>
	</form>

	<script>
        //들오오자마자 체크박스에 체크해주기
        var ck = "${cart}";
        if (ck == 'false') {
            $("#allCheck").prop("checked", false);
        } else {
            $("#allCheck").prop("checked", true);
            $(".chkbox").prop("checked", true);
            itemSum();
        }

    </script>
</body>
</body>
</html>