package org.zhao.service;

import java.util.List;
import java.util.Map;

import org.zhao.entity.Account;
import org.zhao.entity.Admin;
import org.zhao.entity.page.AccountPage;

public interface AccountService {

	void updateStart(Integer id);

	void updatePause(Integer id);

	void updateDelete(Integer id);

	void updateStatus(Account account);

	void updateAccount(Account account);

	Map<String, Object> checkPwd(Integer id, String pwd);

	void save(Account account);

	Map<String, Object> findByIdentityCard(String id);

	Account findById(Integer id);

	int findRows(AccountPage page);

	List<Account> findByPage(AccountPage page);
}
