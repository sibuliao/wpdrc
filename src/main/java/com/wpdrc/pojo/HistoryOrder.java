package com.wpdrc.pojo;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 历史订单.
 * 
 * @author liubaoyu
 *
 */
public class HistoryOrder {
    private Integer id;
    private String orderType;
    private Integer deskNum;
    private String remarks;
    private String statusStr;
    private Date createTime;
    private String createTimeStr;
    private List<HistoryOrderDetail> detailList;

    public List<HistoryOrderDetail> getDetailList() {
        return detailList;
    }

    public void setDetailList(List<HistoryOrderDetail> detailList) {
        this.detailList = detailList;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public String getCreateTimeStr() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sdf.format(this.createTime);
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getOrderType() {
        return orderType;
    }

    public void setOrderType(String orderType) {
        this.orderType = orderType;
    }

    public Integer getDeskNum() {
        return deskNum;
    }

    public void setDeskNum(Integer deskNum) {
        this.deskNum = deskNum;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getStatusStr() {
        return statusStr;
    }

    public void setStatusStr(String statusStr) {
        this.statusStr = statusStr;
    }

    public void setCreateTimeStr(String createTimeStr) {
        this.createTimeStr = createTimeStr;
    }

    @Override
    public String toString() {
        return "HistoryOrder [id=" + id + ", orderType=" + orderType + ", deskNum=" + deskNum + ", remarks=" + remarks
                + ", statusStr=" + statusStr + ", createTime=" + createTime + ", createTimeStr=" + createTimeStr
                + ", detailList=" + detailList + "]";
    }
}
