package org.zhao.util;

import java.beans.PropertyEditorSupport;
import java.sql.Date;
import java.text.SimpleDateFormat;

public class GetDatePattern extends PropertyEditorSupport {
	private String pattern = "yyyy-MM-dd";

	public GetDatePattern() {

	}

	public GetDatePattern(String pattern) {
		this.pattern = pattern;
	}

	public void setAsText(String text) {
		if (text == null || text.length() == 0) {
			setValue(null);
		} else {
			SimpleDateFormat sdf = new SimpleDateFormat(this.pattern);
			String date = sdf.format(Date.valueOf(text));
			setValue(Date.valueOf(date));
		}
	}

}
