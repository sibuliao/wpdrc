package com.wpdrc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wpdrc.mapper.CategoryMapper;
import com.wpdrc.pojo.Category;

@Service("CategoryServiceImpl")
public class CategoryServiceImpl implements CategoryService {

	@Autowired
	private CategoryMapper categoryMapper;

	public List<Category> select() {
		return categoryMapper.select();
	}

	@Transactional
	public void delCategory(Integer id) {
		categoryMapper.delCategory(id);
	}

	@Transactional
	public void add(String name) {
		categoryMapper.add(name);
	}

	public Category find(Integer id) {
		return categoryMapper.find(id);
	}

	public void update(Category category) {
		categoryMapper.update(category);
	}

}
