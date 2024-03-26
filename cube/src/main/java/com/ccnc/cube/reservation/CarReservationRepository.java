package com.ccnc.cube.reservation;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ccnc.cube.user.Users;

@Repository
public interface CarReservationRepository extends JpaRepository<CarReservation, Integer> {

	List<CarReservation> findByCreDateAndCreStartLessThanEqualAndCreEndGreaterThanEqualAndCreIdNot(LocalDate date,LocalTime end, LocalTime start,Integer creId);
	

	List<CarReservation> findByUserId(Users userId);
}
