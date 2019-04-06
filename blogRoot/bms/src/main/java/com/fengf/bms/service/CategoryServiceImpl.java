package com.fengf.bms.service;

import com.fengf.bms.mapper.CategoryMapper;
import com.fengf.bms.pojo.Admin;
import com.fengf.bms.pojo.Category;
import com.fengf.common.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService{
    @Autowired
    private CategoryMapper categoryMapper;
    @Override
    public List<Category> selectAllPage() {
        return categoryMapper.selectAllCategory();
    }
}
