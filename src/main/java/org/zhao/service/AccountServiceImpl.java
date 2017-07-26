package org.zhao.service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.zhao.dao.AccountDao;
import org.zhao.entity.Account;
import org.zhao.entity.Services;
import org.zhao.entity.page.AccountPage;
import org.zhao.util.GetMd5;

@Service
public class AccountServiceImpl implements AccountService {

	@Resource
	private AccountDao accountDao;
	@Resource
	private ServicesService service;
	
	public void updatePause(Integer id) {
		Account account = new Account();
		List<Integer>list=new ArrayList<Integer>();
		Services services=new Services();
		services.setAccount_id(id);
		List<Services> s=service.findById(services);
		if (s.size()>0) {
			for (Services ids : s) {
				list.add(ids.getService_id());
				service.updatePause(list);
			}
		}
		account.setAccount_id(id);
		account.setStatus("1");
		updateStatus(account);
	}

	public void updateDelete(Integer id) {
		Services services = new Services();
		List<Integer> list = new ArrayList<Integer>();
		services.setAccount_id(id);
		List<Services> s = service.findById(services);
		if (s.size() > 0) {
			for (Services ids : s) {
				list.add(ids.getService_id());
				service.updateDelete(list);
			}
		}
		Account account = new Account();
		account.setAccount_id(id);
		account.setStatus("2");
		updateStatus(account);
	}

	// public void updateDelete(Integer id) {
	// Services services = new Services();
	// services.setAccount_id(id);
	// Services s = service.findById(services);
	// service.updateDelete(s.getService_id());
	// Account account = new Account();
	// account.setAccount_id(id);
	// account.setStatus("2");
	// updateStatus(account);
	// }

//	public void updatePause(Integer id) {
//		Account account = new Account();
//		account.setAccount_id(id);
//		account.setStatus("1");
//		updateStatus(account);
//	}

	public void updateStart(Integer id) {
		Account account = new Account();
		account.setAccount_id(id);
		account.setStatus("0");
		updateStatus(account);
	}

	public void updateStatus(Account account) {
		accountDao.updateStatus(account);
	}

	public void updateAccount(Account account) {
		String md5_pwd = account.getLogin_passwd();
		account.setLogin_passwd(GetMd5.getMd5(md5_pwd));
		accountDao.updateAccount(account);
	}

	public Map<String, Object> checkPwd(Integer id, String pwd) {
		Map<String, Object> map = new HashMap<String, Object>();
		Account account = findById(id);
		String md5_pwd = GetMd5.getMd5(pwd);
		if (!md5_pwd.equalsIgnoreCase(account.getLogin_passwd())) {
			map.put("status", false);
			map.put("msg", "密码输入错误");
			return map;
		}
		map.put("status", true);
		map.put("msg", "密码正确");
		return map;
	}

	public void save(Account account) {
		account.setStatus("0");
		String md5_pwd = GetMd5.getMd5(account.getLogin_passwd());
		account.setLogin_passwd(md5_pwd);
		account.setCreate_date(new Timestamp(System.currentTimeMillis()));
		accountDao.save(account);
	}

	public Map<String, Object> findByIdentityCard(String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		Account account = accountDao.findByIdentityCard(id);
		if (account == null) {
			map.put("status", false);
			// map.put("msg", "推荐人无效");
			return map;
		}
		map.put("status", true);
		// map.put("msg", "推荐人有效");
		map.put("result", account);
		return map;
	}

	public Account findById(Integer id) {
		return accountDao.findById(id);
	}

	public int findRows(AccountPage page) {
		return accountDao.findRows(page);
	}

	public List<Account> findByPage(AccountPage page) {
		page.setRows(findRows(page));
		return accountDao.findByPage(page);
	}
}
