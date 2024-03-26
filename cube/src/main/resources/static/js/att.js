$(document).ready(function() {
	
	$('#save').click(function() {
		save();
	});
	$('#ot_insert').click(function() {
		otInsert();
	});

	$('#ot_end').click(function() {
		otEnd();
	});
	
	$('#insertVa').click(function() {
		insertVa();
	});

	function save() {
		var data = [];

		$('tbody #attTr').each(function() {
			var apId = $(this).find('#apId').val();
			var apDate = $(this).find('td:eq(0)').text();
			var apStart = $(this).find('.attStartTime').text();
			var apEnd = $(this).find('.attEndTime').text();
			var apType = $(this).find('#attApType').val();

			apStart = (apStart === '-') ? null : apStart;
			apEnd = (apEnd === '-') ? null : apEnd;

			data.push({
				apId: apId,
				apDate: apDate,
				apStart: apStart,
				apEnd: apEnd,
				apType: apType
			});
		});

		$.ajax({
			type: 'POST',
			url: '/attplanUpdate',
			contentType: 'application/json;charset=UTF-8',
			data: JSON.stringify(data),
			success: function(response) {
				alert('데이터가 성공적으로 저장되었습니다.');
				location = "/attplan_InsertPage";
			},
			error: function(error) {
				alert('데이터 저장 중 오류가 발생했습니다.', error);
			}
		});
	}

	function otInsert() {
		let otDes = $('#otDes').val();
		var otDesValue = $("#otDes").val();
		        if (otDesValue.trim() === "") {
		            alert('초과근무 사유를 입력해주세요.');
		            return;
		        }
		$.ajax({
			type: 'POST',
			url: '/otInsert',
			contentType: 'application/json;charset=UTF-8',
			data: JSON.stringify(otDes),
		}).done(function(response) {
			let message = response["data"];
			alert(message);
			if (response.status === 200) {
				location = "/att_Ot_InsertPage";
			}
		}).fail(function(error) {
			console.log(error);
			alert('에러');
		});
	}

	function otEnd() {
		let att = {
			attOtStart : $('#otstart').val(),
			attOtEnd : $('#otend').val()
		}
		
		$.ajax({
			type: 'POST',
			url: '/otEnd',
			contentType: 'application/json;charset=UTF-8',
			data: JSON.stringify(att),
		}).done(function(response) {
			let message = response["data"];
			alert(message);
			location = "/att_Ot_InsertPage";
		}).fail(function(error) {
			console.log(error);
			alert('에러');
		});
	}
	
	function insertVa() {
		let va = {
			vaStartDate : $('#startDate').val(),
			vaEndDate : $('#endDate').val(),
			vaDes : $('#vaDes').val()
		}
		
		$.ajax({
			type: 'POST',
			url: '/insertVacation',
			contentType: 'application/json;charset=UTF-8',
			data: JSON.stringify(va),
		}).done(function(response) {
			alert("휴가 신청이 완료되었습니다.");
			location = "/att_Va_FindPage";
		}).fail(function(error) {
			console.log(error);
			alert('에러');
		});
	}
	

	$('#endDate').prop('disabled', true);
	$('#insertVa').prop('disabled', true);
    $('#startDate').change(function () {
        var startDate = new Date($('#startDate').val());
        $('#endDate').prop('disabled', false);
        $('#endDate').attr('min', startDate.toISOString().split('T')[0]);
    });
    
    $('#endDate').change(function () {
    var startDate = new Date($('#startDate').val());
    var endDate = new Date($('#endDate').val());
    $('#insertVa').prop('disabled', false);
    var day = calculateday(startDate, endDate);
    $('#calDate').text(day + '일');
    
    
});

function calculateday(startDate, endDate) {
    var days = Math.ceil((endDate - startDate) / (1000 * 60 * 60 * 24)) + 1;
    var weekdays = 0;
    for (var i = 0; i < days; i++) {
        var currentDate = new Date(startDate);
        currentDate.setDate(startDate.getDate() + i);
        if (currentDate.getDay() !== 0 && currentDate.getDay() !== 6) {
            weekdays++;
        }
    }
    return weekdays;
}
});
