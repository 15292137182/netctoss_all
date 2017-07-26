package org.zhao.test;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.zhao.dao.ServiceDao;
import org.zhao.entity.Cost;
import org.zhao.entity.Services;
import org.zhao.entity.page.ServicePage;
import org.zhao.service.ServicesService;
import org.zhao.util.InitSpringContainer;

public class TestService {

	ServicesService servicesService = InitSpringContainer.getContext().getBean(
			"servicesServiceImpl", ServicesService.class);
	ServiceDao serviceDao = InitSpringContainer.getContext().getBean(
			"serviceDao", ServiceDao.class);

	@Test
	public void findAllById() {
		Map<String, Object> map = servicesService.findAllById(2002);
		System.out.println(map.get("SERVICE_ID") + " " + map.get("UNIX_HOST")
				+ " " + map.get("NAME") + " " + map.get("REAL_NAME") + " "
				+ map.get("ACCOUNT_ID"));
	}

	@Test
	public void updateDelete() {
		List<Integer> ids = new ArrayList<Integer>();
		ids.add(2002);
		ids.add(2003);
		ids.add(2004);
		servicesService.updateDelete(ids);
	}

	@Test
	public void updateStatus() {
		Services services = new Services();
		List<Integer> ids = new ArrayList<Integer>();
		services.setAccount_id(1011);
		List<Services> list = servicesService.findById(services);
		for (Services ser : list) {
			Integer id = ser.getService_id();
			ids.add(id);
			services.setServiceIds(ids);
			services.setStatus("0");
			servicesService.updateStatus(services);
		}
	}

	@Test
	public void findById() {
		Services s = new Services();
		s.setAccount_id(1011);
		// s.setService_id(3000);
		List<Services> services = serviceDao.findById(s);
		if (services.size() > 0) {
			for (Services service : services) {
				System.out.println(service.getService_id() + " "
						+ service.getOs_username() + " "
						+ service.getAccount_id() + "  " + service.getStatus());
			}
		}
	}

	// @Test
	// public void findById() {
	// Services s = new Services();
	// // s.setAccount_id(2000);
	// s.setService_id(3000);
	// Services services = serviceDao.findById(s);
	// System.out.println(services.getService_id() + " "
	// + services.getOs_username() + " " + services.getAccount_id());
	// }

	// @Test
	// public void updateStatus() {
	// Services services = new Services();
	// services.setService_id(3000);
	// services.setStatus("0");
	// servicesService.updateStatus(services);
	// }

	@Test
	public void save() {
		Services services = new Services();
		services.setAccount_id(1010);
		services.setOs_username("赵青松");
		services.setLogin_passwd("pioneer998");
		services.setUnix_host("176.49.12.83");
		services.setCost_id(6);
		servicesService.save(services);
	}

	@Test
	public void findRows() {
		ServicePage page = new ServicePage();
		page.setCurrentPage(2);
		System.out.println(servicesService.findRows(page));
	}

	@Test
	public void findByPage() {
		ServicePage page = new ServicePage();
		page.setPageSize(3);
		// page.setCurrentPage(2);
		List<Map<String, Object>> maps = servicesService.findByPage(page);
		for (Map<String, Object> map : maps) {
			System.out.println(map.get("SERVICE_ID") + " "
					+ map.get("UNIX_HOST") + " " + map.get("NAME") + " "
					+ map.get("REAL_NAME") + " " + map.get("ACCOUNT_ID"));

			/*
			 * [{UNIX_HOST=192.168.0.20, NAME=包月, REAL_NAME=guojing,
			 * ACCOUNT_ID=1010, R=1, OS_USERNAME=guojing,
			 * IDCARD_NO=330682196903190613, STATUS=0, SERVICE_ID=2008,
			 * DESCR=每月20元,不限制使用时间},
			 */
		}
	}
}
