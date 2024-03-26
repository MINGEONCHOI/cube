package com.ccnc.cube.reservation;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.NoSuchElementException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ccnc.cube.common.CommonEnum.UserRole;
import com.ccnc.cube.user.Users;

@Service
public class CarReservationService {
	
	@Autowired
	private CarReservationRepository carReservationRepository;

	@Transactional
	public void insertCar(CarReservation carReservation) {
		carReservationRepository.save(carReservation);	
	}
	
	@Transactional
	public List<CarReservation> getCarrevlist() {
		List<CarReservation> carrevList = new ArrayList<>(carReservationRepository.findAll());
		
		Collections.sort(carrevList,
				Comparator.comparing(CarReservation::getCreDate).thenComparing(CarReservation::getCreStart));
		 
		return carrevList;
	}
	
	@Transactional
	public void deleteCar(Integer creId) {
		carReservationRepository.deleteById(creId);
	}

	@Transactional(readOnly = true)
	public CarReservation getCarReservation(Integer creId) {
		CarReservation findCarReservation = carReservationRepository.findById(creId).orElseGet(() -> {
			return new CarReservation();
		});
		return findCarReservation;
	}
	
	@Transactional
	public void updateCar(CarReservation carReservation) {
		CarReservation findCarReservation = carReservationRepository.findById(carReservation.getCreId())
				.orElse(null);

		if (findCarReservation != null) {
			findCarReservation.setCreStart(carReservation.getCreStart());
			findCarReservation.setCreEnd(carReservation.getCreEnd());
			findCarReservation.setCreDate(carReservation.getCreDate());

			carReservationRepository.save(findCarReservation);
		} else {
			throw new NoSuchElementException("해당 ID를 가진 예약이 존재하지 않아용");
		}
	}
	
	public boolean isTimeSlotAvailable(LocalDate date,LocalTime start, LocalTime end,Integer creId) {
		// 해당 시간에 이미 예약이 있는지 데이터베이스에서 조회
		List<CarReservation> overlappingReservations = carReservationRepository.findByCreDateAndCreStartLessThanEqualAndCreEndGreaterThanEqualAndCreIdNot(date,end,start,creId);

		// 겹치는 예약이 없으면 true 반환
		return overlappingReservations.isEmpty();
	}

	public void insertcheckRev(CarReservation carReservation) {
		LocalTime start = carReservation.getCreStart();
		LocalTime end = carReservation.getCreEnd();
		LocalDate date = carReservation.getCreDate();
		Integer creId = carReservation.getCreId();
		
		if (isTimeSlotAvailable(date, end,start,creId)) {
			carReservationRepository.save(carReservation);
		} else {
			throw new RuntimeException("해당 시간대에 이미 예약이 있습니다.");
		}

	}
	
	public boolean isAdmin(Users user) {
		return UserRole.ADMIN.equals(user.getUserRole());
	}
	
	
	public List<CarReservation> findRevuserList(Users userId){
		return carReservationRepository.findByUserId(userId);
	}

}
