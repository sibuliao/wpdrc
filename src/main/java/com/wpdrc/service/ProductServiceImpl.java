package com.wpdrc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wpdrc.mapper.ProductMapper;
import com.wpdrc.pojo.Product;

@Service("productServiceImpl")
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductMapper productMapper; 
	
	public List<Product> get() {
		// TODO Auto-generated method stub
		return productMapper.select();
	}

}
