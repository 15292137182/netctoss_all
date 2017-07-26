package org.zhao.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.zhao.controller.base.BaseController;
import org.zhao.entity.Account;
import org.zhao.entity.page.AccountPage;
import org.zhao.service.AccountService;

@Controller
@RequestMapping("/account")
@SessionAttributes("accountPage")
public class AccountController extends BaseController {
	@Resource
	private AccountService accountService;

	@RequestMapping("/findDetail.do")
	public String findDetail(Integer id, Model model) {
		Account account = accountService.findById(id);
		model.addAttribute("a", account);
		return "account/account_detail";
	}

	@RequestMapping("/updateStart.do")
	@ResponseBody
	public boolean updateStart(Integer id) {
		accountService.updateStart(id);
		return true;
	}

	@RequestMapping("/updateDelete.do")
	@ResponseBody
	public boolean updateDelete(Integer id) {
		accountService.updateDelete(id);
		return true;
	}

	@RequestMapping("/updatePause.do")
	@ResponseBody
	public boolean updatePause(Integer id) {
		accountService.updatePause(id);
		return true;
	}

	@RequestMapping("/updateAccount.do")
	@ResponseBody
	public boolean updateAccount(Account account) {
		accountService.updateAccount(account);
		return true;
	}

	@RequestMapping("/checkPwd.do")
	@ResponseBody
	public Map<String, Object> checkPwd(Integer id, String pwd) {
		Map<String, Object> map = accountService.checkPwd(id, pwd);
		return map;
	}

	@RequestMapping("/findByIdentityCard.do")
	@ResponseBody
	public Map<String, Object> findByIdentityCard(String id) {
		Map<String, Object> map = accountService.findByIdentityCard(id);
		return map;
	}

	@RequestMapping("/save.do")
	@ResponseBody
	public boolean save(Account account) {
		accountService.save(account);
		return true;
	}

	@RequestMapping("/toModify.do")
	public String toModify(Integer id, Model model) {
		Account account = accountService.findById(id);
		model.addAttribute("a", account);
		return "account/account_modify";
	}

	@RequestMapping("/toAdd.do")
	public String toAdd() {
		return "account/account_add";
	}

	@RequestMapping("/findAccount.do")
	public String findAll(AccountPage page, Model model) {
		List<Account> list = accountService.findByPage(page);
		model.addAttribute("accounts", list);
		model.addAttribute("accountPage", page);
		return "account/account";
	}
}
