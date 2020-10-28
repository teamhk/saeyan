<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.hk.saeyan.dto.Members" %>
<%@ page import="com.hk.saeyan.dto.PersonalPay" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%  
	Members user = (Members) request.getAttribute("user");
%>
<%  
	PersonalPay pay = (PersonalPay) request.getAttribute("pay");
%>
<%-- <% int ret = (int) request.getAttribute("ret"); %> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카드정보 수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
//카드 번호 정규식 
var cardNumR = /([0-9]{12})/;
//카드 유효기간 무조건 2자리 넣게 하는 정규식
var expR = /[0-9]{2}/;

$(document).on("click", "#deleteBtn", function(){
	var id = $("#id").val();
	$.ajax({
		data:{id:id},
		method: "post",
		dataType: "json",
		url: "/auth1/cardDelete",
		success:function(data){
			if(data==0){
				alert("등록된 카드정보가 삭제되었습니다.");
				window.location.reload();
			}
		},
		error:function(error){
			alert("에러 발생!!!");
		}
	});
});

$(document).ready(function(){
	$('#cardNum').focus(function(){
		checkCardNum();
	});
	$("#expMM").focus(function(){
		checkMM();
	});

	console.log("카드번호는", $("#cardNum").val() == null);
	if($("#cardNum").val() == '') {
		$("#deleteBtn").attr('disabled', true);
	} else  {
		$("#deleteBtn").attr('disabled', false);
	}
});
function checkCardNum(){
	if($('#cardNum').val() == ''){
		$('#cardNum_check').text('카드번호를 입력해주세요');
		$('#cardNum_check').css('color', 'red');
	} else if(cardNumR.test($('#cardNum').val()) != true) {
		$('#cardNum_check').text('숫자만 입력해주세요(공백 사용 불가)');
		$('#cardNum_check').css('color', 'red');
	} else {
		$('#cardNum_check').text('✔' );
		$('#cardNum_check').css('color', 'black');
		console.log($("#cardNum").val());
	}
}

function checkMM(){
	if($("#expMM").val() == ''){
		$('#cardExp_check').text('유효기간 월 을 입력해주세요');
		$('#cardExp_check').css('color', 'red');
	} else if (expR.test($("#expMM").val()) != true) {
		$('#cardExp_check').text('MM형식에 맞게 입력 해주세요(ex.3월->03)');
		$('#cardExp_check').css('color', 'red');
	} else {
		$('#cardExp_check').text('✔' );
		$('#cardExp_check').css('color', 'black');
	}
}


// if(${ret}==1){
// 	alert("등록된 카드정보가 삭제되었습니다.")
// }
</script>
</head>
<body>
	<h3>카드정보 수정</h3>
		<p>*카드 등록은 하나만 가능합니다.<br>카드 정보를 변경하실 경우 기존 등록된 카드 정보는 삭제된 후 새로 등록됩니다.</p><br>
	<form action="payUpdate" name="selectUserPay" id="selectUserPay" method="post">
	<input type="hidden" name="cardCheck" value="Y">
	<label><b>아이디</b></label>
		<input type="text" name="id" id="id" value="${loginMember.id }" readOnly><br>
	<label><b>카드회사</b></label>
	<select id="cardCom" name="cardCom" form="selectUserPay">
		<option value="KB카드">KB국민카드</option>
		<option value="신한카드">신한카드</option>
		<option value="하나카드">하나카드</option>
		<option value="롯데카드">롯데카드</option>
		<option value="BC카드">BC카드</option>
		<option value="농협카드">NH농협카드</option>
		<option value="삼성카드">삼성카드</option>
		<option value="현대카드">현대카드</option>
	</select><br>
<%-- 		<input type='text' name='cardCom' value="${pay.cardCom }" readOnly><br> --%>
	<label><b>카드번호</b></label>
		<input type='text' id="cardNum" name='cardNum' maxlength="12" value="${pay.cardNum }" oninput="checkCardNum()">
		<div class="validation" id="cardNum_check"></div>
	<label><b>유효기간</b></label>
		<input type="hidden" id="cardExp" name="cardExp" value="${pay.cardExp }"><br>
		<label><b>월</b></label>
			<input type="text" id="expMM" maxlength="2" size="20" oninput="checkMM()">
		<label><b>년</b></label>
			<input type="text" id="expYY" maxlength="2" size="20"><br>
			<div class="validation" id="cardExp_check"></div>
	<label><b>CVC</b></label>
		<input type="text" name="cardCvc" value="${pay.cardCvc }"><br>
	<button type="button" id="deleteBtn" onclick="" >삭제</button>	
	<button type='button' id="btn" onclick="submitCheck()">등록</button>
	<input type="button" onclick="location.href='/'" value="메인페이지">
	</form>
<script>


//--------셀렉트값을 디비에서 가져와서 표현
var str1 = "${pay.cardCom}";
console.log(str1);
$("#cardCom").val(str1);

	var str = $("#cardExp").val();
	console.log("str", str);
	var expMM = str.substr(0, 2);
	console.log("expMM:", expMM);
	$("#expMM").val(expMM);
	var expYY = str.substr(2,2);
	$("#expYY").val(expYY);

	function submitCheck(){
		var str = ($("#expMM").val()+$("#expYY").val());
		$("#cardExp").val(str);
		console.log($("#cardExp").val());
		if(expR.test($("#expMM").val()) != true){
			document.getElementById('expMM').focus();
			//$("#btn").prop('disabled', false);
		} else {
			//$("#btn").prop('disabled', true);
			document.selectUserPay.submit();
		}
	}

</script>
</body>
</html>