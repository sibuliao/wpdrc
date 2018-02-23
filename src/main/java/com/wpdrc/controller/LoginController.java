package com.wpdrc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wpdrc.service.ProductService;

@Controller
@RequestMapping
public class LoginController {
	
	@Autowired
	private ProductService productService; 
	
	@RequestMapping("/login")
	public String index() {
		
		return "login";
	}
}
