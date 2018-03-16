package com.wpdrc.service;

import java.util.List;

import com.wpdrc.pojo.HistoryOrderDetail;

public interface HistoryOrderDetailService {
    void batchInsert(List<HistoryOrderDetail> details);
    
    List<HistoryOrderDetail> selectByOrderId(Integer orderId);
}