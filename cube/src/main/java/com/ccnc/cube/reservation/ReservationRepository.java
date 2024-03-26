package com.ccnc.cube.reservation;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ccnc.cube.user.Users;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation, Integer>{

	List<Reservation> findByReDateAndReStartLessThanEqualAndReEndGreaterThanEqualAndReIdNot(LocalDate date, LocalTime end, LocalTime start, Integer reId);
	
	
	List<Reservation> findByUserId(Users userId);

}
 