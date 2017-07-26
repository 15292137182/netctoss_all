package org.zhao.test;

import java.util.List;

import org.junit.Test;
import org.zhao.dao.CostDao;
import org.zhao.entity.Cost;
import org.zhao.entity.page.CostPage;
import org.zhao.service.CostService;
import org.zhao.util.InitSpringContainer;

public class TestCost {
	CostService costService = InitSpringContainer.getContext().getBean(
			"costServiceImpl", CostService.class);
	CostDao costDao = InitSpringContainer.getContext().getBean("costDao",
			CostDao.class);
	
	@Test
	public void findByPage() {
		CostPage page = new CostPage();
		// page.setPageSize(3);
		// page.setCurrentPage(2);
//		page.setBaseCost("asc");
		page.setBaseDuration("desc");
		List<Cost> list = costService.findByPage(page);
		for (Cost cost : list) {
			System.out.println(cost.getBase_duration() + " "
					+ cost.getBase_cost() + " " + cost.getCost_id() + " "
					+ cost.getName() + " " + cost.getCreatime());
		}
	}

	@Test
	public void updateCost() {
		Cost cost = new Cost();
		cost.setCost_id(100);
		cost.setName("998包月");
		cost.setBase_duration(998);
		cost.setBase_cost(998.99);
		cost.setUnit_cost(889.22);
		cost.setCost_type("1");
		cost.setDescr("agasg");

		costService.updateCost(cost);
	}

	@Test
	public void findAll() {
		List<Cost> list = costDao.findAll();
		for (Cost cost : list) {
			System.out.println(cost.getCost_id() + " " + cost.getName());
		}
	}

	@Test
	public void findById() {
		Cost cost = costService.findById(5);
		System.out.println(cost.getCost_id() + " " + cost.getName() + " "
				+ cost.getCost_type());
	}

	@Test
	public void delete() {
		costService.delete(114);
	}

	@Test
	public void updateStatus() {
		costService.updateStatus(5);
	}

	@Test
	public void save() {
		Cost cost = new Cost();
		cost.setName("998元套餐");
		cost.setBase_duration(998);
		cost.setUnit_cost(998.99);
		cost.setDescr("helloworld");
		cost.setBase_cost(8888.8);
		costService.save(cost);
	}

	@Test
	public void findRows() {
		CostPage page = new CostPage();
		page.setCurrentPage(2);
		System.out.println(costService.findRows(page));
	}

}
