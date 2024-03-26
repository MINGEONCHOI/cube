package com.ccnc.cube.reservation;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.NoSuchElementException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ccnc.cube.common.CommonEnum.ReservationItem;
import com.ccnc.cube.common.ResponseDTO;
import com.ccnc.cube.user.UserService;
import com.ccnc.cube.user.Users;

import jakarta.servlet.http.HttpSession;

@Controller
public class ReservationController {

	@Autowired
	private UserService userService;

	@Autowired
	private ReservationService reservationService;

	@Autowired
	private CarReservationService carReservationService;

	@Autowired
	private CarService carService;

	@Autowired
	private MeetingroomService meetingroomService;

	@GetMapping("/reservationPage")
	public String reservationPage(Model model) {
		model.addAttribute("asidePage", "./reservation/rev_aside.jsp");
		model.addAttribute("mainPage", "./reservation/rev_main.jsp");
		return "index";
	}

	@GetMapping("/getrevlist")
	public String getRevList(Model model, HttpSession session) {
		List<Reservation> getRevList = reservationService.getReservationlist();
		model.addAttribute("revList", getRevList);

		Users user = (Users) session.getAttribute("login_user");
		model.addAttribute("isAdmin", reservationService.isAdmin(user));
		model.addAttribute("asidePage", "./reservation/rev_aside.jsp");
		model.addAttribute("mainPage", "./reservation/getmeetlist.jsp");
		return "index";
	}

	@GetMapping("/insertRev")
	public String insertRevPage(Model model) {
		System.out.println("예약페이지 요청");
		model.addAttribute("mrList", meetingroomService.getMeetingroomlist());
		model.addAttribute("asidePage", "./reservation/rev_aside.jsp");
		model.addAttribute("mainPage", "./reservation/insertmeet.jsp");
		return "index";
	}

	@PostMapping("/insertRev/{reNum}")
	public @ResponseBody ResponseDTO<?> insertRev(@RequestBody Reservation reservation, @PathVariable Integer reNum,
			HttpSession session) {
		Users user = (Users) session.getAttribute("login_user");
		reservation.setReNum(meetingroomService.getMeetingroom(reNum));
		reservation.setUserId(user);
		reservation.setReItem(ReservationItem.회의실);

		// 입력된 예약 날짜, 시작 시간, 종료 시간 가져오기

		LocalDate reservationDate = reservation.getReDate();
		LocalTime start = reservation.getReStart();
		LocalTime end = reservation.getReEnd();
		Integer reId = reservation.getReId();

		// 날짜와 시간을 모두 고려하여 중복 여부 확인
		if (reservationService.isTimeSlotAvailable(reservationDate, start, end, reId)) {
			// 중복되는 예약이 없는 경우에만 예약을 진행
			reservationService.insertRev(reservation);
			return new ResponseDTO<>(HttpStatus.OK.value(), "예약완료");
		} else {
			// 중복되는 예약이 있는 경우 예약 불가 메시지 반환
			return new ResponseDTO<>(HttpStatus.BAD_REQUEST.value(), "이미 예약된 시간입니다.");
		}
	}

	@GetMapping("/updateRev/{reId}")
	public String updateRev(@PathVariable Integer reId, Model model) {
		System.out.println("업데이트 페이지 이동");
		model.addAttribute("reId", reId);
		model.addAttribute("mrList", meetingroomService.getMeetingroomlist());
		model.addAttribute("asidePage", "./reservation/rev_aside.jsp");
		model.addAttribute("mainPage", "./reservation/updatemeet.jsp");
		return "index";
	}

	@PostMapping("/updateRev/{reNum}")
	public @ResponseBody ReservationDTO<?> updateRev(@RequestBody Reservation reservation, @PathVariable Integer reNum,
			Model model) {
		Reservation rev = reservationService.getReservation(reservation.getReId());
		Meetingroom mr = meetingroomService.getMeetingroom(reNum);

		rev.setReDate(reservation.getReDate());
		rev.setReNum(mr);
		rev.setReStart(reservation.getReStart());
		rev.setReEnd(reservation.getReEnd());
		reservationService.updateRev(reservation);
		return new ReservationDTO<>(HttpStatus.OK.value(), reservation.getReId() + "완료");

	}

	@DeleteMapping("/deleteRev/{reId}")
	public @ResponseBody ReservationDTO<?> deleteRev(@PathVariable Integer reId) {
		reservationService.deleteRev(reId);
		return new ReservationDTO<>(HttpStatus.OK.value(), "예약취소");

	}

