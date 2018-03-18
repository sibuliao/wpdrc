package com.wpdrc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wpdrc.mapper.HistoryOrderMapper;
import com.wpdrc.pojo.HistoryOrder;
import com.wpdrc.pojo.Order;
import com.wpdrc.vo.Pager;

@Service("HistoryOrderServiceImpl")
public class HistoryOrderServiceImpl implements HistoryOrderService {

    @Autowired
    private HistoryOrderMapper historyOrderMapper;
    
    @Autowired
    private HistoryOrderDetailService historyOrderDetailService;

    @Transactional
    public void add(HistoryOrder historyOrder) {
        historyOrderMapper.add(historyOrder);
    }

    
    public List<HistoryOrder> select(Integer currPage, Integer pageSize) {
        int begin = (currPage - 1) * pageSize;
        int end = pageSize;
        return historyOrderMapper.select(Pager.build(begin, end));
    }

    public int count() {
        return historyOrderMapper.count();
    }
    
    public HistoryOrder detail(Integer id) {
        HistoryOrder historyOrder = historyOrderMapper.findById(id);
        historyOrder.setDetailList(historyOrderDetailService.selectByOrderId(id));
        return historyOrder;
    }
}
