package com.wpdrc.pojo;

import java.util.Date;

public class OrderDetailReportDay {
	private Date day;
	private String productName;
	private Float productNum;
	private Float sales;

	public Date getDay() {
		return day;
	}

	public void setDay(Date day) {
		this.day = day;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public Float getProductNum() {
		return productNum;
	}

	public void setProductNum(Float productNum) {
		this.productNum = productNum;
	}

	public Float getSales() {
		return sales;
	}

	public void setSales(Float sales) {
		this.sales = sales;
	}

}
