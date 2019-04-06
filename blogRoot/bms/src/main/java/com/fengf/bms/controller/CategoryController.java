package com.fengf.bms.controller;

import com.fengf.bms.pojo.Admin;
import com.fengf.bms.pojo.AdminQueryVo;
import com.fengf.bms.pojo.Category;
import com.fengf.bms.service.CategoryService;
import com.fengf.common.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class CategoryController {

    @Autowired
    private CategoryService categoryService;
    @RequestMapping(value="/category")
    public String hotuser(Model model){
        List<Category> page = categoryService.selectAllPage();
        model.addAttribute("page", page);
        return "category";
    }
}
