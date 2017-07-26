package org.zhao.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/bill")
public class BillController {

	@RequestMapping("/findBill.do")
	public String findAll() {
		return "bill/bill";
	}
}
