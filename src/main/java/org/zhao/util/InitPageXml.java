package org.zhao.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.junit.Test;

public class InitPageXml {

	@Test
	public void test() {
		Map<String, String> map = getPageXml();
		Integer currentPage = Integer.valueOf(map.get("currentPage"));
		Integer pageSize = Integer.valueOf(map.get("pageSize"));
		System.out.println(currentPage + " " + pageSize);
	}

	public static Map<String, String> getPageXml() {
		SAXReader reader = new SAXReader();
		Map<String, String> map = new HashMap<String, String>();
		try {
			Document document = reader.read(InitPageXml.class.getClassLoader()
					.getResourceAsStream("page.xml"));
			Element root = document.getRootElement();
			@SuppressWarnings("unchecked")
			List<Element> elements = root.elements();
			for (Element element : elements) {
				String key = element.getName();
				String value = element.getTextTrim();
				map.put(key, value);
			}
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		return map;
	}
}
