package com.ccnc.cube.common;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CalendarController {
	
	
	@GetMapping("/calendar")
	public String calendar(String path, Model model) {
		return "org/calendar";
	}
}
