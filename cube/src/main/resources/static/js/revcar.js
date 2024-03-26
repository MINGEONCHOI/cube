let revCarObject = {
	init: function() {
		let _this = this;

		$("#btn-insert").on("click", () => {
			_this.insertCar();
		});

		$("#btn-update").on("click", () => {
			_this.updateCar();
		});

		$(".btn-delete").on("click", function() {
			let creId = $(this).closest("tr").find(".creId").val();
			_this.deleteCar(creId);
		});

		$("#creNum").change(function() {
			selectedValue = $(this).val();
		});

	},
	
	insertCar: function(){
		let creStart = $("#creStart").val();
		let creEnd = $("#creEnd").val();
		let creCount = $("#creCount").val();
		let creNum = selectedValue;
		let creDate = $("#creDate").val();
		
		// 시작 시간과 종료 시간을 JavaScript Date 객체로 변환
		let startTime = new Date("2022-01-01 " + creStart);
		let endTime = new Date("2022-01-01 " + creEnd);

		// 시작 시간이 종료 시간보다 이후인지 확인
		if (startTime >= endTime) {
			alert("시작 시간은 종료 시간보다 이전이어야 합니다.");
			return; // 예약 등록 중단
		}
		
		let reservation = {
			creStart: creStart,
			creEnd: creEnd,
			creCount: creCount,
			creDate: creDate
		}
		
		$.ajax({
			type: "POST", // 수정된 부분
			url: "/insertCar/" + creNum,
			data: JSON.stringify(reservation),
			contentType: "application/json; charset=utf-8"
		}).done(function(response){
			if(response.status === 400){
				alert("선택한 시간대에 이미 예약이 있습니다.");
			}else {
				alert("예약완료!");
				console.log(response);
				location = "/reservationPage";
			}
		}).fail(function(error){ // 수정된 부분
			alert(creNum);
			alert("예약실패:" + error);
		});
	},
	
	// updateCar 메서드 내부 수정 부분
	updateCar: function() {
		// 예약 ID를 가져옴
		let creId = $("#creId").val();
		if(!creId){
			alert("예약 ID가 없다.");
		}
		let creDate = $("#creDate").val(); // 수정된 부분
		let creStart = $("#creStart").val(); // 시작 시간을 선택한 값 그대로 가져옴
		let creEnd = $("#creEnd").val();

		// 시작 시간과 종료 시간을 JavaScript Date 객체로 변환
		let startTime = new Date("2022-01-01 " + creStart);
		let endTime = new Date("2022-01-01 " + creEnd);

		// 시작 시간이 종료 시간보다 이후인지 확인
		if (startTime >= endTime) {
			alert("시작 시간은 종료 시간보다 이전이어야 합니다.");
			return; // 예약 등록 중단
		}


		let creNum = selectedValue;		
		let reservation = {
			creId: creId, // 예약 ID 설정
			creStart: creStart, // 시작 시간
			creEnd: creEnd,
			creDate: creDate
		}

		// 예약 요청 보내기
		$.ajax({
			type: "POST",
			url: "/updateCar/" + creNum,
			data: JSON.stringify(reservation),
			contentType: "application/json; charset=utf-8"
		}).done(function(response) {
			if (response.status === 400) {
				alert("선택한 시간대에 이미 예약이 있습니다.");
			} else {
				alert("변경완료!");
				console.log(response);
				location = "/reservationPage";
			}
		}).fail(function(error) {
			alert("예약 실패: " + error);
			alert(creId);
		});
	},
	
	deleteCar: function(creId){
		
		$.ajax({
			type: "DELETE",
			url: "/deleteCar/" + creId
		}).done(function(response){
			alert("예약취소!");
			console.log(response);
			location = "/reservationPage";
		});
	},

};

revCarObject.init();
