package org.zhao.dao;

import java.util.List;

import org.zhao.entity.Cost;
import org.zhao.entity.page.CostPage;

public interface CostDao {
	
	void updateCost(Cost cost);

	List<Cost> findAll();

	Cost findById(Integer id);

	void delete(Integer id);

	void updateStatus(Integer id);

	void save(Cost cost);

	int findRows(CostPage page);

	List<Cost> findByPage(CostPage page);

}
