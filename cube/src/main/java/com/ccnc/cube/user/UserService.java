package com.ccnc.cube.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ccnc.cube.common.CommonEnum.UserStatus;
import com.ccnc.cube.common.Team;
import com.ccnc.cube.common.TeamRepository;

import jakarta.transaction.Transactional;

@Service
public class UserService {

	@Autowired
	private UserRepository userRepository;
	
	@Transactional
	public List<Users> getUserList(){
		return userRepository.findAll();
	}
	
	@Transactional
	public List<Users> findByTeamId(Team userTeam) {
	    return userRepository.findByUserTeamId(userTeam);
	}
	
	@Transactional
	public Users getUser(String id) {
		return userRepository.findById(id).orElseGet(()->{
			return new Users();
		});
	}
	
	@Transactional
	public Users findByUserNum(String userNum) {
		return userRepository.findByUserNum(userNum);
	}
	
	@Transactional
	public Users findByUserMobile(String userMobile) {
		return userRepository.findByUserMobile(userMobile);
	}
	
	@Transactional
	public Users findByUserEmailEx(String userEmailEx) {
		return userRepository.findByUserEmailEx(userEmailEx);
	}
	
	@Transactional
	public void saveUser(Users user) {
		userRepository.save(user);
	}
	
	@Transactional
	public Users findByUserEmail(String userEmail) {
		return userRepository.findByUserEmail(userEmail);
	}
	
	@Transactional
	public List<Users> findByUserNameLike(String userName) {
		return userRepository.findByUserNameContaining(userName);
	}
}
