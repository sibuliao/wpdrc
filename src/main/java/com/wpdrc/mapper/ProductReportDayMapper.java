package com.wpdrc.mapper;

import java.util.List;
import java.util.Map;

import com.wpdrc.pojo.ProductReportDay;

public interface ProductReportDayMapper {
	/**
	 * 销量Top
	 * 
	 * @return
	 */
	List<ProductReportDay> selectSalesNumTop(Map<String, Object> param);

	/**
	 * 销售额Top
	 * 
	 * @return
	 */
	List<ProductReportDay> selectSalesSumTop(Map<String, Object> param);
}
