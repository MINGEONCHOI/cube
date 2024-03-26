let hr = {
	init: function() {
		let _this = this;
		$("#btn-search").on("click", ()=>{
			_this.search();
		});
		$("#btn-updateEmployee").on("click", function() {
            let userId = $(this).data("user-id");  //버튼의 data-user-id 속성을 사용할 때는 JavaScript에서는 data("user-id")로 읽고, data-userId 속성을 사용할 때는 data("userid")로 읽어야 합니다. 각 속성 이름의 대소문자를 주의
            _this.updateEmployee(userId);
        });		
	},
	search: function() {
		alert("검색 요청됨");
		let searchType = $("#searchType").val()
		let searchInput = $("#searchInput").val()
		alert(searchType);
		alert(searchInput);
		$.ajax({
			type: "GET",
			url: "/hr_searchEmployee/" + searchType + "/" + searchInput,
		}).done(function(response){
			console.log(response);
			location = "/hr_searchEmployee/" + searchType + "/" + searchInput;
		}).fail(function(error){
			console.log(error);
			alert("에러 발생: " + error);
		});
	},
	
	updateEmployee: function(userId) {
		alert("임직원 정보 수정 요청됨");
		let user = {
			userId: userId,
			userPosition: $("#userPosition").val(),
			userStatus: $("#userStatus").val()
		}
		alert(user.userId);
		alert(user.userPosition);
		alert(user.userStatus);
		$.ajax({
			type: "POST",
			url: "/hr_updateEmployee/" + $("#teamId").val(),
			data: JSON.stringify(user),
			contentType: "application/json; charset=utf-8"
		}).done(function(response){
			console.log(response);
			let message = response["data"];
			alert(message);
			if(response.status === 200) {
				location = "/hr_employeePage";
			}
		}).fail(function(error){
			console.log(error);
			alert("에러 발생: " + error);
		});
	},
}
hr.init();	