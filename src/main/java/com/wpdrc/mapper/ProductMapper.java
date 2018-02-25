package com.wpdrc.mapper;

import java.util.List;

import com.wpdrc.bo.Pager;
import com.wpdrc.pojo.Product;

public interface ProductMapper {
	List<Product> select(Pager pager);

	int existProduct(int categoryId);

	int count();

	void add(Product product);
	
	void update(Product product);

	void delProduct(Integer id);
	
	Product find(Integer id);
}
