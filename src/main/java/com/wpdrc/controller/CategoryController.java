package com.wpdrc.controller;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wpdrc.pojo.Category;
import com.wpdrc.service.CategoryService;
import com.wpdrc.service.ProductService;
import com.wpdrc.vo.JsonResult;

@Controller
@RequestMapping("/category")
public class CategoryController {

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private ProductService productService;

	@RequestMapping("/list")
	@ResponseBody
	public JsonResult list() {
		return JsonResult.buildSuccessJsonResult(categoryService.select());
	}

	@RequestMapping("/find")
	@ResponseBody
	public JsonResult find(Integer id) {
		return JsonResult.buildSuccessJsonResult(categoryService.find(id));
	}

	@RequestMapping("/delCategory")
	@ResponseBody
	public JsonResult delCategory(Integer id) {
		if (productService.existProduct(id)) {
			return JsonResult.buildFailJsonResult().setMsg("该类别下存在商品");
		} else {
			categoryService.delCategory(id);
			return JsonResult.buildSuccessJsonResult();
		}
	}

	@RequestMapping("/add")
	@ResponseBody
	public JsonResult add(String name) {
		if (StringUtils.isBlank(name)) {
			return JsonResult.buildFailJsonResult().setMsg("类别名称不能为空");
		} else {
			try {
				categoryService.add(name);
			} catch (DuplicateKeyException e) {
				return JsonResult.buildFailJsonResult().setMsg("类别已存在");
			} catch (Exception e) {
				return JsonResult.buildFailJsonResult().setMsg("添加失败");
			}

			return JsonResult.buildSuccessJsonResult();
		}
	}

	@RequestMapping("/update")
	@ResponseBody
	public JsonResult update(Category category) {
		if (StringUtils.isBlank(category.getName())) {
			return JsonResult.buildFailJsonResult().setMsg("类别名称不能为空");
		}

		try {
			categoryService.update(category);
		} catch (DuplicateKeyException e) {
			return JsonResult.buildFailJsonResult().setMsg("类别已存在");
		} catch (Exception e) {
			return JsonResult.buildFailJsonResult().setMsg("添加失败");
		}

		return JsonResult.buildSuccessJsonResult();
	}

}
