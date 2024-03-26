package com.ccnc.cube.attendance;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ccnc.cube.user.Users;

import jakarta.transaction.Transactional;

@Service
public class VacationService {
	
	@Autowired
	private VacationRepository vacationRepository;
	
	@Transactional
	public void insertVa(Vacation va) {
		vacationRepository.save(va);
	}
	
	@Transactional
	public List<Vacation> vaList(Users user){
		return vacationRepository.findByUserId(user);
	}
}
