<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
.calendarBody {
	background-color: #f5f5f5;
	color: #333;
}

.calendarText {
	text-align: center;
	height: 20px;
	padding: 10px 0 0 0;
	font-size: 7px;
}

.calendar {
	display: grid;
	grid-template-columns: repeat(7, 1fr);
	width: 210px;
	height: 180px;
	margin: 5px auto;
}

.day {
	text-align: center;
	padding: 2px 2px 0 0;
	background-color: #f5f5f5;
	border-top: 1px solid lightgrey;
	cursor: pointer;
	font-size: 4px;
}

.empty {
	background-color: transparent;
	border: none;
}

.current-month {
	color: black;
}

.current-day {
	background-color: #E93939;
	color: #fff;
}

.sunday .saturday{
	color: lightgrey;
}

</style>





<script>
        document.addEventListener('DOMContentLoaded', function() {
            const calendar = document.querySelector('.calendar');

            function createCalendar() {

                const today = new Date();

                const firstDayOfMonth = new Date(today.getFullYear(), today.getMonth(), 1);

                const lastDayOfMonth = new Date(today.getFullYear(), today.getMonth() + 1, 0);

                const startDayOfWeek = firstDayOfMonth.getDay();

                calendar.innerHTML = '';
                const daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
                for (let i = 0; i < daysOfWeek.length; i++) {
                    const dayOfWeek = document.createElement('div');
                    dayOfWeek.classList.add('day', 'current-month');
                    dayOfWeek.textContent = daysOfWeek[i];
                    calendar.appendChild(dayOfWeek);
                }
                for (let i = 0; i < startDayOfWeek; i++) {
                    const emptyDay = document.createElement('div');
                    emptyDay.classList.add('day', 'empty');
                    calendar.appendChild(emptyDay);
                }
                for (let i = 1; i <= lastDayOfMonth.getDate(); i++) {
                    const day = document.createElement('div');
                    day.classList.add('day');
                    day.textContent = i;
                    if (today.getFullYear() === firstDayOfMonth.getFullYear()
                            && today.getMonth() === firstDayOfMonth.getMonth()
                            && i === today.getDate()) {
                        day.classList.add('current-day');
                    }
                    if ((startDayOfWeek + i - 1) % 7 === 0) {
                        day.classList.add('sunday');
                    } else if ((startDayOfWeek + i - 1) % 7 === 6) {
                        day.classList.add('saturday');
                    }

                    calendar.appendChild(day);
                }
                
            }
            createCalendar();
        });
    </script>
</head>
<body class="calendarBody">
	<div class="calendarText">
		<%= new SimpleDateFormat("yyyy년 MM월 dd일").format(new java.util.Date()) %>
	</div>
	<div class="calendar"></div>
</body>
</html>
