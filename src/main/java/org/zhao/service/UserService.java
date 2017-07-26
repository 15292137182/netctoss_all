package org.zhao.service;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.zhao.entity.Admin;

public interface UserService {

	Map<String, Object> updateAdminPwd(String newPwd, HttpSession session);

	Map<String, Object> checkOldPwd(String pwd,HttpSession session);

	Admin findById(Integer id);

	Map<String, Object> findRoleByAdminId(Integer id);

	void updateAdmin(Admin admin);
}
