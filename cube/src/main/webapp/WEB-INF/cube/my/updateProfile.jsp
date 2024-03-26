<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- 주소찾기api -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="/js/addressapi.js"></script>

<script src="/webjars/jquery/3.6.0/dist/jquery.min.js"></script>

</head>
<body>
<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
	<input type="hidden" id="userId" value="${user.userId }">
	<h1>마이페이지</h1>	
	<h3>내 정보</h3>	
	<div class="container">	
		<div class="underButton">
			<img src="${user.userFilePath }" style="width: auto; height: 100px;" >
		</div>
		<div class="underButton">
			<input type="file" id="fileInput" name="file" accept="image/*" />
			<br>
			<button id="btn-uploadFile">사진 등록하기</button>			
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

<!-- 주소 -->
	<div class="form-group1">
		<label class="label1">주소</label>
		<input class="input1_1" placeholder="우편번호" name="userZipCode" id="userZipCode" type="text" readonly="readonly" value="${user.userZipCode }">
		<button type="button" class="btn-findAddr" onclick="execPostCode();">
			<i class="fa fa-search"></i>주소찾기
		</button>
	</div>
	<div class="form-group2">
		<input class="input3" placeholder="도로명 주소" name="userAddr" id="userAddr" type="text" readonly="readonly" value="${user.userAddr }">
		<input class="input4" placeholder="상세 주소" name="userAddrDetail" id="userAddrDetail" type="text" value="${user.userAddrDetail }">
	</div>
	<small id="userAddrDetailError" class="text-danger"></small>
	<script>
		const userAddrDetailInput = document.getElementById('userAddrDetail');
		const userAddrDetailError = document.getElementById('userAddrDetailError');

		userAddrDetailInput.addEventListener('input', function(event) {
			// 정규표현식을 사용하여 휴대전화번호 유효성 검사
			const userAddrDetailRegex = /^\S.*$/; // 1글자 이상, 공백 허용, 공백만 입력은 불가

			if (!userAddrDetailRegex.test(userAddrDetailInput.value)) {
				userAddrDetailError.textContent = '상세주소를 입력해주세요.';
			} else {
				userAddrDetailError.textContent = ''; // 에러 메시지 초기화
			}
		});
	</script>
<!-- 휴대전화번호 -->
	<div class="form-group1">
		<label for="userMobile" class="label1">휴대전화번호</label>
		<input type="text" id="userMobile" class="input1" required value="${user.userMobile }">
		<button id="btn-checkMobile" class="btn-checkId">중복확인</button>
	</div>
	<label id="mobileStatus" style="color: red; margin-left: 110px; font-size: 12px;"></label>
	<!-- 에러 메시지를 표시할 small 요소 -->
	<small id="userMobileError" class="text-danger"></small>
	<script>
		const userMobileInput = document.getElementById('userMobile');
		const userMobileError = document.getElementById('userMobileError');

		userMobileInput.addEventListener('input', function(event) {
			// 정규표현식을 사용하여 휴대전화번호 유효성 검사
			const userMobileRegex = /^\d{11}$/; //11자리 숫자

			if (!userMobileRegex.test(userMobileInput.value)) {
				mobileStatus.textContent = '휴대전화번호 중복확인 필요';
				userMobileError.textContent = '휴대전화번호 11자리를 입력해주세요.';
			} else {
				userMobileError.textContent = ''; // 에러 메시지 초기화
			}
		});
	</script>
<!-- 외부 이메일 -->
				<div class="form-group1">
					<label for="userEmailEx" class="label1">외부 이메일</label>
					<input type="email" id="userEmailEx" class="input1" required value="${user.userEmailEx }">
					<button id="btn-checkEmailEx" class="btn-checkId">중복확인</button>
				</div>
				<label id="emailExStatus" style="color: red; margin-left: 110px; font-size: 12px;"></label>
				<small id="userEmailExError" class="text-danger"></small>
				<script>
					const userEmailExInput = document.getElementById('userEmailEx');
					const userEmailExError = document.getElementById('userEmailExError');

					userEmailExInput.addEventListener('input', function(event) {
						//정규표현식을 사용하여 이메일 유효성 검사
						const userEmailExRegex = /^\S+@\S+\.\S+$/;

						if (!userEmailExInput.checkValidity()) {
							emailExStatus.textContent = '외부 이메일 중복확인 필요';
							userEmailExError.textContent = '이메일 형식으로 입력해주세요.';
						} else {
							userEmailExError.textContent = '';
						}
					});
				</script>
	<div><br></div>
	<div style="width: 50%;">
		<button id="btn-updateProfile" class="btn-signUp">수정하기</button>
	</div>	

</div>
<script src="/js/certification.js"></script>
<script src="/js/my.js"></script>
</body>
</html>