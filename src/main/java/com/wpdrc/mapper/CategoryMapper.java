package com.wpdrc.mapper;

import java.util.List;

import com.wpdrc.pojo.Category;

public interface CategoryMapper {
	List<Category> select();
	
	void delCategory(Integer id);
	
	void add(String name);
	
	Category find(Integer id);
	
	void update(Category category);
}
