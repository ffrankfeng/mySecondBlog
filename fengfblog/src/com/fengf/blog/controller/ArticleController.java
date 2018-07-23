package com.fengf.blog.controller;

import java.io.IOException;
import java.util.List;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fengf.blog.pojo.ArticleQueryVo;
import com.fengf.blog.pojo.Articlecomment;
import com.fengf.blog.pojo.Articlelike;
import com.fengf.blog.pojo.Articles;
import com.fengf.blog.pojo.Users;
import com.fengf.blog.service.ArticleService;
import com.fengf.common.utils.Page;

@Controller
public class ArticleController {

	@Autowired
	private ArticleService articleService;
	
	@RequestMapping(value="/writing")
	String writing(){
		return "writeacticle";
	}
	@RequestMapping(value="/articlecomment")
	public void articlecomment(Articlecomment articlecomment,Model model,HttpServletRequest request,HttpServletResponse response) throws IOException{
		Users current_user = (Users) request.getSession().getAttribute("current_user");
		articlecomment.setFromUid(current_user.getUserId());
		articlecomment.setFromUsername(current_user.getUserName());
		boolean flag = articleService.insertcomment(articlecomment);
		response.getWriter().write("{\"isFinish\":"+flag+"}");
	}
	//首页
	@RequestMapping(value="/index")
	public String index(ArticleQueryVo vo,Model model){
		Page<Articles>  page = articleService.selectAllPage(vo);
		model.addAttribute("page", page);
		return "index";
	}
	@RequestMapping(value="/InfoBar")
	public String InfoBar(Model model){
		List<Users> hotUsers=articleService.selectHotUsers();
		model.addAttribute("hotUsers", hotUsers);
		List<Articles> hotArticles=articleService.selecthotArticles();
		model.addAttribute("hotArticles", hotArticles);
		return "InfoBar";
	}
	@RequestMapping(value="/userarticlelist")
	String userarticlelist(ArticleQueryVo vo,Integer userId,Model model){
		if(userId !=null && userId !=0){
			vo.setAuthorId(userId);
			model.addAttribute("search",userId);
		}
		Page<Articles>  page = articleService.selectAllPage(vo);
		model.addAttribute("page", page);
		return "userarticlelist";
	}
	@RequestMapping(value="/likeAndDislike")
	public void likeAndDislike(Boolean flag,Integer articleId,HttpServletResponse response,HttpServletRequest request) throws IOException{
		Users current_user = (Users) request.getSession().getAttribute("current_user");
		boolean flag2 =articleService.likeAndDislike(flag,articleId,current_user.getUserId());
			response.getWriter().write("{\"isFinish\":"+flag2+"}");
	}

	@RequestMapping(value="showarticle")
	public String showarticle(Integer articleId,Model model,HttpServletRequest request){
		Articles articles = articleService.showarticle(articleId);
		Users author=articleService.getArticleAuthor(articles.getAuthor());
		Users current_user = (Users) request.getSession().getAttribute("current_user");
		Articlelike articlelike =articleService.getUserLikeAndDisLike(articleId,current_user.getUserId());
		boolean isAttention = articleService.getIsAttention(current_user.getUserId(),articles.getAuthor());
		List<Articlecomment> commentList = articleService.getCommentList(articleId);
		model.addAttribute("commentList", commentList);
		model.addAttribute("isAttention", isAttention);
		model.addAttribute("articlelike", articlelike);
		model.addAttribute("article", articles);
		model.addAttribute("articleAuthor", author);
		return "showarticle";
	}
	@RequestMapping(value="/savewriting")
	void savewriting(Articles articles,HttpServletResponse response,HttpServletRequest request) throws IOException{
		Users current_user = (Users) request.getSession().getAttribute("current_user");
		articles.setAuthorId(current_user.getUserId());
		articles.setAuthor(current_user.getUserName());
		boolean flag=articleService.savewriting(articles);
		response.getWriter().write("{\"isFinish\":"+flag+"}");
	}
	
	
}
