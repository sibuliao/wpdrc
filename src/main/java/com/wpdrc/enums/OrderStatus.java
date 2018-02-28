package com.wpdrc.enums;

public enum OrderStatus {
	RUNNING(0, "进行中"), BUY(1, "已买单"), DELETE(2, "删除"), BUY_NOT_GET(3, "已付款未取货"), BUY_GET(4, "已付款已取货");

	private Integer code;
	private String desc;

	private OrderStatus(Integer code, String desc) {
		this.code = code;
		this.desc = desc;
	}

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public static String getDescByCode(Integer code) {
		for (OrderStatus os : OrderStatus.values()) {
			if (os.getCode().equals(code)) {
				return os.getDesc();
			}
		}
		return "";
	}

}
