package org.zhao.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.zhao.entity.Admin;
import org.zhao.entity.Module;
import org.zhao.entity.Role;
import org.zhao.entity.page.AdminPage;
import org.zhao.entity.page.RolePage;
import org.zhao.service.AdminService;
import org.zhao.service.RoleService;

@Controller
@RequestMapping("/admin")
@SessionAttributes("adminPage")
public class AdminController {
	@Resource
	private RoleService roleService;
	@Resource
	private AdminService adminService;

	@RequestMapping("/findByName.do")
	@ResponseBody
	public Map<String, Object> findByName(String name) {
		return adminService.findByName(name);
	}

	@RequestMapping("/deleteAdmin.do")
	@ResponseBody
	public boolean deleteAdmin(Integer id) {
		adminService.deleteAdmin(id);
		return true;
	}

	@RequestMapping("/updateAdmin.do")
	@ResponseBody
	public boolean updateAdmin(Admin admin) {
		Map<String, Object> map = new HashMap<String, Object>();
		adminService.updateAdmin(admin);
		adminService.deleteAdminRole(admin.getAdmin_id());
		map.put("role_id", admin.getRoleIds());
		map.put("admin_id", admin.getAdmin_id());
		adminService.addAdminRole(map);
		return true;
	}

	@RequestMapping("/save.do")
	@ResponseBody
	public boolean save(Admin admin) {
		adminService.save(admin);
		return true;
	}

	@RequestMapping("/toModify.do")
	public String toModify(Model model, Integer id) {
		Admin admin = adminService.findById(id);
		model.addAttribute("admin", admin);
		List<Role> list = roleService.findAll();
		model.addAttribute("roles", list);
		List<Role> rolesOfAdmin = adminService.findRoleByAdminId(id);
		model.addAttribute("rolesOfAdmin", rolesOfAdmin);
		return "admin/admin_modify";
	}

	@RequestMapping("/toAdd.do")
	public String toAdd(Model model) {
		RolePage page = new RolePage();
		// page.setPageSize(10000000);
		List<Role> roles = roleService.findAll();
		model.addAttribute("roles", roles);
		return "admin/admin_add";
	}

	@RequestMapping("/updatePwd.do")
	@ResponseBody
	public Map<String, Object> updatePwd(String ids) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ids", ids);
		return adminService.updateAdminPwd(map);
	}

	@RequestMapping("/findAdmin.do")
	public String findAll(AdminPage page, Model model) {
		List<Admin> list = adminService.findAdminByPage(page);
		model.addAttribute("admins", list);
		model.addAttribute("adminPage", page);
		List<Module> modules = adminService.findAllModules();
		model.addAttribute("modules", modules);
		return "admin/admin";
	}
}
