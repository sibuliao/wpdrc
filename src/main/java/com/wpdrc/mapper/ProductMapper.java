package com.wpdrc.mapper;

import java.util.List;

import com.wpdrc.pojo.Product;
import com.wpdrc.vo.Pager;

public interface ProductMapper {
	List<Product> select(Pager pager);
	
	List<Product> selectAll();

	int existProduct(int categoryId);

	int count();

	void add(Product product);
	
	void update(Product product);

	void delProduct(Integer id);
	
	Product find(Integer id);
}
