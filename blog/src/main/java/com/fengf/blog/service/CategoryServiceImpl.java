package com.fengf.blog.service;

import com.fengf.blog.mapper.CategoryMapper;
import com.fengf.blog.pojo.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService{
    @Autowired
    private CategoryMapper categoryMapper;


    @Override
    public List<Category> selectAllCategory() {
        return categoryMapper.selectAllCategory();

    }
}
