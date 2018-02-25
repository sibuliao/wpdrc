package com.wpdrc.service;

import java.util.List;

import com.wpdrc.pojo.Category;

public interface CategoryService {
	List<Category> select();
	
	Category find(Integer id);
	
	void delCategory(Integer id);
	
	void add(String name);
	
	void update(Category category);
}