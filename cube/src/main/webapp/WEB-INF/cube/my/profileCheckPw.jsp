<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="/webjars/jquery/3.6.0/dist/jquery.min.js"></script>

</head>
<body>
<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
	<h1>마이페이지</h1>	
	
	<div class="form-group">
		<label for="userPw" class="label">비밀번호</label>
		<input type="password" id="userPw" class="input" required>
		<button id="btn-checkPw" type="submit">확인</button>
	</div>
<script src="/js/my.js"></script>
</body>
</html>