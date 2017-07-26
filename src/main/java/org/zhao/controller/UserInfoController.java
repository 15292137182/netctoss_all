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
@RequestMapping("/user")
public class UserInfoController {
	@Resource
	private UserService userService;

	@RequestMapping("/updateAdmin.do")
	@ResponseBody
	public boolean updateAdmin(Admin admin) {
		userService.updateAdmin(admin);
		return true;
	}

	@RequestMapping("/findRole.do")
	@ResponseBody
	public Map<String, Object> findRoleByAdminId(Integer id) {
		return userService.findRoleByAdminId(id);
	}

	@RequestMapping("/nopower.do")
	public String toNopower() {
		return "user/nopower";
	}

	@RequestMapping("/findUserInfo.do")
	public String findAll(HttpSession session, Model model) {
		Admin admin = (Admin) session.getAttribute("admin");
		Admin user = userService.findById(admin.getAdmin_id());
		model.addAttribute("currentAdmin", user);
		return "user/user_info";
	}
}
