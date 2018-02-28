package com.wpdrc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.wpdrc.mapper.OrderMapper;
import com.wpdrc.pojo.Order;
import com.wpdrc.pojo.OrderDetail;

@Service("OrderServiceImpl")
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderMapper orderMapper;
	
	@Autowired
	private OrderDetailService orderDetailService;

	@Transactional
	public void add(Order order) {
		orderMapper.add(order);

		List<OrderDetail> details = JSON.parseArray(order.getDetail(), OrderDetail.class);
		if (!details.isEmpty()) {
			for (OrderDetail od : details) {
				od.setOrderId(order.getId());
			}
			
			orderDetailService.batchInsert(details);
		}
	}

}
