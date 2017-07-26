package org.zhao.dao;

import java.util.List;
import java.util.Map;

import org.zhao.entity.Admin;
import org.zhao.entity.Module;
import org.zhao.entity.Role;
import org.zhao.entity.page.AdminPage;

public interface AdminDao {

	Admin findByName(String name);

	void deleteAdmin(Integer id);

	void deleteAdminRole(Integer id);

	void addAdminRole(Map<String, Object> map);

	void updateAdmin(Admin admin);

	List<Role> findRoleByAdminId(Integer id);

	void saveAdminOfRole(Map<String, Object> map);

	void save(Admin admin);

	void updateAdminPwd(Map<String, Object> map);

	Admin findById(Integer id);

	void updateAdminOfToken(Map<String, Object> map);

	List<Module> findModulesByAdmin(Integer id);

	Admin findByAdminCode(String name);

	List<Module> findAllModules();

	int findRows(AdminPage page);

	List<Admin> findAdminByPage(AdminPage page);

}
