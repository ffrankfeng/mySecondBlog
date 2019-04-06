package com.fengf.bms.controller;

import com.fengf.bms.pojo.Articlecomment;
import com.fengf.bms.pojo.CommentQueryVo;
import com.fengf.bms.service.CommentService;
import com.fengf.common.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CommentController {
    @Autowired
    CommentService commentService;
    @RequestMapping(value = "/comment",method = RequestMethod.GET)
    public String articlesList(CommentQueryVo vo, Model model){
        Page<Articlecomment> page = commentService.selectAllPage(vo);
        model.addAttribute("page", page);
        return "comment";
    }
}
