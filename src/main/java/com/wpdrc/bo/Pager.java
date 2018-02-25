package com.wpdrc.bo;

public class Pager {
	private Integer begin;
	private Integer end;

	public Integer getBegin() {
		return begin;
	}

	public void setBegin(Integer begin) {
		this.begin = begin;
	}

	public Integer getEnd() {
		return end;
	}

	public void setEnd(Integer end) {
		this.end = end;
	}

	public static Pager build(int begin, int end) {
		Pager result = new Pager();
		result.setBegin(begin);
		result.setEnd(end);
		return result;
	}
}
