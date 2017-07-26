package org.zhao.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.zhao.dao.RoleDao;
import org.zhao.entity.Admin;
import org.zhao.entity.Module;
import org.zhao.entity.Role;
import org.zhao.entity.page.RolePage;

@Service
public class RoleServiceImpl implements RoleService {

	@Resource
	private RoleDao roleDao;

	public List<Admin> findAdminByRole(Integer id) {
		return roleDao.findAdminByRole(id);
	}

	public Map<String, Object> deleteRole(Integer id) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Admin> list = findAdminByRole(id);
		if (list.size() != 0) {
			map.put("status", 1);
			map.put("msg", "角色名被使用中,不能删除!");
			return map;
		}
		deleteRoleModule(id);
		roleDao.deleteRole(id);
		map.put("status", 0);
		map.put("msg", "删除成功");
		return map;
	}

	public void saveRoleModule(Map<String, Object> map) {
		roleDao.saveRoleModule(map);
	}

	public void deleteRoleModule(Integer id) {
		roleDao.deleteRoleModule(id);
	}

	public void updateRole(Role role) {
		Map<String, Object> map = new HashMap<String, Object>();
		roleDao.updateRole(role);
		deleteRoleModule(role.getRole_id());
		List<Integer> list = role.getModuleIds();
		if (list != null && list.size() > 0) {
			for (Integer id : list) {
				map.put("role_id", role.getRole_id());
				map.put("module_id", id);
				roleDao.saveRoleModule(map);
			}
		}
	}

	public List<Module> findModuleByRole(Integer id) {
		return roleDao.findModuleByRole(id);
	}

	public Role findById(Integer id) {
		return roleDao.findById(id);
	}

	public List<Role> findAll() {
		return roleDao.findAll();
	}

	public void save(Role role) {
		Map<String, Object> map = new HashMap<String, Object>();
		roleDao.saveRole(role);
		Integer roleId = role.getRole_id();
		List<Integer> list = role.getModuleIds();
		if (list != null && list.size() > 0) {
			for (Integer ids : list) {
				map.put("role_id", roleId);
				map.put("module_id", ids);
				roleDao.saveRoleModule(map);
			}
		}
	}

	public Map<String, Object> findByRoleName(String name) {
		Map<String, Object> map = new HashMap<String, Object>();
		Role role = roleDao.findByRoleName(name);
		if (role == null) {
			map.put("status", true);
			map.put("msg", "角色名有效");
			return map;
		}
		map.put("status", false);
		map.put("msg", "角色名已存在");
		return map;
	}

	public int findRows() {
		return roleDao.findRows();
	}

	public List<Role> findByPage(RolePage page) {
		page.setRows(findRows());
		return roleDao.findByPage(page);
	}
}
