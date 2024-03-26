package com.ccnc.cube.hr;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ccnc.cube.common.ResponseDTO;
import com.ccnc.cube.common.Team;
import com.ccnc.cube.common.TeamService;
import com.ccnc.cube.user.UserService;
import com.ccnc.cube.user.Users;

import jakarta.servlet.http.HttpSession;

@Controller
public class HrController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private TeamService teamService;
	
//	@GetMapping("/hrPage")
//	public String attendancePage(Model model) {
//		model.addAttribute("asidePage", "./hr/hr_aside.jsp");
//		model.addAttribute("mainPage", "./hr/hr_main.jsp");
//		return "index";
//	}
	
	@GetMapping("/hr_employeePage")
	public String userListPage(Model model) {
		model.addAttribute("userList", userService.getUserList());
		model.addAttribute("teamList", teamService.getTeamList());
		model.addAttribute("asidePage", "./hr/hr_aside.jsp");
		model.addAttribute("mainPage", "./hr/employee.jsp");
		return "index";
	}
	
	@GetMapping("/hr_updateEmployee/{userId}")
	public String updateEmployeePage(@PathVariable String userId, Model model) {
		System.out.println("임직원 정보 수정 페이지 요청됨");
		model.addAttribute("userList", userService.getUserList());
		model.addAttribute("teamList", teamService.getTeamList());
		
		System.out.println(userId);
		model.addAttribute("userId", userId);
		model.addAttribute("asidePage", "./hr/hr_aside.jsp");
		model.addAttribute("mainPage", "./hr/updateEmployee.jsp");
		return "index";
	}
	
	@PostMapping("/hr_updateEmployee/{teamId}")
	public @ResponseBody ResponseDTO<?> updateEmployee(@RequestBody Users user, @PathVariable Integer teamId) {
		System.out.println("임직원 정보 수정 요청됨");
		Users findUser = userService.getUser(user.getUserId());
		findUser.setUserTeamId(teamService.getTeam(teamId));
		findUser.setUserPosition(user.getUserPosition());
		findUser.setUserStatus(user.getUserStatus());
		userService.saveUser(findUser);
		return new ResponseDTO<>(HttpStatus.OK.value(), "임직원 정보 수정 성공");
	}
	
	@GetMapping("/hr_searchEmployee/{searchType}/{searchInput}")
	public String searchEmployee(@PathVariable String searchType, @PathVariable String searchInput, Model model) {
		System.out.println("임직원 정보 검색 요청됨");
		System.out.println(searchType);
		System.out.println(searchInput);
		
		if(searchType.equals("userName")) {
			System.out.println("이름으로 검색 실행");
			model.addAttribute("userList", userService.findByUserNameLike(searchInput));
			
		} else if(searchType.equals("userTeamId")) {
			System.out.println("팀으로 검색 실행");
			List<Users> userList = new ArrayList<>();
			for (Team team : teamService.findByTeamNameLike(searchInput)) {
				userList.addAll(userService.findByTeamId(team));				
			}
			model.addAttribute("userList", userList);
		}
		model.addAttribute("teamList", teamService.getTeamList());
		model.addAttribute("asidePage", "./hr/hr_aside.jsp");
		model.addAttribute("mainPage", "./hr/employee.jsp");
		System.out.println("세팅완료");
		
		return "index";
	}

}
