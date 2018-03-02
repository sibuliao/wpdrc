package com.wpdrc.mapper;

import java.util.List;

import com.wpdrc.pojo.OrderDetail;

public interface OrderDetailMapper {

    void batchInsert(List<OrderDetail> details);

    List<OrderDetail> selectByOrderId(Integer orderId);
    
    void delByOrderId(Integer orderId);
}
