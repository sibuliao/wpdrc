package com.wpdrc.mapper;

import java.util.List;

import com.wpdrc.bo.Pager;
import com.wpdrc.pojo.Order;

public interface OrderMapper {

	void add(Order order);

	List<Order> currList();

	List<Order> select(Pager pager);
	
	int count();

}
