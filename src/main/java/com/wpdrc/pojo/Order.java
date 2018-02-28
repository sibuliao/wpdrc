package com.wpdrc.pojo;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.wpdrc.enums.OrderStatus;

public class Order {
	private Integer id;
	private String orderType;
	private Integer deskNum;
	private String remarks;
	private String detail;
	private Integer status;
	private String statusStr;
	private Date createTime;
	private String createTimeStr;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getStatusStr() {
		return OrderStatus.getDescByCode(this.status);
	}

	public Date getCreateTime() {
		return createTime;
	}

	public Integer getStatus() {
		return status;
	}

	public String getCreateTimeStr() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return sdf.format(this.createTime);
	}

	public void setStatus(Integer status) {
		this.status = status;
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

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	@Override
	public String toString() {
		return "Order [orderType=" + orderType + ", deskNum=" + deskNum + ", remarks=" + remarks + ", detail=" + detail
				+ "]";
	}
}
