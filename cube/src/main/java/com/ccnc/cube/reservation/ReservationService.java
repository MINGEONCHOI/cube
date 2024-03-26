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
public class ReservationService {
	
	@Autowired
	private ReservationRepository reservationRepository;
	
	@Autowired
	private MeetingroomService meetingroomService;
	
	@Transactional
	public void insertRev(Reservation reservation) {
		reservationRepository.save(reservation);
	}
	
	@Transactional
    public List<Reservation> getReservationlist() {
        List<Reservation> reservationList = new ArrayList<>(reservationRepository.findAll());

        // 날짜와 시작 시간을 모두 고려하여 정렬
        Collections.sort(reservationList, Comparator
                .comparing(Reservation::getReDate)
                .thenComparing(Reservation::getReStart));

        return reservationList;
    }
	
	@Transactional
	public void deleteRev(Integer reId) {
		reservationRepository.deleteById(reId);
	}
	
	
	@Transactional
    public void updateRev(Reservation reservation) {
        // 예약 ID에 해당하는 예약을 데이터베이스에서 찾습니다.
        Reservation existingReservation = reservationRepository.findById(reservation.getReId()).orElse(null);
        
        if (existingReservation != null) {
            // 업데이트할 예약 정보 설정
            existingReservation.setReStart(reservation.getReStart());
            existingReservation.setReEnd(reservation.getReEnd());
            // 다른 필요한 업데이트 작업 수행
            // ...

            // 업데이트된 예약 저장
            reservationRepository.save(existingReservation);
        } else {
            // 해당 ID를 가진 예약이 없는 경우에 대한 처리
            // 예외를 던지거나, 로깅을 수행하거나, 다른 작업을 수행할 수 있습니다.
            throw new NoSuchElementException("해당 ID를 가진 예약이 존재하지 않습니다.");
        }
    }
	
	@Transactional(readOnly = true)
	public Reservation getReservation(Integer reId) {
		Reservation findReservation = reservationRepository.findById(reId).orElseGet(()->{
			return new Reservation();
		});
		
		return findReservation;
	}
	
	
	
	public boolean isTimeSlotAvailable(LocalDate date, LocalTime start, LocalTime end, Integer reId) {
	    // 해당 회의실에서 이미 예약이 있는지 확인
	
	    
	    // 다른 회의실에서 이미 예약이 있는지 확인
	    List<Reservation> overlappingReservationsForOtherRoom = reservationRepository.findByReDateAndReStartLessThanEqualAndReEndGreaterThanEqualAndReIdNot(date, end, start, reId);
	    
	    // 현재 회의실과 다른 회의실에서 겹치는 예약이 없으면 true 반환
	    return overlappingReservationsForOtherRoom.isEmpty();
	}


	
	public void insertCheckRev(Reservation reservation) {
	    LocalDate date = reservation.getReDate();
	    LocalTime start = reservation.getReStart();
	    LocalTime end = reservation.getReEnd();
	    Integer reCount = reservation.getReCount();

	    // 예약 요청 보내기 전에 이미 있는 예약과 겹치는지 확인
	    // 겹치는 예약이 있는 경우 예약 등록 중단
	    if (this.isTimeSlotAvailable(date, start, end, reservation.getReId())) {
	        // 수용 가능한 최대 참석 인원을 체크
	        if (this.isWithinCapacity(date, start, end, reCount, reservation.getReId())) {
	            // 중복이 없고 수용 가능한 최대 참석 인원을 초과하지 않으면 예약 등록
	            reservationRepository.save(reservation);
	        } else {
	            throw new RuntimeException("수용 가능한 최대 참석 인원을 초과하였습니다.");
	        }
	    } else {
	        throw new RuntimeException("해당 시간대에 이미 예약이 있습니다.");
	    }
	}
	
	public boolean isWithinCapacity(LocalDate date, LocalTime start, LocalTime end, Integer reCount, Integer reId) {
	    // 해당 회의실에서 이미 예약이 있는지 확인
	    List<Reservation> overlappingReservationsForSameRoom = reservationRepository.findByReDateAndReStartLessThanEqualAndReEndGreaterThanEqualAndReIdNot(date, end, start, reId);

	    // 해당 회의실의 수용 가능한 최대 참석 인원을 가져오기
	    Integer maxCapacity = 0; // 기본값 설정

	    // 회의실 정보 조회
	    Meetingroom meetingroom = meetingroomService.getMeetingroom(reId);
	    if (meetingroom != null) {
	        // 수용 가능한 최대 참석 인원 가져오기
	        maxCapacity = meetingroom.getMrCapacity();
	    }

	    // 수용 가능한 최대 참석 인원을 초과하지 않으면 true 반환
	    return overlappingReservationsForSameRoom.stream().mapToInt(Reservation::getReCount).sum() + reCount <= maxCapacity;
	}

	
	public boolean isAdmin(Users user) {
		return UserRole.ADMIN.equals(user.getUserRole());
	}
	
	public List<Reservation> findRevuserList(Users userId){
		return reservationRepository.findByUserId(userId);
	}
	

	

}
