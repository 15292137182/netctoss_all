package org.zhao.service;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.zhao.dao.AdminDao;
import org.zhao.entity.Admin;
import org.zhao.entity.Module;
import org.zhao.entity.Role;
import org.zhao.entity.page.AdminPage;
import org.zhao.util.GetMd5;
import org.zhao.util.GetServiceToken;
import org.zhao.util.ImageUtil;
import org.zhao.util.InitStaticValue;

@Service
public class AdminServiceImpl implements AdminService {
	@Resource
	private AdminDao adminDao;

	public Map<String, Object> findByName(String name) {
		Map<String, Object> map = new HashMap<String, Object>();
		Admin admin = adminDao.findByName(name);
		if (admin != null) {
			map.put("status", 1);
			map.put("msg", "管理员账号已存在!");
			return map;
		}
		map.put("status", 0);
		map.put("msg", "管理员账号有效!");
		return map;
	}

	public void deleteAdmin(Integer id) {
		deleteAdminRole(id);
		adminDao.deleteAdmin(id);
	}

	public void deleteAdminRole(Integer id) {
		adminDao.deleteAdminRole(id);
	}

	public void addAdminRole(Map<String, Object> map) {
		@SuppressWarnings("unchecked")
		List<Integer> list = (List<Integer>) map.get("role_id");
		Integer adminId = (Integer) map.get("admin_id");
		for (Integer id : list) {
			map.put("role_id", id);
			map.put("admin_id", adminId);
			adminDao.addAdminRole(map);
		}
	}

	public void updateAdmin(Admin admin) {
		adminDao.updateAdmin(admin);
	}

	public List<Role> findRoleByAdminId(Integer id) {
		return adminDao.findRoleByAdminId(id);
	}

	public Admin findById(Integer id) {
		return adminDao.findById(id);
	}

	public void save(Admin admin) {
		Map<String, Object> map = new HashMap<String, Object>();
		admin.setEnrolldate(new Timestamp(System.currentTimeMillis()));
		admin.setPassword(GetMd5.getMd5(admin.getPassword()));
		adminDao.save(admin);
		List<Integer> list = admin.getRoleIds();
		for (Integer id : list) {
			map.put("admin_id", admin.getAdmin_id());
			map.put("role_id", id);
			adminDao.saveAdminOfRole(map);
		}
	}

	public List<Integer> getIds(String ids) {
		String[] idsArr = ids.split(",");
		List<Integer> list = new ArrayList<Integer>();
		for (String id : idsArr) {
			list.add(Integer.valueOf(id));
		}
		return list;
	}

	public Map<String, Object> updateAdminPwd(Map<String, Object> map) {
		String ids = (String) map.get("ids");
		List<Integer> list = getIds(ids);
		map.put("ids", list);
		map.put("defaultPwd", GetMd5.getMd5());
		adminDao.updateAdminPwd(map);
		map.put("status", InitStaticValue.RESET_PWD);
		map.put("msg", InitStaticValue.RESET_PWD_MSG);
		return map;
	}

	public void getImageCode(HttpSession session, HttpServletResponse response) {
		Map<String, BufferedImage> map = ImageUtil.createImage();
		String code = map.keySet().iterator().next();
		session.setAttribute("code", code);
		BufferedImage image = map.get(code);
		response.setContentType("image/jpeg");
		try {
			OutputStream os = response.getOutputStream();
			ImageIO.write(image, "jpeg", os);
			os.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public List<Module> findModulesByAdmin(Integer id) {
		return adminDao.findModulesByAdmin(id);
	}

	public void updateAdminOfToken(Map<String, Object> map) {
		adminDao.updateAdminOfToken(map);
	}

	public boolean checkToken(Integer admin_id, String token) {
		Admin admin = findById(admin_id);
		return admin.getToken().equals(token);
	}

	@SuppressWarnings("unused")
	public Map<String, Object> findByAdminCode(Map<String, Object> map,
			HttpSession session) {
		String name = (String) map.get("name");
		String pwd = (String) map.get("pwd");
		String verification = (String) map.get("verificationCode");
		String code = (String) session.getAttribute("code");
		if (!code.equalsIgnoreCase(verification)) {
			map.put("status", InitStaticValue.VERIFICATION_CODE_ERROR);
			map.put("msg", InitStaticValue.VERIFICATION_CODE_ERROR_MSG);
			return map;
		}
		Admin admin = adminDao.findByAdminCode(name);
		session.setAttribute("admin", admin);

//		List<Role> list = findRoleByAdminId(admin.getAdmin_id());
//		session.setAttribute("currentAdminOfRoles", list);

		if (admin == null) {
			map.put("status", InitStaticValue.USERNAME_ERROR);
			map.put("msg", InitStaticValue.USERNAME_ERROR_MSG);
			return map;
		}
		if (!admin.getPassword().equals(GetMd5.getMd5(pwd))) {
			map.put("status", InitStaticValue.PWD_ERROR);
			map.put("msg", InitStaticValue.PWD_ERROR_MSG);
			return map;
		}
		map.put("status", InitStaticValue.SUCCESS_INFO);
		map.put("msg", InitStaticValue.SUCCESS_INFO_MSG);
		String token = GetServiceToken.getUUID();
		admin.setToken(token);
		map.put("admin_id", admin.getAdmin_id());
		map.put("token", token);
		updateAdminOfToken(map);
		List<Module> modules = findModulesByAdmin(admin.getAdmin_id());
		session.setAttribute("modulesOfAdmin", modules);
		return map;
	}

	public List<Module> findAllModules() {
		return adminDao.findAllModules();
	}

	public int findRows(AdminPage page) {
		return adminDao.findRows(page);
	}

	public List<Admin> findAdminByPage(AdminPage page) {
		page.setRows(findRows(page));
		return adminDao.findAdminByPage(page);
	}

}
