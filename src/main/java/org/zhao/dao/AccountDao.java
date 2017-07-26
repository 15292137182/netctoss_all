package org.zhao.dao;

import java.util.List;

import org.zhao.entity.Account;
import org.zhao.entity.page.AccountPage;

public interface AccountDao {

	void updateStatus(Account account);

	void updateAccount(Account account);

	void save(Account account);

	Account findByIdentityCard(String id);

	Account findById(Integer id);

	int findRows(AccountPage page);

	List<Account> findByPage(AccountPage page);
}
