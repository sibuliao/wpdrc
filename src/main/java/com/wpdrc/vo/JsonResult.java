package com.wpdrc.vo;

public class JsonResult {
	private int status;
	private String msg;
	private Object data;

	enum Status {
		SUCCESS(0, "success"), FAIL(1, "fail");
		private int status;
		private String msg;

		private Status(int status, String msg) {
			this.status = status;
			this.msg = msg;
		}

		public int getStatus() {
			return status;
		}

		public void setStatus(int status) {
			this.status = status;
		}

		public String getMsg() {
			return msg;
		}

		public void setMsg(String msg) {
			this.msg = msg;
		}

	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getMsg() {
		return msg;
	}

	public JsonResult setMsg(String msg) {
		this.msg = msg;
		return this;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

	public static JsonResult buildSuccessJsonResult() {
		JsonResult result = new JsonResult();
		result.setStatus(Status.SUCCESS.getStatus());
		result.setMsg(Status.SUCCESS.getMsg());
		return result;
	}

	public static JsonResult buildFailJsonResult() {
		JsonResult result = new JsonResult();
		result.setStatus(Status.FAIL.getStatus());
		result.setMsg(Status.FAIL.getMsg());
		return result;
	}

	public static JsonResult buildSuccessJsonResult(Object data) {
		JsonResult result = buildSuccessJsonResult();
		result.setData(data);
		return result;
	}

	public static JsonResult buildFailJsonResult(Object data) {
		JsonResult result = buildFailJsonResult();
		result.setData(data);
		return result;
	}
}
