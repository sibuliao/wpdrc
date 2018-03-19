package com.wpdrc.mapper;

import java.util.List;
import java.util.Map;

import com.wpdrc.pojo.OrderDetailReportDay;

public interface OrderDetailReportDayMapper {
	/**
	 * 销量Top
	 * 
	 * @return
	 */
	List<OrderDetailReportDay> selectSalesNumTop(Map<String, Object> param);

	/**
	 * 销售额Top
	 * 
	 * @return
	 */
	List<OrderDetailReportDay> selectSalesSumTop(Map<String, Object> param);
}
