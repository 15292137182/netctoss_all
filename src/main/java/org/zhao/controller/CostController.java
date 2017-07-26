package org.zhao.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zhao.entity.Cost;
import org.zhao.entity.page.CostPage;
import org.zhao.service.CostService;

@Controller
@RequestMapping("/cost")
public class CostController {
	@Resource
	private CostService costService;

	@RequestMapping("/findCostDetail.do")
	public String findCostDetail(Model model, Integer id) {
		Cost cost = costService.findById(id);
		model.addAttribute("c", cost);
		return "cost/cost_detail";
	}

	@RequestMapping("/updateCost.do")
	@ResponseBody
	public boolean updateCost(Cost cost) {
		costService.updateCost(cost);
		return true;
	}

	@RequestMapping("/findById.do")
	@ResponseBody
	public Cost findById(Integer id) {
		Cost cost = costService.findById(id);
		return cost;
	}

	@RequestMapping("/toModify.do")
	public String toModify(Integer id, Model model) {
		Cost cost = costService.findById(id);
		model.addAttribute("cost", cost);
		return "cost/cost_modify";
	}

	@RequestMapping("/delete.do")
	@ResponseBody
	public boolean delete(Integer id) {
		costService.delete(id);
		return true;
	}

	@RequestMapping("/updateStatus.do")
	@ResponseBody
	public boolean updateStatus(Integer id) {
		costService.updateStatus(id);
		return true;
	}

	@RequestMapping("/save.do")
	@ResponseBody
	public boolean save(Cost cost) {
		costService.save(cost);
		return true;
	}

	@RequestMapping("/toAdd.do")
	public String toAdd() {
		return "cost/add_cost";
	}

	@RequestMapping("/findCost.do")
	public String findAll(CostPage page, Model model) {
		List<Cost> list = costService.findByPage(page);
		model.addAttribute("costs", list);
		model.addAttribute("costPage", page);
		return "cost/cost";
	}
}
