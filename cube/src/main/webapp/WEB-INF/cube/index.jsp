<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">

<style>
body {
	display: grid;
	grid-template-columns: 1fr 20fr;
	margin: 0;
}

</style>
<title>CUBE</title>
<script src="/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<link href="/css/sb-admin-2.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
</head>

<body id="page-top">


	<aside class="index_aside">
		<jsp:include page="${asidePage}" />
	</aside>




	<main class="index_main">
		<jsp:include page="${mainPage}" />
	</main>



	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>



	<!-- Bootstrap core JavaScript-->
	<script src="/js/templet/jquery.min.js"></script>
	<script src="/js/templet/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="js/templet/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="/js/templet/sb-admin-2.min.js"></script>

</body>

</html>