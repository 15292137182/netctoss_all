package org.zhao.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/report")
public class ReportController {

	@RequestMapping("/findReport.do")
	public String findAll() {
		return "report/report";
	}
}
