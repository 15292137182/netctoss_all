package org.zhao.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zhao.service.AdminService;

@Controller
@RequestMapping("/login")
public class LoginController {
	@Resource
	private AdminService adminService;

	@RequestMapping("/login.do")
	@ResponseBody
	public Map<String, Object> findByAdminCode(String name, String pwd, String verification,
			HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("name", name);
		map.put("pwd", pwd);
		map.put("verificationCode", verification);
		return adminService.findByAdminCode(map, session);
	}

	@RequestMapping("/getImageCode.do")
	//@ResponseBody
	public void getImageCode(HttpSession session, HttpServletResponse response) {
		adminService.getImageCode(session, response);
	}

	@RequestMapping("/toIndex.do")
	public String toIndex() {
		return "login/index";
	}

	@RequestMapping("/toLogin.do")
	public String findAll() {
		return "login/login";
	}
}
