package com.wpdrc.service;

import java.util.List;

import com.wpdrc.pojo.Order;

public interface OrderService {
	void add(Order order);

	List<Order> currList();

	List<Order> select(Integer currPage, Integer pageSize);
	
	int count();
}