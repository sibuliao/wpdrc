package com.wpdrc.mapper;

import com.wpdrc.pojo.OrderReportDay;

public interface OrderReportDayMapper {
	OrderReportDay selectByDate(java.sql.Date day);
}
