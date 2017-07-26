package org.zhao.dao;

import java.util.List;
import java.util.Map;

import org.zhao.entity.Admin;
import org.zhao.entity.Module;
import org.zhao.entity.Role;
import org.zhao.entity.page.RolePage;

public interface RoleDao {
	
	List<Admin> findAdminByRole(Integer id);

	void deleteRole(Integer id);

	void deleteRoleModule(Integer id);

	void updateRole(Role role);

	List<Module> findModuleByRole(Integer id);

	Role findById(Integer id);

	List<Role> findAll();

	void saveRoleModule(Map<String, Object> map);

	void saveRole(Role role);

	Role findByRoleName(String name);

	int findRows();

	List<Role> findByPage(RolePage page);

}
