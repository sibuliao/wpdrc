package com.wpdrc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wpdrc.mapper.HistoryOrderDetailMapper;
import com.wpdrc.pojo.HistoryOrderDetail;
import com.wpdrc.pojo.OrderDetail;

@Service("HistoryOrderDetailServiceImpl")
public class HistoryOrderDetailServiceImpl implements HistoryOrderDetailService {

    @Autowired
    private HistoryOrderDetailMapper historyOrderDetailMapper;

    @Transactional
    public void batchInsert(List<HistoryOrderDetail> details) {
        historyOrderDetailMapper.batchInsert(details);
    }
    
    public List<HistoryOrderDetail> selectByOrderId(Integer orderId) {
        return historyOrderDetailMapper.selectByOrderId(orderId);
    }
}
