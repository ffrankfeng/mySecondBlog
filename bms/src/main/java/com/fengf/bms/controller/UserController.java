package com.fengf.bms.controller;

import com.fengf.bms.pojo.Admin;
import com.fengf.bms.pojo.ArticleVo;
import com.fengf.bms.pojo.UserQueryVo;
import com.fengf.bms.pojo.Users;
import com.fengf.bms.service.ArticleService;
import com.fengf.bms.service.UserService;
import com.fengf.common.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private ArticleService articleService;




    @RequestMapping(value="/user")
    public String hotuser(UserQueryVo vo, Model model){
        Page<Users> page = userService.selectAllPage(vo);
        model.addAttribute("page", page);
        return "user";
    }

//    @RequestMapping("/item/cat/list")
//    @ResponseBody
//    public List<EasyUITreeNode> getItemCatList(
//            @RequestParam(name="id", defaultValue="0")Long parentId) {
//        //调用服务查询节点列表
//        List<EasyUITreeNode> list = itemCatService.getItemCatlist(parentId);
//        return list;
//
//    }
//    public TbItem getItemById(@PathVariable Long itemId) {
//        TbItem tbItem = itemService.getItemById(itemId);
//        return tbItem;
//    }
}
