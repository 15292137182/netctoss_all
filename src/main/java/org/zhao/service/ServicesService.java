package org.zhao.service;

import java.util.List;
import java.util.Map;

import org.zhao.entity.Services;
import org.zhao.entity.page.ServicePage;

public interface ServicesService {
	
	Map<String, Object> findAllById(int id);

	List<Services> findById(Services id);

	// Services findById(Services services);

	Map<String, Object> updateStart(List<Integer> id);

	// Map<String, Object> updateStart(Integer id);

	void updatePause(List<Integer> ids);

	// void updatePause(Integer id);

	void updateDelete(List<Integer> id);

	// void updateDelete(Integer id);

	void updateStatus(Services services);

	void save(Services services);

	int findRows(ServicePage page);

	List<Map<String, Object>> findByPage(ServicePage page);

}
