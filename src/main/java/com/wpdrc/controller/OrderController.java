package com.wpdrc.controller;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wpdrc.bo.JsonResult;
import com.wpdrc.pojo.Order;
import com.wpdrc.service.OrderService;

@Controller
@RequestMapping("/order")
public class OrderController {

	@Autowired
	private OrderService orderService;

	@RequestMapping("/add")
	@ResponseBody
	public JsonResult add(Order order) {
		if (StringUtils.isBlank(order.getOrderType())) {
			return JsonResult.buildFailJsonResult().setMsg("订单类型不能为空");
		}

		if (order.getOrderType().equals("堂食") && null == order.getDeskNum()) {
			return JsonResult.buildFailJsonResult().setMsg("桌号不能为空");
		}

		orderService.add(order);
		return JsonResult.buildSuccessJsonResult();
	}

}
