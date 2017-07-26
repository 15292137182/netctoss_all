package org.zhao.service;

import java.sql.Timestamp;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.zhao.dao.CostDao;
import org.zhao.entity.Cost;
import org.zhao.entity.page.CostPage;

@Service
public class CostServiceImpl implements CostService {
	@Resource
	private CostDao costDao;

	public void updateCost(Cost cost) {
		costDao.updateCost(cost);
	}

	public List<Cost> findAll() {
		return costDao.findAll();
	}

	public Cost findById(Integer id) {
		return costDao.findById(id);
	}

	public void delete(Integer id) {
		costDao.delete(id);
	}

	public void updateStatus(Integer id) {
		costDao.updateStatus(id);
	}

	public void save(Cost cost) {
		cost.setStatus("0");
		cost.setCreatime(new Timestamp(System.currentTimeMillis()));
		costDao.save(cost);
	}

	public int findRows(CostPage page) {
		return costDao.findRows(page);
	}

	public List<Cost> findByPage(CostPage page) {
		page.setRows(findRows(page));
		return costDao.findByPage(page);
	}

}
