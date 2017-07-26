package org.zhao.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.zhao.entity.Module;
import org.zhao.entity.Role;
import org.zhao.entity.page.RolePage;
import org.zhao.service.AdminService;
import org.zhao.service.RoleService;

@Controller
@RequestMapping("/role")
@SessionAttributes("rolePage")
public class RoleController {
	@Resource
	private RoleService roleService;
	@Resource
	private AdminService adminService;

	@RequestMapping("/deleteRole.do")
	@ResponseBody
	public Map<String, Object> deleteRole(Integer id) {
		return roleService.deleteRole(id);
	}

	@RequestMapping("/updateRole.do")
	@ResponseBody
	public boolean updateRole(Role role) {
		roleService.updateRole(role);
		return true;
	}

	@RequestMapping("/save.do")
	@ResponseBody
	public boolean save(Role role) {
		roleService.save(role);
		return true;
	}

	@RequestMapping("/findByRoleName.do")
	@ResponseBody
	public Map<String, Object> findRole(String name) {
		return roleService.findByRoleName(name);
	}

	@RequestMapping("/toModify.do")
	public String toModify(Model model, Integer id) {
		Role role = roleService.findById(id);
		model.addAttribute("role", role);
		List<Module> modules = adminService.findAllModules();
		model.addAttribute("modules", modules);
		List<Module> list = roleService.findModuleByRole(id);
		model.addAttribute("modulesOfRole", list);
		return "role/role_modify";
	}

	@RequestMapping("/toAdd.do")
	public String toAdd(Model model) {
		List<Module> list = adminService.findAllModules();
		model.addAttribute("modules", list);
		return "role/role_add";
	}

	@RequestMapping("/findRole.do")
	public String findAll(RolePage page, Model model) {
		List<Role> list = roleService.findByPage(page);
		model.addAttribute("roles", list);
		model.addAttribute("rolePage", page);
		return "role/role";
	}
}
