package org.zhao.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zhao.entity.Admin;
import org.zhao.service.UserService;

@Controller
@RequestMapping("/updateUserPwd")
public class UpdateUserPwdController {

	@Resource
	private UserService userService;

	@RequestMapping("/updatePwd.do")
	@ResponseBody
	public Map<String, Object> updateAdminPwd(String newPwd, HttpSession session) {
		return userService.updateAdminPwd(newPwd, session);
	}

	@RequestMapping("/checkOldPwd.do")
	@ResponseBody
	public Map<String, Object> checkOldPwd(String pwd, HttpSession session) {
		return userService.checkOldPwd(pwd, session);
	}

	@RequestMapping("/updateUserPwd.do")
	public String findAll() {
		return "user/update_user_pwd";
	}
}
