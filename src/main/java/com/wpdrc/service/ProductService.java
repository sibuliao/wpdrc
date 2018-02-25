package com.wpdrc.service;

import java.util.List;

import com.wpdrc.pojo.Product;

public interface ProductService {
	List<Product> select(Integer currPage, Integer pageSize);

	int count();

	boolean existProduct(int categoryId);

	void add(Product product);
	
	void update(Product product);

	void delProduct(Integer id);
	
	Product find(Integer id);
}
