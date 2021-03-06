package com.wpdrc.service;

import java.util.List;

import com.wpdrc.pojo.OrderDetail;

public interface OrderDetailService {
    void batchInsert(List<OrderDetail> details);

    List<OrderDetail> selectByOrderId(Integer orderId);

    void delByOrderId(Integer orderId);

}