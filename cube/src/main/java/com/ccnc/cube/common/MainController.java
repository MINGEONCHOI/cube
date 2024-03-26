package com.ccnc.cube.common;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

    @GetMapping("/index")
    public String index(Model model) {
    	model.addAttribute("asidePage", "./layout/aside.jsp");
    	model.addAttribute("mainPage", "./layout/main.jsp");
        return "index";
    }
}

