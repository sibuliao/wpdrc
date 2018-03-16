package com.wpdrc.mapper;

import java.util.List;

import com.wpdrc.pojo.HistoryOrderDetail;
import com.wpdrc.pojo.OrderDetail;

public interface HistoryOrderDetailMapper {

    void batchInsert(List<HistoryOrderDetail> details);
    
    List<HistoryOrderDetail> selectByOrderId(Integer orderId);
}
