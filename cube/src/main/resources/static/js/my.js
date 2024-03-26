let my = {
	init: function() {
		let _this = this;
		$("#btn-checkPw").on("click", ()=>{
			_this.checkPw();
		});
		$("#btn-uploadFile").on("click", ()=>{
			_this.uploadFile();
		});
		$("#btn-updateProfile").on("click", ()=>{
			_this.updateProfile();
		});
		
	},
	
	checkPw: function() {
		alert("비밀번호 확인 요청됨");
		let user = {
			userPw: $("#userPw").val()
		}
		
		$.ajax({
			type: "POST",
			url: "/my_profileCheckPw",
			data: JSON.stringify(user),
			contentType: "application/json; charset=utf-8"
		}).done(function(response){
			console.log(response);
			if(response.status === 200) {
				location = "/my_profile";				
			}
		}).fail(function(error){
			console.log(error);
			alert("에러 발생: " + error);
		});
	},
	
	uploadFile: function() {
		alert("사진 등록 요청됨");
		var userId = $("#userId").val();
		
		//input file 엘리먼트에 접근하여 파일 객체 가져오기
		var fileInput = document.getElementById('fileInput');
		var file = fileInput.files[0];
		
		if(file) {
			//FormData = new FormData();
			var formData = new FormData();
			formData.append('file', file);	
			
			//AJAX 요청 시 data 속성을 FormData로 설정
			$.ajax({
				type: "POST",
				url: "/my_uploadFile/" + userId,
				data: formData,
				//필수: processData와 contentType을 false로 설정하여 FormData 전송
				processData: false,
				contentType: false
			}).done(function(response){
				console.log(response);
				if(response.status === 200) {
					location = "/my_updateProfile";				
				}
			}).fail(function(error){
				console.log(error);
				alert("에러 발생: " + error);
			});
		} else {
			console.error('선택된 파일이 없습니다.');
		}
		
	},
	
	updateProfile: function() {
		alert("프로필 수정 요청됨");
		let user = {
			userId: $("#userId").val(),
			userZipCode: $("#userZipCode").val(),
			userAddr: $("#userAddr").val(),
			userAddrDetail: $("#userAddrDetail").val(),
			userMobile: $("#userMobile").val(),
			userEmailEx: $("#userEmailEx").val()
		}
		
		//userAddrDetailError 값 가져오기
		var userAddrDetailErrorVal = document.getElementById("userAddrDetailError").innerHTML;
		//조건 확인
		if (userAddrDetailErrorVal.trim() === "상세주소를 입력해주세요.") {
		    //idStatus 값이 "상세주소를 입력해주세요."일 때 수행할 동작
		    alert("상세주소를 입력해주세요.");
		    return;
		}
		//mobileStatus 값 가져오기
		var mobileStatusVal = document.getElementById("mobileStatus").innerHTML;
		//조건 확인
		if (mobileStatusVal.trim() === "휴대전화번호 중복확인 필요") {
		    //idStatus 값이 "휴대전화번호 중복확인 필요"일 때 수행할 동작
		    alert("휴대전화번호 중복확인이 필요합니다.");
		    return;
		}
		//emailExStatus 값 가져오기
		var emailExStatusVal = document.getElementById("emailExStatus").innerHTML;
		//조건 확인
		if (emailExStatusVal.trim() === "외부 이메일 중복확인 필요") {
		    //emailExStatus 값이 "외부 이메일 중복확인 필요"일 때 수행할 동작
		    alert("외부 이메일 중복확인이 필요합니다.");
		    return;
		}
		
		$.ajax({
			type: "POST",
			url: "/my_updateProfile",
			data: JSON.stringify(user),
			contentType: "application/json; charset=utf-8"
		}).done(function(response){
			console.log(response);
			if(response.status === 200) {
				location = "/my_profile";				
			}
		}).fail(function(error){
			console.log(error);
			alert("에러 발생: " + error);
		});
	},
	
	
}
my.init();	