package com.wpdrc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wpdrc.mapper.OrderDetailMapper;
import com.wpdrc.pojo.OrderDetail;

@Service("OrderDetailServiceImpl")
public class OrderDetailServiceImpl implements OrderDetailService {

	@Autowired
	private OrderDetailMapper orderDetailMapper;

	@Transactional
	public void batchInsert(List<OrderDetail> details) {
		orderDetailMapper.batchInsert(details);
	}

}
