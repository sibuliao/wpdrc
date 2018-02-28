package com.wpdrc.pojo;

public class OrderDetail {
	private Integer id;
	private Integer orderId;
	private Integer productId;
	private Float productNum;

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public Float getProductNum() {
		return productNum;
	}

	public void setProductNum(Float productNum) {
		this.productNum = productNum;
	}
}
