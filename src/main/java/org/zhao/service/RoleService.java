package org.zhao.service;

import java.util.List;
import java.util.Map;

import org.zhao.entity.Admin;
import org.zhao.entity.Module;
import org.zhao.entity.Role;
import org.zhao.entity.page.RolePage;

public interface RoleService {
	
	List<Admin> findAdminByRole(Integer id);
	
	Map<String, Object> deleteRole(Integer id);
	
	void saveRoleModule(Map<String, Object> map);

	void deleteRoleModule(Integer id);

	void updateRole(Role role);
	
	List<Module> findModuleByRole(Integer id);
	
	Role findById(Integer id);
	
	List<Role> findAll();

	void save(Role role);

	Map<String, Object> findByRoleName(String name);

	int findRows();

	List<Role> findByPage(RolePage page);

}
