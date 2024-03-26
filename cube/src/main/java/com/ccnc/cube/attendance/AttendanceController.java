package com.ccnc.cube.attendance;

import java.time.DayOfWeek;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ccnc.cube.common.CommonEnum.AIsWeekend;
import com.ccnc.cube.common.CommonEnum.AType;
import com.ccnc.cube.common.CommonEnum.ApIsWeekend;
import com.ccnc.cube.common.CommonEnum.ApStatus;
import com.ccnc.cube.common.CommonEnum.ApType;
import com.ccnc.cube.common.ResponseDTO;
import com.ccnc.cube.common.TeamService;
import com.ccnc.cube.user.UserService;
import com.ccnc.cube.user.Users;

import jakarta.servlet.http.HttpSession;

@Controller
public class AttendanceController {

	@Autowired
	private AttendanceService attendanceService;

	@Autowired
	private AttendanceplanService attendanceplanService;

	@Autowired
	private TeamService teamService;

	@Autowired
	private UserService userService;
	
	@Autowired
	private VacationService vacationService;

	@GetMapping("/attendancePage") // 근태 메인페이지
	public String attendance(Model model, HttpSession session) {
		Users user = (Users) session.getAttribute("login_user");
		calVacation(user);
		calRemainingVacation(user);
		List<Attendance> attList = attendanceService.attList(user);
		model.addAttribute("attList", attList);
		model.addAttribute("user", user);
		model.addAttribute("asidePage", "./attendance/att_aside.jsp");
		model.addAttribute("mainPage", "./attendance/att_find.jsp");
		return "index";
	}

	@GetMapping("/att_FindPage") // 근태 조회
	public String attendanceFind(Model model, HttpSession session) {
		Users user = (Users) session.getAttribute("login_user");
		List<Attendance> attList = attendanceService.attList(user);
		model.addAttribute("attList", attList);
		model.addAttribute("asidePage", "./attendance/att_aside.jsp");
		model.addAttribute("mainPage", "./attendance/att_find.jsp");
		return "index";
	}

	@GetMapping("/attplan_InsertPage") // 근태 계획 등록
	public String attendancePlanInsert(Model model, HttpSession session) {
		Users user = (Users) session.getAttribute("login_user");
		List<Attendanceplan> attplanList = new ArrayList<>();
		Double[] vacationArr = calRemainingVacation(user);
		int nextMonth = LocalDate.now().getMonthValue() + 1;
		if (attendanceplanService.findAttplanBydate(user,
				LocalDate.of(LocalDate.now().getYear(), nextMonth, 1)) == null) {
			generateAttplan(user);
			System.out.println("근태 계획 기본 생성");
		}
		;
		int dataSize = attendanceplanService.findAttPlan(user).size();
		for (int i = 0; i < dataSize; i++) {
			int month = attendanceplanService.findAttPlan(user).get(i).getApDate().getMonthValue();
			if (LocalDate.now().plusMonths(1).getMonthValue() == month
					&& attendanceplanService.findAttPlan(user).get(i).getApIsweekend().equals(ApIsWeekend.평일)) {
				attplanList.add(attendanceplanService.findAttPlan(user).get(i));
			}
		}
		model.addAttribute("vacationArr", vacationArr);
		model.addAttribute("attplanList", attplanList);
		model.addAttribute("asidePage", "./attendance/att_aside.jsp");
		model.addAttribute("mainPage", "./attendance/attplan_insert.jsp");
		return "index";
	}

	@PostMapping("/attplanUpdate") // 근태 업데이트
	public String attplanUpdate(@RequestBody List<Map<String, String>> attendanceList, Model model) {
		for (Map<String, String> attendance : attendanceList) {
			Attendanceplan att = attendanceplanService.getAttplan(Integer.parseInt(attendance.get("apId")));
			att.setApStart(attendance.get("apStart") == null ? null : LocalTime.parse(attendance.get("apStart")));
			att.setApEnd(attendance.get("apEnd") == null ? null : LocalTime.parse(attendance.get("apEnd")));
			att.setApType(ApType.valueOf(attendance.get("apType")));
			if (att.getApStatus() == ApStatus.미등록) {
				att.setApStatus(ApStatus.대기중);
			}
			attendanceplanService.saveAttPlan(att);
		}

		model.addAttribute("asidePage", "./attendance/att_aside.jsp");
		model.addAttribute("mainPage", "./attendance/attplan_insert.jsp");
		return "index";
	}

	public List<Attendanceplan> generateAttplan(Users user) {
		LocalDate nextMonth = LocalDate.now().plusMonths(1);
		List<Attendanceplan> attplanList = new ArrayList<>();
		for (int i = 1; i <= nextMonth.lengthOfMonth(); i++) {
			Attendanceplan attplan = new Attendanceplan();
			LocalDate date = LocalDate.of(nextMonth.getYear(), nextMonth.getMonth(), i);
			attplan.setUserId(user);
			attplan.setApDate(date);
			DayOfWeek week = date.getDayOfWeek();
			if (week == DayOfWeek.SATURDAY || week == DayOfWeek.SUNDAY) {
				attplan.setApIsweekend(ApIsWeekend.주말);
				attplan.setApType(null);
				attplan.setApStart(null);
				attplan.setApEnd(null);
			}
			attplanList.add(attplan);
			attendanceplanService.saveAttPlan(attplan);
		}
		return attplanList;
	}

