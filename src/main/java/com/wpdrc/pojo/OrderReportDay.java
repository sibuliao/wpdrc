package com.wpdrc.pojo;

import java.util.Date;

public class OrderReportDay {
	private Date day;
	private Float sales;
	private Integer orderCount;
	private Integer orderCountTangshi;
	private Integer orderCountDabao;

	public Date getDay() {
		return day;
	}

	public void setDay(Date day) {
		this.day = day;
	}

	public Float getSales() {
		return sales;
	}

	public void setSales(Float sales) {
		this.sales = sales;
	}

	public Integer getOrderCount() {
		return orderCount;
	}

	public void setOrderCount(Integer orderCount) {
		this.orderCount = orderCount;
	}

	public Integer getOrderCountTangshi() {
		return orderCountTangshi;
	}

	public void setOrderCountTangshi(Integer orderCountTangshi) {
		this.orderCountTangshi = orderCountTangshi;
	}

	public Integer getOrderCountDabao() {
		return orderCountDabao;
	}

	public void setOrderCountDabao(Integer orderCountDabao) {
		this.orderCountDabao = orderCountDabao;
	}
}
