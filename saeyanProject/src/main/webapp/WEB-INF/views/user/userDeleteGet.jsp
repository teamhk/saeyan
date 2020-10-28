<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.hk.saeyan.dto.Members" %>
<%
	Members user = (Members) request.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<title>회원 탈회 확인</title>
</head>
<body>
<h1>회원 탈퇴 확인</h1>
정말로 탈퇴 하시겠습니까?<br>
탈퇴를 원하신다면 비밀번호를 입력해주세요<br>
	<form action='delet' name='storeform' method='post' id='storeform'>
		ID :<input type='text' id='id' name='id' value="${loginMember.id }" readonly><br>  <!--${loginMember.name }-->
		비밀번호 :<input id='pwdcheck' type='password' value="">&nbsp;&nbsp;<span id="result1"></span><br>
		이름 :<input type='text' name='name' value="${user.name}"><br>
		탈퇴 사유: <select id="reason" name="reason">
					<option value="" selected>-탈퇴사유를 선택 해주세요-</option>
					<option value="사이트 이용">사이트 이용이 불편함</option>
					<option value="가격 불만족">세탁 가격이 비쌈</option>
					<option value="세탁 불만족">세탁 결과 불만족</option>
					<option value="세탁 진행">세탁 진행이 오래걸림</option>
					<option value="기타">기타 사유</option>
				</select>
		<button type="button" id='btn' disabled onclick="abcd();">삭제</button>
	</form>
<script>
$().ready(function() {
	$("#pwdcheck").change(function() {
		pwdch = document.getElementById('pwdcheck').value;
		if(pwdch===("<%=user.getPwd()%>")){
			$("#result1").text("비밀번호가 일치합니다.");
			$('#btn').prop('disabled',false);
		} else {
			$("#result1").text("비밀번호가 일치 하지 않습니다.");
			$('#btn').prop('disabled',true);
		}
	});
});
function abcd(){
	if($('#reason').val() == ''){
		console.log("이유1", $("#reason").val());
		document.getElementById('reason').focus();
	} else {
		console.log("이유2", $("#reason").val());
		document.storeform.submit();
	}
}

</script>
</body>
</html>