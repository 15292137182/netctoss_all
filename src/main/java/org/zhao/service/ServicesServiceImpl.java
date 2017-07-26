package org.zhao.service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.zhao.dao.AccountDao;
import org.zhao.dao.ServiceDao;
import org.zhao.entity.Account;
import org.zhao.entity.Services;
import org.zhao.entity.page.ServicePage;

@Service
public class ServicesServiceImpl implements ServicesService {
	@Resource
	private ServiceDao serviceDao;
	@Resource
	private AccountDao accountDao;

	public Map<String, Object> findAllById(int id) {
		return serviceDao.findAllById(id);
	}

	public List<Services> findById(Services id) {
		return serviceDao.findById(id);
	}

	// public Services findById(Services id) {
	// return serviceDao.findById(id);
	// }

	public void updateDelete(List<Integer> ids) {
		Services services = new Services();
		services.setServiceIds(ids);
		services.setStatus("2");
		updateStatus(services);
	}

	// public void updateDelete(Integer id) {
	// Services services = new Services();
	// services.setService_id(id);
	// services.setStatus("2");
	// updateStatus(services);
	// }

	public void updatePause(List<Integer> ids) {
		Services services = new Services();
		services.setServiceIds(ids);
		services.setStatus("1");
		updateStatus(services);
	}

	public Map<String, Object> updateStart(List<Integer> id) {
		Map<String, Object> map = new HashMap<String, Object>();
		// List<Integer> ids=new ArrayList<Integer>();
		Services services = new Services();
		for (Integer serviceId : id) {
			services.setService_id(serviceId);
		}
		services.setServiceIds(id);
		List<Services> s = findById(services);
		Account account = null;
		if (s.size() > 0) {
			for (Services accountId : s) {
				account = accountDao.findById(accountId.getAccount_id());
			}
		}
		if (!account.getStatus().equals("0")) {
			map.put("status", 1);
			map.put("msg", "账务账号还未开通,不能开通其下属的业务账号");
			return map;
		}
		services.setStatus("0");
		updateStatus(services);
		map.put("status", 0);
		map.put("msg", "开通业务账号成功~");
		return map;
	}

	// public Map<String, Object> updateStart(Integer id) {
	// Map<String, Object> map = new HashMap<String, Object>();
	// Services services = new Services();
	// services.setService_id(id);
	// Services s = findById(services);
	// Account account = accountDao.findById(s.getAccount_id());
	// if (!account.getStatus().equals("0")) {
	// map.put("status", 1);
	// map.put("msg", "账务账号还未开通,不能开通其下属的业务账号");
	// return map;
	// }
	// services.setStatus("0");
	// updateStatus(services);
	// map.put("status", 0);
	// map.put("msg", "开通业务账号成功~");
	// return map;
	// }

	public void updateStatus(Services services) {
		serviceDao.updateStatus(services);
	}

	public void save(Services services) {
		services.setStatus("0");
		services.setCreate_date(new Timestamp(System.currentTimeMillis()));
		serviceDao.save(services);
	}

	public int findRows(ServicePage page) {
		return serviceDao.findRows(page);
	}

	public List<Map<String, Object>> findByPage(ServicePage page) {
		page.setRows(findRows(page));
		return serviceDao.findByPage(page);
	}
}
