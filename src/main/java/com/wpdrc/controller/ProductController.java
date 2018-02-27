package com.wpdrc.controller;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wpdrc.bo.JsonResult;
import com.wpdrc.pojo.Product;
import com.wpdrc.service.ProductService;

@Controller
@RequestMapping("/product")
public class ProductController {

	@Autowired
	private ProductService productService;

	@RequestMapping("/list")
	@ResponseBody
	public JsonResult list(Integer currPage, Integer pageSize) {
		int total = productService.count();
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("data", productService.select(currPage, pageSize));
		Integer totalPage = 0;
		if (total % pageSize == 0) {
			totalPage = total / pageSize;
		} else {
			totalPage = total / pageSize + 1;
		}
		data.put("totalPage", totalPage);
		return JsonResult.buildSuccessJsonResult(data);
	}

	@RequestMapping("/delProduct")
	@ResponseBody
	public JsonResult delProduct(Integer productId) {
		productService.delProduct(productId);
		return JsonResult.buildSuccessJsonResult();
	}
	
	@RequestMapping("/find")
	@ResponseBody
	public JsonResult find(Integer id) {
		return JsonResult.buildSuccessJsonResult(productService.find(id));
	}
	
	@RequestMapping("/listAll")
	@ResponseBody
	public JsonResult listAll() {
		return JsonResult.buildSuccessJsonResult(productService.selectAll());
	}

	@RequestMapping("/add")
	@ResponseBody
	public JsonResult add(Product product) {
		if (StringUtils.isBlank(product.getName())) {
			return JsonResult.buildFailJsonResult().setMsg("名称不能为空");
		}

		if (product.getPrice() == null) {
			return JsonResult.buildFailJsonResult().setMsg("价格不能为空");
		}

		if (product.getCategoryId() == null) {
			return JsonResult.buildFailJsonResult().setMsg("类别不能为空");
		}

		try {
			productService.add(product);
		} catch (DuplicateKeyException e) {
			return JsonResult.buildFailJsonResult().setMsg("此类别下商品已存在");
		} catch (Exception e) {
			return JsonResult.buildFailJsonResult().setMsg("添加失败");
		}

		return JsonResult.buildSuccessJsonResult();
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public JsonResult update(Product product) {
		if (StringUtils.isBlank(product.getName())) {
			return JsonResult.buildFailJsonResult().setMsg("名称不能为空");
		}

		if (product.getPrice() == null) {
			return JsonResult.buildFailJsonResult().setMsg("价格不能为空");
		}

		if (product.getCategoryId() == null) {
			return JsonResult.buildFailJsonResult().setMsg("类别不能为空");
		}

		try {
			productService.update(product);
		} catch (DuplicateKeyException e) {
			return JsonResult.buildFailJsonResult().setMsg("此类别下商品已存在");
		} catch (Exception e) {
			return JsonResult.buildFailJsonResult().setMsg("添加失败");
		}

		return JsonResult.buildSuccessJsonResult();
	}
}
