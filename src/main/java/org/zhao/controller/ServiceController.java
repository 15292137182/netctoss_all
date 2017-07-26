package org.zhao.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.zhao.entity.Cost;
import org.zhao.entity.Services;
import org.zhao.entity.page.ServicePage;
import org.zhao.service.AccountService;
import org.zhao.service.CostService;
import org.zhao.service.ServicesService;

@Controller
@RequestMapping("/service")
@SessionAttributes("servicePage")
public class ServiceController {

	@Resource
	private ServicesService service;
	@Resource
	private CostService costService;
	@Resource
	private AccountService accountService;

	@RequestMapping("/findDetail.do")
	public String findDetail(Integer id, Model model) {
		Map<String, Object> map = service.findAllById(id);
		model.addAttribute("s", map);
		return "service/service_detail";
	}

	@RequestMapping("/updateDelete.do")
	@ResponseBody
	public boolean updateDelete(Integer id) {
		List<Integer> list = new ArrayList<Integer>();
		list.add(id);
		service.updateDelete(list);
		return true;
	}

	@RequestMapping("/updatePause.do")
	@ResponseBody
	public boolean updatePause(Integer id) {
		List<Integer> list = new ArrayList<Integer>();
		list.add(id);
		service.updatePause(list);
		return true;
	}

	@RequestMapping("/updateStart.do")
	@ResponseBody
	public Map<String, Object> updateStart(Integer id) {
		List<Integer> list = new ArrayList<Integer>();
		list.add(id);
		Map<String, Object> map = service.updateStart(list);
		return map;
	}

	@RequestMapping("/save.do")
	@ResponseBody
	public boolean save(Services services) {
		service.save(services);
		return true;
	}

	@RequestMapping("/findByIdentityCard.do")
	@ResponseBody
	public Map<String, Object> findByIdentityCard(String idCard) {
		return accountService.findByIdentityCard(idCard);
	}

	@RequestMapping("/toModify.do")
	public String toModify() {
		return "service/service_modify";
	}

	@RequestMapping("/toAdd.do")
	public String toAdd(Model model) {
		List<Cost> costs = costService.findAll();
		model.addAttribute("costs", costs);
		return "service/service_add";
	}

	@RequestMapping("/findService.do")
	public String findAll(ServicePage page, Model model) {
		List<Map<String, Object>> maps = service.findByPage(page);
		model.addAttribute("services", maps);
		model.addAttribute("servicePage", page);
		return "service/service";
	}
}
