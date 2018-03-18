package com.wpdrc.mapper;

import java.util.List;

import com.wpdrc.pojo.Order;
import com.wpdrc.vo.Pager;

public interface OrderMapper {

	void add(Order order);

	void update(Order order);

	List<Order> currList();

	List<Order> select(Pager pager);

	int count();

	Order findById(Integer id);

	void del(Integer id);

}
