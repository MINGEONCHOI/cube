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
	<h3>내 정보</h3>	
<div class="container">	
	<div class="underButton">
		<img src="${user.userFilePath }" style="width: auto; height: 100px;" >
	</div>
	<div class="underButton">
		<h3>${user.userTeamId.teamName }팀 ${user.userName} ${user.userPosition }</h3>
	</div>
		
	<div class="form-group1">
		<label for="userNum" class="label1">사번</label>
		<input type="text" id="userNum" class="input" readOnly=readOnly value="${user.userNum }">
	</div>
	<div class="form-group1">
		<label for="userEmail" class="label1">이메일</label>
		<input type="email" id="userEmail" class="input" readOnly=readOnly value="${user.userEmail }">
	</div>
	<div class="form-group1">
		<label class="label1">우편번호</label>
		<input class="input"
			placeholder="우편번호" name="userZipCode" id="userZipCode" type="text" readonly="readonly" value="${user.userZipCode }">
		<!-- <button type="button" class="btn-findAddr" onclick="execPostCode();">
			<i class="fa fa-search"></i>주소찾기
		</button> -->
	</div>
	<div class="form-group1">
		<label class="label1">주소</label>
		<input class="input" placeholder="도로명 주소" name="userAddr" id="userAddr" type="text" readonly="readonly" value="${user.userAddr }">
	</div>
	<div class="form-group1">
		<label class="label1">상세주소</label>	
		<input class="input" placeholder="상세 주소" name="userAddrDetail" id="userAddrDetail" type="text" readonly="readonly" value="${user.userAddrDetail }">
	</div>
	<div class="form-group1">
		<label for="userMobile" class="label1">휴대전화번호</label>
		<input type="text" id="userMobile" class="input" readOnly=readOnly value="${user.userMobile }">
	</div>
	<div class="form-group1">
		<label for="userEmailEx" class="label1">외부 이메일</label>
		<input type="email" id="userEmailEx" class="input" readOnly=readOnly value="${user.userEmailEx }">
	</div>
	
	<div><br></div>
			
	<div style="width: 50%;">
		<a href="/my_updateProfile" class="btn-login">내 정보 수정하기</a>
	</div>	

</div>
<script src="/js/my.js"></script>
</body>
</html>