package org.zhao.util;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class InitSpringContainer {
	private static final ApplicationContext ac;

	static {
		String config = "applicationContext.xml";
		ac = new ClassPathXmlApplicationContext(config);
	}

	@Test
	public void test() {
		System.out.println(ac);
	}

	public static ApplicationContext getContext() {
		return ac;
	}

}
