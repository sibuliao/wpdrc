package com.wpdrc.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wpdrc.mapper.OrderReportDayMapper;
import com.wpdrc.mapper.ProductReportDayMapper;

@Service("ReportServiceImpl")
public class ReportServiceImpl implements ReportService {

	@Autowired
	private OrderReportDayMapper orderReportDayMapper;

	@Autowired
	private ProductReportDayMapper productReportDayMapper;

	public Map<String, Object> getTodayData() {
		Map<String, Object> result = new HashMap<String, Object>();
		java.sql.Date day = new java.sql.Date(System.currentTimeMillis());
		result.put("salesStatistics", orderReportDayMapper.selectByDate(day));

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("day", day);
		param.put("topNum", 5);
		result.put("salesNumTop", productReportDayMapper.selectSalesNumTop(param));
		result.put("salesSumTop", productReportDayMapper.selectSalesSumTop(param));
		return result;
	}

}
