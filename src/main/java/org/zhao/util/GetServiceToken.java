package org.zhao.util;

import java.util.UUID;

import org.junit.Test;

public class GetServiceToken {

	@Test
	public void test() {
		System.out.println(getUUID());
	}

	public static String getUUID() {
		UUID uuid = UUID.randomUUID();
		return uuid.toString();
	}

}
