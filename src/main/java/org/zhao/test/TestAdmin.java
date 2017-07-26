package org.zhao.test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.zhao.dao.AdminDao;
import org.zhao.entity.Admin;
import org.zhao.entity.Module;
import org.zhao.entity.Role;
import org.zhao.entity.page.AdminPage;
import org.zhao.service.AdminService;
import org.zhao.util.GetMd5;
import org.zhao.util.GetServiceToken;
import org.zhao.util.InitSpringContainer;

public class TestAdmin {
	AdminService adminService = InitSpringContainer.getContext().getBean(
			"adminServiceImpl", AdminService.class);
	AdminDao adminDao = InitSpringContainer.getContext().getBean("adminDao",
			AdminDao.class);

	@Test
	public void findName() {
		String name = "胡歌1";
		Map<String, Object> map = adminService.findByName(name);
		System.out.println(map.get("msg"));
	}

	@Test
	public void deleteAdmin() {
		adminService.deleteAdmin(10001);
	}

	@Test
	public void deleteAdminRole() {
		adminService.deleteAdminRole(2000);
	}

	@Test
	public void addAdminRole() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Integer> list = new ArrayList<Integer>();
		list.add(1000);
		list.add(1001);
		list.add(100);
		list.add(200);
		map.put("role_id", list);
		map.put("admin_id", 2000);
		adminService.addAdminRole(map);
	}

	@Test
	public void updateAdmin() {
		Admin admin = new Admin();
		admin.setAdmin_id(2000);
		admin.setAdmin_code("temp");
		admin.setTelephone("18516582158");
		admin.setEmail("qing@sina.cn");
		adminService.updateAdmin(admin);
	}

	@Test
	public void save() {
		Admin admin = new Admin();
		admin.setAdmin_code("赵998");
		admin.setPassword("hello998");
		admin.setName("master888");
		adminService.save(admin);
	}

	@Test
	public void updateAdminPwd() {
		Map<String, Object> map = new HashMap<String, Object>();
		String str = "2000,3000,4000,5000";
		map.put("ids", str);
		map.put("defaultPwd", GetMd5.getMd5());
		adminService.updateAdminPwd(map);
	}

	// @Test
	// public void updateAdminPwd() {
	// Map<String, Object> map = new HashMap<String, Object>();
	// List<Integer> list = new ArrayList<Integer>();
	// list.add(2000);
	// list.add(3000);
	// list.add(4000);
	// list.add(5000);
	// map.put("ids", list);
	// map.put("defaultPwd", GetMd5.getMd5());
	// adminService.updateAdminPwd(map);
	// }

	@Test
	public void findById() {
		Admin admin = adminDao.findById(2000);
		System.out.println(admin.getAdmin_id() + " " + admin.getName());
	}

	@Test
	public void updateAdminOfToken() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("admin_id", 2000);
		map.put("token", GetServiceToken.getUUID());
		adminService.updateAdminOfToken(map);
	}

	@Test
	public void findModulesByAdmin() {
		List<Module> modules = adminService.findModulesByAdmin(5000);
		for (Module module : modules) {
			System.out.println(module.getModule_id() + " " + module.getName());
		}
	}

	@Test
	public void findAllModules() {
		List<Module> list = adminService.findAllModules();
		for (Module module : list) {
			System.out.println(module.getModule_id() + " " + module.getName());
		}
	}

	@Test
	public void findAdminByPage() {
		AdminPage page = new AdminPage();
		// page.setModuleId(7);
		page.setRoleName("管理员");
		List<Admin> list = adminService.findAdminByPage(page);
		for (Admin admin : list) {
			System.out.println(admin.getAdmin_id() + " " + admin.getName());
			List<Role> roles = admin.getRoles();
			for (Role role : roles) {
				System.out.println(role.getRole_id() + " " + role.getName());
			}
			System.out.println("+++++++++++++++++++++++++++++++++++++++");
		}
	}

	@Test
	public void findRows() {
		AdminPage page = new AdminPage();
		// page.setModuleId(7);
		// page.setRoleName("经理");
		int rows = adminService.findRows(page);
		System.out.println(rows);
	}

}
