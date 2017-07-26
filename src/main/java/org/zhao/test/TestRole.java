package org.zhao.test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.zhao.entity.Admin;
import org.zhao.entity.Module;
import org.zhao.entity.Role;
import org.zhao.entity.page.RolePage;
import org.zhao.service.RoleService;
import org.zhao.util.InitSpringContainer;

public class TestRole {
	RoleService roleService = InitSpringContainer.getContext().getBean(
			"roleServiceImpl", RoleService.class);

	@Test
	public void findAdminByRole() {
		List<Admin> list = roleService.findAdminByRole(1004);
		for (Admin admin : list) {
			System.out.println(admin.getAdmin_id() + " " + admin.getName());
		}
	}

	@Test
	public void delete() {
		Map<String, Object> map = roleService.deleteRole(1013);
		System.out.println(map.get("msg"));
	}

	@Test
	public void saveRoleModule() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Integer> list = new ArrayList<Integer>();
		list.add(5);
		list.add(3);
		list.add(4);
		for (Integer id : list) {
			map.put("role_id", 1000);
			map.put("module_id", id);
			roleService.saveRoleModule(map);
		}
	}

	@Test
	public void updateRole() {
		Role role = new Role();
		List<Integer> list = new ArrayList<Integer>();
		role.setRole_id(1002);
		role.setName("老板998");
		list.add(2);
		list.add(3);
		list.add(7);
		role.setModuleIds(list);
		roleService.updateRole(role);
	}

	@Test
	public void deleteRoleModule() {
		roleService.deleteRoleModule(1001);
	}

	@Test
	public void findModuleByRole() {
		List<Module> list = roleService.findModuleByRole(100);
		for (Module module : list) {
			System.out.println(module.getModule_id() + " " + module.getName());
		}
	}

	@Test
	public void findById() {
		Role role = roleService.findById(100);
		System.out.println(role.getRole_id() + " " + role.getName());
	}

	@Test
	public void save() {
		Role role = new Role();
		List<Integer> ids = new ArrayList<Integer>();
		role.setName("vvvv");
		ids.add(3);
		ids.add(6);
		ids.add(7);
		role.setModuleIds(ids);
		roleService.save(role);
	}

	@Test
	public void findRole() {
		Map<String, Object> map = roleService.findByRoleName("经理");
		System.out.println(map.get("msg") + " " + map.get("status"));
	}

	@Test
	public void findRows() {
		System.out.println(roleService.findRows());
	}

	@Test
	public void findByPage() {
		RolePage page = new RolePage();
		page.setCurrentPage(2);
		List<Role> list = roleService.findByPage(page);
		for (Role role : list) {
			System.out.println(role.getRole_id() + " " + role.getName());
			List<Module> modules = role.getModules();
			for (Module module : modules) {
				System.out.println(module.getModule_id() + " "
						+ module.getName());
			}
			System.out.println("+++++++++++++++++++++++++++++++++");
		}
	}

}
