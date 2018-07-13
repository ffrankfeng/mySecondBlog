package com.fengf.blog.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.fengf.blog.mapper.ArticlesMapper;
import com.fengf.blog.pojo.ArticleQueryVo;
import com.fengf.blog.pojo.Articles;
import com.fengf.blog.pojo.Users;
import com.fengf.blog.service.ArticleService;
import com.fengf.blog.service.UserService;
import com.fengf.common.utils.Page;

@Controller
public class ArticleController {

	@Autowired
	private ArticleService articleService;
	
	
	@RequestMapping(value="/writing")
	String writing(){
		return "writeacticle";
	}
	//首页
	@RequestMapping(value="/index")
	public String index(ArticleQueryVo vo,Model model){
		List<Users> hotUsers=articleService.selectHotUsers();
		model.addAttribute("hotUsers", hotUsers);
		Page<Articles>  page = articleService.selectAllPage(vo);
		model.addAttribute("page", page);
		return "index";
	}
	@RequestMapping(value="/likeAndDislike")
	public void likeAndDislike(Boolean flag,Integer articleId,HttpServletResponse response) throws IOException{
		int count=articleService.likeAndDislike(flag,articleId);
			response.getWriter().write("{\"isCorrect\":"+count+"}");
	}
		
	@RequestMapping(value="showarticle")
	public String showarticle(Integer articleId,Model model){
		Articles articles = articleService.showarticle(articleId);
		Users author=articleService.getArticleAuthor(articles.getAuthor());
		model.addAttribute("article", articles);
		model.addAttribute("articleAuthor", author);
		return "showarticle";
	}
	@RequestMapping(value="/savewriting")
	void savewriting(Articles articles,HttpServletResponse response,HttpServletRequest request) throws IOException{
		Users current_user = (Users) request.getSession().getAttribute("current_user");
		articles.setAuthor(current_user.getUserName());
		boolean flag=articleService.savewriting(articles);
		response.getWriter().write("{\"isFinish\":"+flag+"}");
	}
	
	
}
