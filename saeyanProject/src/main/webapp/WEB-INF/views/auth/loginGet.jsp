<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>사용자 로그인</title>

<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body class="bg-gradient-primary">

	<div class="container">

		<!-- Outer Row -->
		<div class="row justify-content-center">

			<div class="col-xl-10 col-lg-12 col-md-9">

				<div class="card o-hidden border-0 shadow-lg my-5">
					<div class="card-body p-0">
						<!-- Nested Row within Card Body -->
						<div class="row">
							<div class="col-lg-6 d-none d-lg-block"><img src="img/11.png" alt=""></div>
							<div class="col-lg-6">
								<div class="p-5">
									<div class="text-center">
										<h1 class="h4 text-gray-900 mb-4">새얀 방문을 환영합니다.!</h1>
									</div>
									<form action="/auth/login" method="post">
										<div class="form-group">
											<input type="text" name="id" class="form-control form-control-user"
												id="exampleInputEmail" aria-describedby="emailHelp"
												placeholder="아이디를 입력하세요">
										</div>
										<div class="form-group">
											<input type="password" name="pwd" class="form-control form-control-user"
												id="exampleInputPassword" placeholder="비밀번호를 입력하세요">
										</div>
										
										<c:if test="${msg==false }">
											<p style="color:#f00;">로그인에 실패했습니다. 아이디 또는 비밀번호를 다시 입력해주세요</p>
										</c:if>
										<c:if test="${deleted==false }">
											<p style="color:#f00;">이미 탈퇴한 계정입니다. 새로운 아이디로 회원가입 해주시기 바랍니다.</p>
										</c:if>
										<input type="submit" value="로그인"
											class="btn btn-primary btn-user btn-block">
										<hr>
										<a href="index.html" class="btn btn-google btn-user btn-block">
											<i class="fab fa-google fa-fw"></i> Login with Google
										</a> <a href="index.html"
											class="btn btn-facebook btn-user btn-block"> <i
											class="fab fa-facebook-f fa-fw"></i> Login with Facebook
										</a>
									</form>
									<hr>
									<div class="text-center">
										<a class="small" href="/auth/findId">아이디 찾기</a>&nbsp;&nbsp;&nbsp;<a class="small" href="/auth/findPwd">비밀번호 찾기</a>
										&nbsp;&nbsp;&nbsp;<a class="small" href="/auth/registration">회원가입</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>

		</div>

	</div>

	<!-- Bootstrap core JavaScript-->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="js/sb-admin-2.min.js"></script>

</body>

</html>