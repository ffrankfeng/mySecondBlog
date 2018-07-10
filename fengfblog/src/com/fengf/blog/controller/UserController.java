package com.fengf.blog.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fengf.blog.pojo.UserVo;
import com.fengf.blog.pojo.Users;
import com.fengf.blog.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	private UserService userService;
	
	//注册页面
	@RequestMapping(value="/register",method = RequestMethod.GET)
	public String register(){
		return "register";
	}

	//个人中心
	@RequestMapping(value="/personcenter")
	public String personcenter(Model model,HttpServletRequest request,HttpServletResponse response) throws ParseException{
		HttpSession session = request.getSession();
		return "personcenter";
		
	}
	@RequestMapping(value="/personEdit")
	public void personEdit(Users user,HttpServletRequest request,HttpServletResponse response) throws ParseException, IOException{
		System.out.println("eealkeff ====" +user);
		Users current_user = (Users) request.getSession().getAttribute("current_user");
		current_user.setUserName(user.getUserName());
		current_user.setEmail(user.getEmail());
		current_user.setPhone(user.getPhone());
		current_user.setBirthday(user.getBirthday());
		current_user.setSex(user.getSex());
		current_user.setProfession(user.getProfession());
		current_user.setIntroduction(user.getIntroduction());
		System.out.println(current_user);
		System.out.println(user);
		boolean flag=userService.personEdit(current_user);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		if(flag){
			HttpSession session = request.getSession();
			session.setAttribute("current_user", current_user);
			out.println("<script language='javaScript'> alert('修改成功！');</script>");
			response.setHeader("refresh","0.2;url=index");
		}else{
			out.println("<script language='javaScript'> alert('修改失败，请重新登录！');</script>");
			response.setHeader("refresh","0.2;url=userQuit");
		}
			
		
	}
	//用户名查重
	@RequestMapping(value="/checkUsername",method = RequestMethod.POST)
	public void checkUsername(String userName,HttpServletResponse response) throws IOException{
		boolean flag=userService.checkUsername(userName);
		response.getWriter().write("{\"isExist\":"+flag+"}");
	}
	//核对验证码
	@RequestMapping(value="/checkverificationCode")
	public void checkverificationCode(String verificationCode,HttpServletRequest request,HttpServletResponse response) throws IOException{
		boolean flag=false;
		HttpSession session = request.getSession();
		String checkcode_session=(String) session.getAttribute("checkcode_session");
		if(checkcode_session.equals(verificationCode))
			flag=true;
		System.out.println(flag);
		response.getWriter().write("{\"isCorrect\":"+flag+"}");
	}
	
	//注册
	@RequestMapping(value="/userRegister")
	public void userRegister(Users user,Model model,HttpServletRequest request,HttpServletResponse response) throws IOException{
		boolean flag=userService.userInsert(user);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		if(!flag){
			out.println("<script language='javaScript'> alert('注册失败，请重新添加！');</script>");
			response.setHeader("refresh","0.2;url=register");
		}else{
			Users current_user=userService.userLogin(user);
			if(current_user ==null){
				out.println("<script language='javaScript'> alert('登录失败，请登录！');</script>");
				response.setHeader("refresh","0.2;url=login");
			}else{
				HttpSession session = request.getSession();
				session.setAttribute("current_user", current_user);
				out.println("<script language='javaScript'> alert('注册成功');</script>");
				response.setHeader("refresh","0.2;url=index");
			}
		}
	}
	//登录页面
	@RequestMapping(value="/login",method = RequestMethod.GET)
	public String login(){
		return "login";
	}

	@RequestMapping(value="/userQuit")
	public String userQuit(HttpServletRequest request){
		request.getSession().invalidate();
		return "login";
	}
	//登录
	@RequestMapping(value="/userLogin",method = RequestMethod.POST)
	public String userLogin(Users user,Model model,HttpServletRequest request){
		Users current_user=userService.userLogin(user);
		System.out.println(current_user);
		if(current_user ==null){
			model.addAttribute("loginInfo", "密码不正确");
			return "login";
		}else{
			
			HttpSession session = request.getSession();
			session.setAttribute("current_user", current_user);
		}
		return "redirect:index";
	}
}
