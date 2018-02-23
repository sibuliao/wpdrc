package com.wpdrc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wpdrc.service.ProductService;

@Controller
@RequestMapping("/product")
public class ProductController {
	
	@Autowired
	private ProductService productService; 
	
	@RequestMapping("/index")
	public String index() {
		System.out.println(productService.get().get(0).getPrice());
		return "index";
	}
}
