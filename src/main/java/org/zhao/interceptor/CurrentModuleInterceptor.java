package org.zhao.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class CurrentModuleInterceptor implements HandlerInterceptor{

	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		
	}

	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		
	}

	public boolean preHandle(HttpServletRequest request , HttpServletResponse response ,
			Object object) throws Exception {
		String url=request.getRequestURL().toString();
		int currentModule=0;
		if (url.contains("role")) {
			currentModule=1;
		}else if (url.contains("admin")) {
			currentModule=2;
		}else if (url.contains("cost")) {
			currentModule=3;
		}else if (url.contains("account")) {
			currentModule=4;
		}else if (url.contains("service")) {
			currentModule=5;
		}else if (url.contains("bill")) {
			currentModule=6;
		}else if (url.contains("report")) {
			currentModule=7;
		}else if (url.contains("user")) {
			currentModule=8;
		}else if (url.contains("updateUserPwd")) {
			currentModule=9;
		}
		request.getSession().setAttribute("currentModule", currentModule);
		return true;
	}

}