	@GetMapping("/att_Ot_InsertPage") // 초과근무 신청
	public String attendanceOtInsert(Model model, HttpSession session) {
		Users user = (Users) session.getAttribute("login_user");
		Attendance findAtt = attendanceService.firstAtt(user, LocalDate.now());
		if (findAtt.getAttOtStart() != null && findAtt.getAttOtEnd() != null) {
			Duration duration = Duration.between(findAtt.getAttOtStart(), findAtt.getAttOtEnd());
			long hours = duration.toHours();
			long minutes = duration.toMinutesPart();
			String time = hours + "시 " + minutes + "분";
			model.addAttribute("time", time);
		}
		model.addAttribute("att", findAtt);
		model.addAttribute("asidePage", "./attendance/att_aside.jsp");
		model.addAttribute("mainPage", "./attendance/attot_insert.jsp");

		return "index";

	}

	@PostMapping("/otInsert")
	@ResponseBody
	public ResponseDTO<?> otInsert(@RequestBody String otDes, HttpSession session) {
		Users user = (Users) session.getAttribute("login_user");
		Attendance findAtt = attendanceService.firstAtt(user, LocalDate.now());
		if (LocalDateTime.now().getHour() < 18) {
			return new ResponseDTO<>(HttpStatus.BAD_REQUEST.value(), "초과근무 신청은 오후 18시 이후만 가능합니다.");
		} else {
			findAtt.setAttOtDes(otDes);
			findAtt.setAttOtStart(LocalTime.now());
			attendanceService.InsertAtt(findAtt);
			return new ResponseDTO<>(HttpStatus.OK.value(), "초과근무 신청완료");
		}
	}

	@ResponseBody
	@PostMapping("/otEnd")
	public ResponseDTO<?> otEnd(HttpSession session, @RequestBody Attendance data) {
		Users user = (Users) session.getAttribute("login_user");
		Attendance findAtt = attendanceService.firstAtt(user, LocalDate.now());
		findAtt.setAttOtEnd(LocalTime.now());
		LocalTime endTime = findAtt.getAttOtEnd();
		LocalTime startTime = findAtt.getAttOtStart();
		Duration time = Duration.between(startTime, endTime);
		findAtt.setAttOtTime(time.toHours() + "시간 " + (time.toMinutes() % 60) + "분");
		attendanceService.InsertAtt(findAtt);
		return new ResponseDTO<>(HttpStatus.OK.value(),
				"초과근무 완료: " + time.toHours() + "시간 " + (time.toMinutes() % 60) + "분");
	}

	@GetMapping("/att_Ot_FindPage") // 초과근무 신청내역
	public String attendanceOtFind(Model model, HttpSession session) {
		Users user = (Users) session.getAttribute("login_user");
		List<Attendance> attList = attendanceService.attList(user);
		List<Attendance> attotList = new ArrayList<>();
		for (Attendance attot : attList) {
			if (attot.getAttOtStart() != null) {
				attotList.add(attot);
			}
		}
		model.addAttribute("attotList", attotList);
		model.addAttribute("asidePage", "./attendance/att_aside.jsp");
		model.addAttribute("mainPage", "./attendance/attot_find.jsp");
		return "index";
	}

	@GetMapping("/att_Va_InsertPage") // 휴가 신청
	public String attendanceVaInsert(Model model) {
		model.addAttribute("asidePage", "./attendance/att_aside.jsp");
		model.addAttribute("mainPage", "./attendance/attva_insert.jsp");
		return "index";
	}
	
	@ResponseBody
	@PostMapping("/insertVacation") //휴가신청 등록
	public void vacationInsert(@RequestBody Vacation va, HttpSession session) {
		Users user = (Users)session.getAttribute("login_user");
		va.setUserId(user);
		vacationService.insertVa(va);
	}

	public void calVacation(Users user) { // 연차계산기
		LocalDate today = LocalDate.now();
		LocalDate hireDate = user.getUserHireDate();
		if ((today.getDayOfMonth() == 1) || user.getUserVacationDay() == null) { // 1월 1일 아니면 값이 null일때만 실행
			if (hireDate.plusDays(30).isAfter(today)) {
				user.setUserVacationDay(0);
			} else {
				if (today.isBefore(hireDate.plusYears(1))) { // 근속년수 1년미만
					if (today.getYear() == hireDate.getYear()) { // 1년미만 같은 년도이면
						int month = hireDate.getMonthValue() - today.getMonthValue();
						user.setUserVacationDay(month);
					} else {
						int month = today.getMonthValue() + (12 - hireDate.getMonthValue());
						user.setUserVacationDay(month);
					}
				} else if (today.isBefore(hireDate.plusYears(3))) { // 3년 미만은 15일 고정
					user.setUserVacationDay(15);
				} else {
					int duration = 0;
					duration = today.getYear() - hireDate.getYear();
					duration = today.isAfter(hireDate) ? duration : duration--;
					duration = duration / 2;
					if (duration > 10) {
						duration = 10;
					}
					user.setUserVacationDay(15 + duration);
				}
			}
		}
		userService.saveUser(user);
	}

