

let mailSendObject = {

	init: function() {
		let _this = this;

		$("#btn-mailSend").on("click", () => {
			_this.mailSend();
		});

	},

	mailSend: function() {
      alert("메일 보내기 요청")
      
      let SendMail = {
			sendMailSenderEmail: $("#mailSenderEmail").val(),
			sendMailReceiverEmail: $("#mailReceiverEmail").val(),
			sendMailTitle: $("#mailTitle").val(),
			sendMailContent: $("#mailContent").val(),
			sendMailReservationDate: $("#sendMailReservationDate").val()
	  }
		
		

		$.ajax({
			type: "POST",
			url: "/mail_send",
			data: JSON.stringify(SendMail),
			contentType: "application/json; charset=utf-8"
		}).done(function(response) {
			console.log(response);
			alert("메일 보내기 완료")
			location = "/mailPage";
			
		}).fail(function(error) {
			console.error(error);
			alert("메일 보내기 실패")
		});
	},
}
mailSendObject.init();