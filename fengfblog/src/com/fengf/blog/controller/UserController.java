package com.fengf.blog.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fengf.blog.pojo.ArticleQueryVo;
import com.fengf.blog.pojo.Articles;
import com.fengf.blog.pojo.UserQueryVo;
import com.fengf.blog.pojo.UserVo;
import com.fengf.blog.pojo.Users;
import com.fengf.blog.service.ArticleService;
import com.fengf.blog.service.UserService;
import com.fengf.common.utils.Page;

@Controller
public class UserController {
	
	@Autowired
	private UserService userService;
	//注册页面
	@RequestMapping(value="/register",method = RequestMethod.GET)
	public String register(){
		return "register";
	}
	@RequestMapping(value="/hotuser")
	public String hotuser(UserQueryVo vo,Model model){
		Page<Users>  page = userService.selectAllPage(vo);
		model.addAttribute("page", page);
		return "hotuser";
	}
	//我的关注
	@RequestMapping(value="/myattention")
	public String myattention(UserQueryVo vo,Model model,HttpServletRequest request,HttpServletResponse response) throws ParseException, IOException{
		Users current_user = (Users) request.getSession().getAttribute("current_user");
		vo.setUserId(current_user.getUserId());
		Page<Users>  page = userService.selectAllAttentionPage(vo);
		model.addAttribute("page", page);
		return "myattention";
	}
	//我的fans
	@RequestMapping(value="/myfans")
	public String myfans(UserQueryVo vo,Model model,HttpServletRequest request,HttpServletResponse response) throws ParseException, IOException{
		Users current_user = (Users) request.getSession().getAttribute("current_user");
		vo.setUserId(current_user.getUserId());
		Page<Users>  page = userService.selectAllFansPage(vo);
		model.addAttribute("page", page);
		return "myfans";
	}
	//取消关注
	@RequestMapping(value="/deleteAttention")
	public void deleteAttention(Integer userId,Model model,HttpServletRequest request,HttpServletResponse response) throws ParseException, IOException{
		Users current_user = (Users) request.getSession().getAttribute("current_user");
		boolean flag = userService.deleteAttention(current_user.getUserId(),userId);
		response.getWriter().write("{\"isFinish\":"+flag+"}");
	}
	//关注
	@RequestMapping(value="/attention")
	public void insertAttention(Integer userId,Model model,HttpServletRequest request,HttpServletResponse response) throws ParseException, IOException{
		Users current_user = (Users) request.getSession().getAttribute("current_user");
		boolean flag = userService.insertAttention(current_user.getUserId(),userId);
		response.getWriter().write("{\"isFinish\":"+flag+"}");
		
	}

	//个人中心
	@RequestMapping(value="/myinformation")
	public String myinformation(ArticleQueryVo vo,Model model,HttpServletRequest request,HttpServletResponse response) throws ParseException{
		Users current_user = (Users) request.getSession().getAttribute("current_user");
		Users user = userService.personcenter(current_user.getUserId());
		HttpSession session = request.getSession();
		session.setAttribute("current_user", user);
		vo.setAuthorId(current_user.getUserId());
		Page<Articles>  page = userService.selectUserAllPage(vo);
		model.addAttribute("page", page);
		return "myinformation";	
	}
	
	@RequestMapping(value="/personcenter")
	public String personcenter(ArticleQueryVo vo,Integer userId,Model model,HttpServletRequest request,HttpServletResponse response) throws ParseException{
		Users user = userService.personcenter(userId);
		Users current_user = (Users) request.getSession().getAttribute("current_user");
		boolean isAttention = userService.getIsAttention(current_user.getUserId(),userId);
		vo.setAuthorId(userId);
		Page<Articles>  page = userService.selectUserAllPage(vo);
		model.addAttribute("page", page);
		model.addAttribute("isAttention", isAttention);
		model.addAttribute("user",user);
		return "personcenter";
		
	}
	@RequestMapping(value="/personEdit")
	public void personEdit(Users user,HttpServletRequest request,HttpServletResponse response) throws ParseException, IOException{
		Users current_user = (Users) request.getSession().getAttribute("current_user");
		current_user.setUserName(user.getUserName());
		current_user.setEmail(user.getEmail());
		current_user.setPhone(user.getPhone());
		current_user.setBirthday(user.getBirthday());
		current_user.setSex(user.getSex());
		current_user.setProfession(user.getProfession());
		current_user.setIntroduction(user.getIntroduction());
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
