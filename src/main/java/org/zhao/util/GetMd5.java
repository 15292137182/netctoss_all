package org.zhao.util;

import org.apache.commons.codec.digest.DigestUtils;
import org.junit.Test;

public class GetMd5 {

	@Test
	public void test() {
		System.out.println(getMd5());
		String pwd = "pioneer998";
		// 3276d4e2cbdfaf3715777e7da85bcace
		System.out.println(getMd5(pwd));
	}

	public static String getMd5(String pwd) {
		return DigestUtils.md5Hex(pwd);
	}

	public static String getMd5() {
		// 3276d4e2cbdfaf3715777e7da85bcace
		return DigestUtils.md5Hex("pioneer998");
	}

}
