package com.wpdrc.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.wpdrc.enums.OrderStatus;
import com.wpdrc.mapper.OrderMapper;
import com.wpdrc.pojo.HistoryOrder;
import com.wpdrc.pojo.HistoryOrderDetail;
import com.wpdrc.pojo.Order;
import com.wpdrc.pojo.OrderDetail;

@Service("OrderServiceImpl")
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private OrderDetailService orderDetailService;

    @Autowired
    private HistoryOrderService historyOrderService;

    @Autowired
    private HistoryOrderDetailService historyOrderDetailService;

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

    public Order detail(Integer id) {
        Order order = orderMapper.findById(id);
        order.setDetailList(orderDetailService.selectByOrderId(id));
        return order;
    }

    @Transactional
    public void del(Integer id) {
        Order order = orderMapper.findById(id);
        order.setStatus(OrderStatus.DELETE.getCode());
        buildHisData(order);
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
            orderMapper.update(order);
        } else if (order.getOrderType().equals("堂食") && order.getStatus().equals(OrderStatus.RUNNING.getCode())) {
            order.setStatus(OrderStatus.BUY.getCode());
            buildHisData(order);
        } else {
            throw new RuntimeException("非法请求");
        }
    }

    @Transactional
    public void pickup(Integer id) {
        Order order = orderMapper.findById(id);

        if (order.getOrderType().equals("打包") && order.getStatus().equals(OrderStatus.BUY_NOT_GET.getCode())) {
            order.setStatus(OrderStatus.BUY_GET.getCode());
            buildHisData(order);
        } else {
            throw new RuntimeException("非法请求");
        }
    }

    /**
     * 构建历史数据，生成历史数据并且删除订单信息.
     * 
     * @param order
     */
    @Transactional
    private void buildHisData(Order order) {
        HistoryOrder historyOrder = new HistoryOrder();
        BeanUtils.copyProperties(order, historyOrder);

        List<OrderDetail> orderDetails = orderDetailService.selectByOrderId(order.getId());
        List<HistoryOrderDetail> historyOrderDetails = new ArrayList<HistoryOrderDetail>();
        for (OrderDetail orderDetail : orderDetails) {
            HistoryOrderDetail historyOrderDetail = new HistoryOrderDetail();
            BeanUtils.copyProperties(orderDetail, historyOrderDetail);
            historyOrderDetails.add(historyOrderDetail);
        }

        // 删除现有数据，插入历史数据
        orderMapper.del(order.getId());
        orderDetailService.delByOrderId(order.getId());

        historyOrderService.add(historyOrder);
        if (!historyOrderDetails.isEmpty()) {
            historyOrderDetailService.batchInsert(historyOrderDetails);
        }
    }

}