	// ========================================= ↓ 차 량 예 약 코 드 ↓
	// ==============================================================================================//

	@GetMapping("/insertCar")
	public String insertCarPage(Model model) {
		System.out.println("예약페이지 요청");
		model.addAttribute("carList", carService.getCarlist());
		model.addAttribute("asidePage", "./reservation/rev_aside.jsp");
		model.addAttribute("mainPage", "./reservation/insertcar.jsp");
		return "index";
	}

	@PostMapping("/insertCar/{creNum}")
	public @ResponseBody ResponseDTO<?> insertCar(@RequestBody CarReservation carReservation,
			@PathVariable Integer creNum, HttpSession session) {

		Users user = (Users) session.getAttribute("login_user");

		carReservation.setCreNum(carService.getCar(creNum));
		carReservation.setUserId(user);

		LocalTime start = carReservation.getCreStart();
		LocalTime end = carReservation.getCreEnd();
		LocalDate date = carReservation.getCreDate();
		Integer creId = carReservation.getCreId();

		if (carReservationService.isTimeSlotAvailable(date, start, end, creId)) {
			carReservationService.insertCar(carReservation);
			return new ResponseDTO<>(HttpStatus.OK.value(), "예약완료!");
		} else {
			return new ResponseDTO<>(HttpStatus.BAD_REQUEST.value(), "이미 예약된 시간입니다");
		}
	}

	@GetMapping("/getcarlist")
	public String getCarlist(Model model, HttpSession session) {
		List<CarReservation> getCarList = carReservationService.getCarrevlist();
		model.addAttribute("carList", getCarList);

		Users user = (Users) session.getAttribute("login_user");
		model.addAttribute("isAdmin", carReservationService.isAdmin(user));
		model.addAttribute("asidePage", "./reservation/rev_aside.jsp");
		model.addAttribute("mainPage", "./reservation/getcarlist.jsp");
		return "index";

	}

	@GetMapping("/updateCar/{creId}")
	public String updateCar(@PathVariable Integer creId, Model model) {
		System.out.println("업데이트 페이지 이동");
		model.addAttribute("creId", creId);
		model.addAttribute("creList", carService.getCarlist());
		model.addAttribute("asidePage", "./reservation/rev_aside.jsp");
		model.addAttribute("mainPage", "./reservation/updatecar.jsp");
		return "index";
	}

	@PostMapping("/updateCar/{creNum}")
	public @ResponseBody ReservationDTO<?> updateCar(@RequestBody CarReservation carReservation,
			@PathVariable Integer creNum, Model model) {
		CarReservation crev = carReservationService.getCarReservation(carReservation.getCreId());
		Car car = carService.getCar(creNum);

		if (crev != null) {
			crev.setCreDate(carReservation.getCreDate());
			crev.setCreNum(car);
			crev.setCreStart(carReservation.getCreStart());
			crev.setCreEnd(carReservation.getCreEnd());

			carReservationService.updateCar(carReservation);
			return new ReservationDTO<>(HttpStatus.OK.value(), carReservation.getCreId() + "완료");
		} else {
			throw new NoSuchElementException("해당 차량에 대한 예약이 존재하지 않습니다.");
		}

	}

	@DeleteMapping("/deleteCar/{creId}")
	public @ResponseBody ReservationDTO<?> deleteCar(@PathVariable Integer creId) {
		carReservationService.deleteCar(creId);
		return new ReservationDTO<>(HttpStatus.OK.value(), "예약취소");

	}

	// ============================================= ↓ 마 이 페 이 지 ↓
	// ===================================================================================================//

	@GetMapping("/myRevpage")
	public String myPage(Model model, HttpSession session) {
		System.out.println("마이페이지 요청");
		// 세션에서 로그인한 유저 정보 가져오기
		Users user = (Users) session.getAttribute("login_user");

		// 해당 유저의 예약 목록을 가져오기
		List<Reservation> myRevList = reservationService.findRevuserList(user);
		model.addAttribute("revList", myRevList);

		List<CarReservation> myCarRevList = carReservationService.findRevuserList(user);
		model.addAttribute("carList", myCarRevList);

		model.addAttribute("asidePage", "./reservation/rev_aside.jsp");
		model.addAttribute("mainPage", "./reservation/myrevpage.jsp");
		return "index";
	}

}
