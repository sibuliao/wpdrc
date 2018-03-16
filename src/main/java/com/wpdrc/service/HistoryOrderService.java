package com.wpdrc.service;

import java.util.List;

import com.wpdrc.pojo.HistoryOrder;

public interface HistoryOrderService {
    void add(HistoryOrder historyOrder);

    List<HistoryOrder> select(Integer currPage, Integer pageSize);

    int count();
    
    HistoryOrder detail(Integer id);
}