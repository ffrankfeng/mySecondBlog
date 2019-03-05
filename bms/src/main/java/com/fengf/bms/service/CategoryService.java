package com.fengf.bms.service;

import com.fengf.bms.pojo.Admin;
import com.fengf.bms.pojo.Category;
import com.fengf.common.utils.Page;

import java.util.List;

public interface CategoryService {
    List<Category> selectAllPage();
}
