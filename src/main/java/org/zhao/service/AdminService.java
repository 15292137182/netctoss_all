package org.zhao.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.zhao.entity.Admin;
import org.zhao.entity.Module;
import org.zhao.entity.Role;
import org.zhao.entity.page.AdminPage;

public interface AdminService {

	Map<String, Object> findByName(String name);

	void deleteAdmin(Integer id);

	void deleteAdminRole(Integer id);

	void addAdminRole(Map<String, Object> map);

	void updateAdmin(Admin admin);

	List<Role> findRoleByAdminId(Integer id);

	Admin findById(Integer id);

	void save(Admin admin);

	Map<String, Object> updateAdminPwd(Map<String, Object> map);

	boolean checkToken(Integer admin_id, String token);

	void updateAdminOfToken(Map<String, Object> map);

	List<Module> findModulesByAdmin(Integer id);

	void getImageCode(HttpSession session, HttpServletResponse response);

	Map<String, Object> findByAdminCode(Map<String, Object> map,
			HttpSession session);

	List<Module> findAllModules();

	int findRows(AdminPage page);

	List<Admin> findAdminByPage(AdminPage page);

}
