package org.zhao.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.zhao.dao.AdminDao;
import org.zhao.entity.Admin;
import org.zhao.entity.Role;
import org.zhao.util.GetMd5;

@Service
public class UserServiceImpl implements UserService {
	@Resource
	private AdminDao adminDao;

	public Map<String, Object> updateAdminPwd(String newPwd, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Integer> list = new ArrayList<Integer>();
		Admin admin = (Admin) session.getAttribute("admin");
		map.put("defaultPwd", GetMd5.getMd5(newPwd));
		list.add(admin.getAdmin_id());
		map.put("ids", list);
		adminDao.updateAdminPwd(map);
		map.put("status", 0);
		map.put("msg", "更新密码成功!");
		return map;
	}

	public Map<String, Object> checkOldPwd(String pwd, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		Admin admin = (Admin) session.getAttribute("admin");
		Admin user = findById(admin.getAdmin_id());
		if (!user.getPassword().equals(GetMd5.getMd5(pwd))) {
			map.put("status", 1);
			map.put("msg", "旧密码错误!");
			return map;
		}
		map.put("status", 0);
		map.put("msg", "旧密码正确!");
		return map;
	}

	public Admin findById(Integer id) {
		return adminDao.findById(id);
	}

	public Map<String, Object> findRoleByAdminId(Integer id) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<String> roles = new ArrayList<String>();
		List<Role> list = adminDao.findRoleByAdminId(id);
		for (Role role : list) {
			String name = role.getName();
			roles.add(name);
		}
		map.put("status", true);
		map.put("data", roles);
		return map;
	}

	public void updateAdmin(Admin admin) {
		adminDao.updateAdmin(admin);
	}
}
