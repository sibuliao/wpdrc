package com.wpdrc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wpdrc.service.ReportService;
import com.wpdrc.vo.JsonResult;

@Controller
@RequestMapping("/report")
public class ReportController {

	@Autowired
	private ReportService reportService;

	@RequestMapping("/getTodayData")
	@ResponseBody
	public JsonResult getTodayData() {
		return JsonResult.buildSuccessJsonResult(reportService.getTodayData());
	}

}
