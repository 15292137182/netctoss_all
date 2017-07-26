package org.zhao.interceptor;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.zhao.entity.Admin;
import org.zhao.service.AdminService;

public class LoginInterceptor implements HandlerInterceptor {
	@Resource
	private AdminService adminService;

	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {

	}

	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {

	}

	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object object) throws Exception {
		Admin admin = (Admin) request.getSession().getAttribute("admin");
		if (admin == null) {
			response.sendRedirect(request.getContextPath()
					+ "/login/toLogin.do");
			return false;
		}
		boolean flag = adminService.checkToken(admin.getAdmin_id(),
				admin.getToken());
		if (!flag) {
			response.sendRedirect(request.getContextPath()
					+ "/login/toLogin.do");
			return false;
		}
		return true;
	}

}
