package com.fengf.bms.controller;

import com.fengf.bms.pojo.Admin;
import com.fengf.bms.pojo.AdminQueryVo;
import com.fengf.bms.pojo.UserQueryVo;
import com.fengf.bms.pojo.Users;
import com.fengf.bms.service.AdminService;
import com.fengf.common.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class AdminController {

    @Autowired
    private AdminService adminService;



    @RequestMapping(value="/manage-user")
    public String hotuser(AdminQueryVo vo, Model model){
        Page<Admin> page = adminService.selectAllPage(vo);
        model.addAttribute("page", page);
        return "manage-user";
    }
    @RequestMapping(value = "/login",method = RequestMethod.GET)
    public String login(){
        System.out.println("123123");
        return "login";
    }
    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public String login( @RequestParam(name="username", defaultValue="0")String userName ,
                         @RequestParam(name="userpwd", defaultValue="0")String userPwd ,
                         HttpServletRequest request){
        String ip = request.getRemoteAddr();
        System.out.println("ip="+ip);
        Admin USER = adminService.login(userName,userPwd,ip);
        if(USER != null){
            HttpSession session = request.getSession();
            session.setAttribute("USER", USER);
            return "redirect:/index";
        }
        else
            return "login";
    }

}
