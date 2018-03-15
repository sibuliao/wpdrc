package com.wpdrc.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.wpdrc.bo.Pager;
import com.wpdrc.enums.OrderStatus;
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
		List<OrderDetail> batch = new ArrayList<OrderDetail>();
		if (!details.isEmpty()) {
			for (OrderDetail od : details) {
				if (!od.getProductNum().equals(0f)) {
					od.setOrderId(order.getId());
					batch.add(od);
				}
			}

			if (!batch.isEmpty()) {
				orderDetailService.batchInsert(batch);
			}
		}
	}

	public List<Order> currList() {
		return orderMapper.currList();
	}

	public List<Order> select(Integer currPage, Integer pageSize) {
		int begin = (currPage - 1) * pageSize;
		int end = pageSize;
		return orderMapper.select(Pager.build(begin, end));
	}

	public int count() {
		return orderMapper.count();
	}

	public Order detail(Integer id) {
		Order order = orderMapper.findById(id);
		order.setDetailList(orderDetailService.selectByOrderId(id));
		return order;
	}

	@Transactional
	public void del(Integer id) {
		orderMapper.del(id);
	}

	@Transactional
	public void update(Order order) {
		// 删除原来的详情
		orderDetailService.delByOrderId(order.getId());
		// 添加新的详情
		List<OrderDetail> details = JSON.parseArray(order.getDetail(), OrderDetail.class);
		List<OrderDetail> batch = new ArrayList<OrderDetail>();
		if (!details.isEmpty()) {
			for (OrderDetail od : details) {
				if (!od.getProductNum().equals(0f)) {
					od.setOrderId(order.getId());
					batch.add(od);
				}
			}

			if (!batch.isEmpty()) {
				orderDetailService.batchInsert(batch);
			}
		}
		// 更新订单
		orderMapper.update(order);
	}

	@Transactional
	public void pay(Integer id) {
		Order order = orderMapper.findById(id);

		if (order.getOrderType().equals("打包") && order.getStatus().equals(OrderStatus.RUNNING.getCode())) {
			order.setStatus(OrderStatus.BUY_NOT_GET.getCode());
		} else if (order.getOrderType().equals("堂食") && order.getStatus().equals(OrderStatus.RUNNING.getCode())) {
			order.setStatus(OrderStatus.BUY.getCode());
		} else {
			throw new RuntimeException("非法请求");
		}

		orderMapper.update(order);
	}

	@Transactional
	public void pickup(Integer id) {
		Order order = orderMapper.findById(id);

		if (order.getOrderType().equals("打包") && order.getStatus().equals(OrderStatus.BUY_NOT_GET.getCode())) {
			order.setStatus(OrderStatus.BUY_GET.getCode());
		} else {
			throw new RuntimeException("非法请求");
		}

		orderMapper.update(order);
	}

}
