package org.zhao.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.zhao.entity.Module;

public class IsPowerInterceptor implements HandlerInterceptor {

	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {

	}

	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {

	}

	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object object) throws Exception {
		Integer currentModule = (Integer) request.getSession().getAttribute(
				"currentModule");
		@SuppressWarnings("unchecked")
		List<Module> modulesOfAdmin = (List<Module>) request.getSession()
				.getAttribute("modulesOfAdmin");
		if (modulesOfAdmin == null) {
			response.sendRedirect(request.getContextPath() + "/login/toLogin.do");
			return false;
		}
		for (Module modules : modulesOfAdmin) {
			if (modules.getModule_id() == currentModule) {
				return true;
			}
		}
		response.sendRedirect(request.getContextPath() + "/user/nopower.do");
		return false;
	}

}
