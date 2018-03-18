package com.wpdrc.mapper;

import java.util.List;

import com.wpdrc.pojo.HistoryOrder;
import com.wpdrc.pojo.Order;
import com.wpdrc.vo.Pager;

public interface HistoryOrderMapper {

	void add(HistoryOrder historyOrder);

	List<HistoryOrder> select(Pager pager);

    int count();
    
    HistoryOrder findById(Integer id);
}
