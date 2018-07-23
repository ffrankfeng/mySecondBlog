package com.fengf.blog.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.fengf.blog.pojo.Users;




public class LoginInterceptor implements HandlerInterceptor{

	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO 自动生成的方法存根
		
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
		// TODO 自动生成的方法存根
		
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
				//判断用户是否登陆  如果没有登陆  重定向到登陆页面   不放行   如果登陆了  就放行了
		String requestURI = request.getRequestURI();
		
		if(requestURI.contains("/register"))
			return true;
		if(requestURI.contains("/userRegister"))
			return true;
		if(requestURI.contains("/userLogin"))
			return true;
		if(requestURI.contains("/css"))
			return true;
		if(requestURI.contains("/fonts"))
			return true;
		if(requestURI.contains("/img"))
			return true;
		if(requestURI.contains("/ueditor"))
			return true;
		if(requestURI.contains("/js"))
			return true;
		if(requestURI.contains("check"))
			return true;
		if(!requestURI.contains("/login")){
			Users user = (Users) request.getSession().getAttribute("current_user");
			if(user==null){
				response.sendRedirect(request.getContextPath()+"/login");
				return false;
			}
		}
		return true;
	}
}
