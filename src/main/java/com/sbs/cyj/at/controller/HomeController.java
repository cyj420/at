package com.sbs.cyj.at.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	@RequestMapping("/home/main")
	public String showMain() {
		return "home/main";
		// application.yml 에서 prefix(/WEB-INF/jsp/)랑 suffix(.jsp)를 해줬기에 각각 앞/뒤에 붙어
		// return 값은 "/WEB-INF/jsp/home/main.jsp"와 동일
	}
}