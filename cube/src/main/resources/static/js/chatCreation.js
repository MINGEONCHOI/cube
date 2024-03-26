

let chatCreationObject = {

	init: function() {
		let _this = this;

		$("#btn-chatCreation").on("click", () => {
			_this.chatCreation();
		});

	},

	chatCreation: function() {
      alert("채팅방 생성 요청")
      let chatRoomCreator= $("#chatRoomCreator").val()
      let chatCreation = {
			chatRoomName: $("#chatRoomName").val(),
			
	  }
		
		

		$.ajax({
			type: "POST",
			url: "/chat_creation/"+chatRoomCreator,
			data: JSON.stringify(chatCreation),
			contentType: "application/json; charset=utf-8"
		}).done(function(response) {
			console.log(response);
			alert("채팅방 생성  완료")
			location = "/chat_roomlistPage";
			
		}).fail(function(error) {
			console.error(error);
			alert("채팅방 생성 실패")
		});
	},
}
chatCreationObject.init();