	public Double[] calRemainingVacation(Users user) {
		List<Attendance> attList = attendanceService.attList(user);
		List<Attendanceplan> attplanList = attendanceplanService.findAttPlan(user);
		Double used = 0.0;
		Double use = 0.0;
		Double plan = 0.0;
		Double[] vacationArr = new Double[3];
		for (Attendance att : attList) {
			if (att.getAttType().equals(AType.연차) && (att.getAttDate().getYear() == LocalDate.now().getYear())) {
				used++;
			} else if (att.getAttType().equals(AType.오전반차)
					&& (att.getAttDate().getYear() == LocalDate.now().getYear())) {
				used = used + 0.5;
			} else if (att.getAttType().equals(AType.오전반차)
					&& (att.getAttDate().getYear() == LocalDate.now().getYear())) {
				used = used + 0.5;
			}
		}
		for (Attendanceplan attplan : attplanList) {
			if (attplan.getApType() != null) {
				if (attplan.getApDate().getYear() == LocalDate.now().getYear()) { // 올해
					if (attplan.getApType().equals(ApType.연차) && attplan.getApStatus().equals(ApStatus.승인)) {
						use++;
					} else if (attplan.getApType().equals(ApType.연차) && attplan.getApStatus().equals(ApStatus.대기중)) {
						plan++;
					} else if ((attplan.getApType().equals(ApType.오전반차) || attplan.getApType().equals(ApType.오후반차))
							&& attplan.getApStatus().equals(ApStatus.승인)) {
						use = use + 0.5;
					} else if ((attplan.getApType().equals(ApType.오전반차) || attplan.getApType().equals(ApType.오후반차))
							&& attplan.getApStatus().equals(ApStatus.대기중)) {
						plan = plan + 0.5;
					}
				}
			}
		}
		Double remaining = (user.getUserVacationDay() - used - use - plan);
//		if(LocalDate.now().isBefore(user.getUserHireDate().plusYears(1))){ // 입사한지 1년 미만이면
//		remaining = LocalDate.now().getMonthValue() + (12 - user.getUserHireDate().getMonthValue());
//		}
		user.setUserRemainVacation(remaining);
		userService.saveUser(user);
		vacationArr[0] = use;
		vacationArr[1] = used;
		vacationArr[2] = plan;
		return vacationArr;

	}

	@GetMapping("/att_Va_FindPage") // 휴가 신청 내역 조희
	public String attendanceVaFind(Model model, HttpSession session) {
		Users user = (Users)session.getAttribute("login_user");
		List<Vacation> vaList = vacationService.vaList(user);
		model.addAttribute("vaList", vaList);
		model.addAttribute("asidePage", "./attendance/att_aside.jsp");
		model.addAttribute("mainPage", "./attendance/attva_find.jsp");
		return "index";
	}

	@GetMapping("/att_StatisticsPage") // 통계
	public String attendanceStatistics(Model model) {
		model.addAttribute("asidePage", "./attendance/att_aside.jsp");
		model.addAttribute("mainPage", "./attendance/att_statistics.jsp");
		return "index";
	}

	@PostMapping("/insertAtt")
	@ResponseBody
	public void insertAtt(@RequestBody Users user, LocalDate date, LocalTime time) {
		Attendance findAtt = attendanceService.firstAtt(user, date);
		if (findAtt == null) {
			findAtt = new Attendance();
			findAtt.setUserId(user);
			DayOfWeek week = findAtt.getAttDate().getDayOfWeek();
			if (week == DayOfWeek.SATURDAY || week == DayOfWeek.SUNDAY) {
				findAtt.setAttIsweekend(AIsWeekend.주말);
				findAtt.setAttStart(null);
				findAtt.setAttType(AType.주말근무);

				attendanceService.InsertAtt(findAtt);
			} else {
				Attendanceplan att = attendanceplanService.findAttplanBydate(user, date);
				if (att != null) {
					if (att.getApType() != ApType.공가 || att.getApType() != ApType.연차) { // 연차나 공가를 쓴 경우가 아니면
						LocalTime attTime = (att.getApStatus() != ApStatus.승인) ? LocalTime.parse("09:00:00")
								: att.getApStart();

						if (findAtt.getAttStart().isAfter(attTime)) {
							findAtt.setAttType(AType.지각);
						}
					}
//					else {
//						findAtt.setAttType(att.getApType() != ApType.공가 ? AType.공가 : AType.연차); // 이거 왜 만듦?
//					}
				} else {
					if (findAtt.getAttStart().isAfter(LocalTime.parse("09:00:00"))) {
						findAtt.setAttType(AType.지각);
					}
				}
				attendanceService.InsertAtt(findAtt);
			}
		}
	}
}
