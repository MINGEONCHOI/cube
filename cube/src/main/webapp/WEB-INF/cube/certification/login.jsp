<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<style>
.bg-image-a {
    background-image: url('/image/20231224_114510.jpg');
    background-size: cover; /* 이미지를 화면에 맞게 조절 */
    background-position: center; /* 이미지를 중앙에 정렬 */
}
</style>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

	<!-- Custom styles for this template-->
	<link href="css/sb-admin-2.min.css" rel="stylesheet">
	
	<!-- jquery -->
	<script src="/webjars/jquery/3.6.0/dist/jquery.min.js"></script>

<title>CUBE : 로그인</title>
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
<div class="col-lg-6 d-none d-lg-block bg-image-a"></div>
<div class="col-lg-6">
<div class="p-5">
    <div class="text-center">
        <h1 class="h4 text-gray-900 mb-4">오늘도 일해라 노예들아</h1>
    </div>
                                    
	<div class="form-group">
	    <input type="text" class="form-control form-control-user" id="userId" aria-describedby="emailHelp" placeholder="아이디를 입력하세요">
	</div>
	<div class="form-group">
	    <input type="password" class="form-control form-control-user" id="userPw" placeholder="비밀번호를 입력하세요">
	</div>

	<button id="btn-login" class="btn btn-primary btn-user btn-block">로그인</button>
	<hr>
	<div class="text-center">
	    <a class="small" href="/findIdPw">아이디 | 비밀번호 찾기</a>
	</div>
	<div class="text-center">
	    <a class="small" href="/signUp">회원가입</a>
	</div>
	<div class="text-center">
		<a class="small" href="#">문의하기</a>
	</div>
</div>
</div>
</div>
</div>
</div>
</div>	
</div>
</div>

<script src="/js/certification.js"></script>

<!-- Bootstrap core JavaScript-->
<script src="/js/templet/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="/js/templet/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="/js/templet/sb-admin-2.min.js"></script>
    
</body>
</html>