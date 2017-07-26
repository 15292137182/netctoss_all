package org.zhao.test;

import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.zhao.dao.AccountDao;
import org.zhao.entity.Account;
import org.zhao.entity.page.AccountPage;
import org.zhao.service.AccountService;
import org.zhao.util.InitSpringContainer;

public class TestAccount {
	AccountService accountService = InitSpringContainer.getContext().getBean(
			"accountServiceImpl", AccountService.class);
	AccountDao accountDao = InitSpringContainer.getContext().getBean(
			"accountDao", AccountDao.class);

	@Test
	public void updateDelete() {
		Account account = new Account();
		account.setAccount_id(2000);
		account.setStatus("2");
		accountService.updateStatus(account);
	}

	@Test
	public void updateStart() {
		Account account = new Account();
		account.setAccount_id(2000);
		account.setStatus("0");
		accountService.updateStatus(account);
	}

	@Test
	public void updatePause() {
		Account account = new Account();
		account.setAccount_id(2000);
		account.setStatus("1");
		accountService.updateStatus(account);
	}

	@Test
	public void checkPwd() {
		Map<String, Object> map = accountService.checkPwd(2004, "a1111111");
		System.out.println(map.get("status") + " " + map.get("msg"));
	}

	@Test
	public void findByIdentityCard() {
		Map<String, Object> map = accountService
				.findByIdentityCard("320211199307310346");
		System.out.println(map.get("status") + "　" + map.get("msg") + "   "
				+ map.get("result"));
	}

	@Test
	public void findById() {
		Account account = accountService.findById(1011);
		// 1011:330902197108270429
		// 1010:330682196903190613
		System.out.println(account.getAccount_id() + " "
				+ account.getReal_name() + " " + account.getIdcard_no() + " "
				+ +account.getRecommender_id() + " "
				+ account.getReIdentityCard());
	}

	@Test
	public void findByPage() {
		AccountPage page = new AccountPage();
		// page.setIdentityCard("610121198906041115");
		// page.setNickname("mjjzh64");
		// page.setRealName("zhangwuji");
		page.setStatus("1");
		List<Account> list = accountService.findByPage(page);
		for (Account account : list) {
			System.out.println(account.getAccount_id() + " "
					+ account.getReal_name() + " " + account.getIdcard_no());
		}
	}

	@Test
	public void findRows() {
		AccountPage page = new AccountPage();
		page.setIdentityCard("610121198906041115");
		page.setNickname("mjjzh64");
		page.setRealName("zhangwuji");
		page.setStatus("1");
		System.out.println(accountService.findRows(page));
	}

}
