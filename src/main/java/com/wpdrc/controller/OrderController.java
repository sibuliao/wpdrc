package com.wpdrc.controller;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wpdrc.pojo.Order;
import com.wpdrc.service.HistoryOrderService;
import com.wpdrc.service.OrderService;
import com.wpdrc.vo.JsonResult;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;
    
    @Autowired
    private HistoryOrderService historyOrderService;

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

	@RequestMapping("/update")
	@ResponseBody
	public JsonResult update(Order order) {
		if (StringUtils.isBlank(order.getOrderType())) {
			return JsonResult.buildFailJsonResult().setMsg("订单类型不能为空");
		}

		if (order.getOrderType().equals("堂食") && null == order.getDeskNum()) {
			return JsonResult.buildFailJsonResult().setMsg("桌号不能为空");
		}

		orderService.update(order);
		return JsonResult.buildSuccessJsonResult();
	}

	@RequestMapping("/del")
	@ResponseBody
	public JsonResult del(Integer id) {
		orderService.del(id);
		return JsonResult.buildSuccessJsonResult();
	}

	@RequestMapping("/currList")
	@ResponseBody
	public JsonResult currList() {
		return JsonResult.buildSuccessJsonResult(orderService.currList());
	}

	@RequestMapping("/detail")
    @ResponseBody
    public JsonResult detail(Integer id) {
        return JsonResult.buildSuccessJsonResult(orderService.detail(id));
    }
	
	@RequestMapping("/historyDetail")
    @ResponseBody
    public JsonResult historyDetail(Integer id) {
        return JsonResult.buildSuccessJsonResult(historyOrderService.detail(id));
    }

	@RequestMapping("/hisList")
	@ResponseBody
	public JsonResult hisList(Integer currPage, Integer pageSize) {
		int total = historyOrderService.count();
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("data", historyOrderService.select(currPage, pageSize));
		Integer totalPage = 0;
		if (total % pageSize == 0) {
			totalPage = total / pageSize;
		} else {
			totalPage = total / pageSize + 1;
		}
		data.put("totalPage", totalPage);
		return JsonResult.buildSuccessJsonResult(data);
	}

	@RequestMapping("/pay")
	@ResponseBody
	public JsonResult pay(Integer id) {
		orderService.pay(id);
		return JsonResult.buildSuccessJsonResult();
	}
	
	@RequestMapping("/pickup")
	@ResponseBody
	public JsonResult pickup(Integer id) {
		orderService.pickup(id);
		return JsonResult.buildSuccessJsonResult();
	}
	
}
