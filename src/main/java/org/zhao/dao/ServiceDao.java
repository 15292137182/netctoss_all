package org.zhao.dao;

import java.util.List;
import java.util.Map;

import org.zhao.entity.Services;
import org.zhao.entity.page.ServicePage;

public interface ServiceDao {

	Map<String, Object> findAllById(int id);

	List<Services> findById(Services services);

	// Services findById(Services services);

	void updateStatus(Services services);

	void save(Services services);

	int findRows(ServicePage page);

	List<Map<String, Object>> findByPage(ServicePage page);
}
