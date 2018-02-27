package com.wpdrc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wpdrc.bo.Pager;
import com.wpdrc.mapper.ProductMapper;
import com.wpdrc.pojo.Product;

@Service("productServiceImpl")
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductMapper productMapper;

	public boolean existProduct(int categoryId) {
		if (0 != productMapper.existProduct(categoryId)) {
			return true;
		} else {
			return false;
		}
	}

	public List<Product> select(Integer currPage, Integer pageSize) {
		int begin = (currPage - 1) * pageSize;
		int end = pageSize;
		return productMapper.select(Pager.build(begin, end));
	}

	public int count() {
		return productMapper.count();
	}

	@Transactional
	public void add(Product product) {
		productMapper.add(product);
	}

	public void delProduct(Integer id) {
		productMapper.delProduct(id);
	}

	public Product find(Integer id) {
		return productMapper.find(id);
	}

	@Transactional
	public void update(Product product) {
		productMapper.update(product);
	}

	public List<Product> selectAll() {
		return productMapper.selectAll();
	}

}
