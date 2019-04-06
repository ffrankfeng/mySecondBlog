package com.fengf.blog.controller;

import java.io.IOException;
import java.util.List;


import javax.jws.WebParam;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.fengf.blog.pojo.*;
import com.fengf.blog.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fengf.blog.service.ArticleService;
import com.fengf.common.utils.Page;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ArticleController {

	@Autowired
	private ArticleService articleService;
	@Autowired
	private CategoryService categoryService;
	@RequestMapping(value="/deleteArticle.html")
	@ResponseBody
	public String deleteArticle(int articleId,HttpServletRequest request){
		Users current_user = (Users) request.getSession().getAttribute("current_user");
		if (current_user == null)
			return "{\"isFinish\":null}";
		else {
			boolean isVaild = articleService.checkArticleRequestIsVaild(current_user, articleId);
			if (isVaild) {
				boolean flag = articleService.deleteArticle(articleId);
				return "{\"isFinish\":" + flag + "}";
			} else {
				return "{\"isFinish\":null}";
			}
		}
	}

	@RequestMapping(value="/editArticle.html")
	public String editArticle(int articleId,Model model,HttpServletRequest request){
		Users current_user = (Users) request.getSession().getAttribute("current_user");
		if (current_user == null)
			return "404";
		else {
			boolean isVaild = articleService.checkArticleRequestIsVaild(current_user,articleId);
			if (isVaild){
				Articles article  = articleService.editArticle(articleId);
				article.setContent(article.getContent().replaceAll("(\r\n|\r|\n|\n\r)", "<br>"));
				model.addAttribute("editArticle", article);
				model.addAttribute("articleId", articleId);
				List<Category> categoryList = categoryService.selectAllCategory();
				model.addAttribute("categoryList", categoryList);
				return "editArticle";
			}else {
				return "404";
			}
		}

	}
	@RequestMapping(value="/writing.html")
	String writing(HttpServletRequest request,Model model){
		Users current_user = (Users) request.getSession().getAttribute("current_user");
		if (current_user == null)
			return "login";
		else {
			List<Category> categoryList = categoryService.selectAllCategory();
			model.addAttribute("categoryList", categoryList);
			return "writeacticle";
		}

	}

//	@RequestMapping(value="/tselectArticlesByCategory")
//	public String index(ArticleQueryVo vo,Model model){
//		Page<Articles>  page = articleService.selectAllPage(vo);
//		model.addAttribute("page", page);
//		List<Category> categoryList = categoryService.selectAllCategory();
//		model.addAttribute("categoryList", categoryList);
//		return "index";
//	}
	@RequestMapping(value="/articlecomment.html")
	public void articlecomment(Articlecomment articlecomment,HttpServletRequest request,HttpServletResponse response) throws IOException{
		Users current_user = (Users) request.getSession().getAttribute("current_user");
		if (current_user == null){
			response.getWriter().write("{\"isFinish\":\"null\"}");
		}else{
			articlecomment.setFromUid(current_user.getUserId());
			articlecomment.setFromUsername(current_user.getUserName());
			boolean flag = articleService.insertcomment(articlecomment);
			response.getWriter().write("{\"isFinish\":"+flag+"}");
		}
	}
	//首页
	@RequestMapping(value="/")
	public String defaultPage(ArticleQueryVo vo,Model model){
		Page<Articles>  page = articleService.selectAllPage(vo);
		model.addAttribute("page", page);
		List<Category> categoryList = categoryService.selectAllCategory();
		model.addAttribute("categoryList", categoryList);
		return "index";
	}
	@RequestMapping(value="/index.html")
	public String index(ArticleQueryVo vo,Model model){
		System.out.println("vo= "+vo);
		Page<Articles>  page = articleService.selectAllPage(vo);
		model.addAttribute("page", page);
		List<Category> categoryList = categoryService.selectAllCategory();
		model.addAttribute("categoryList", categoryList);
		return "index";
	}
	@RequestMapping(value="/InfoBar.html")
	public String InfoBar(Model model){
		List<Users> hotUsers=articleService.selectHotUsers();
		model.addAttribute("hotUsers", hotUsers);
		List<Articles> hotArticles=articleService.selecthotArticles();
		model.addAttribute("hotArticles", hotArticles);
		return "InfoBar";
	}
	@RequestMapping(value="/userarticlelist.html")
	String userarticlelist(ArticleQueryVo vo,Integer userId,Model model){
		if(userId !=null && userId !=0){
			vo.setAuthorId(userId);
			model.addAttribute("search",userId);
		}
		Page<Articles>  page = articleService.selectAllPageBySerach(vo);
		model.addAttribute("page", page);
		return "userarticlelist";
	}
	@RequestMapping(value="/likeAndDislike.html")
	public void likeAndDislike(Boolean flag,Integer articleId,HttpServletResponse response,HttpServletRequest request) throws IOException{
		Users current_user = (Users) request.getSession().getAttribute("current_user");
		if (current_user == null){
			response.getWriter().write("{\"isFinish\":\"null\"}");
		}else {
			boolean flag2 = articleService.likeAndDislike(flag, articleId, current_user.getUserId());
			response.getWriter().write("{\"isFinish\":" + flag2 + "}");
		}
	}

	@RequestMapping(value="/showarticle.html")
	public String showarticle(Integer articleId,Model model,HttpServletRequest request){
		Articles articles = articleService.showarticle(articleId);
		Users author=articleService.getArticleAuthor(articles.getAuthor());
		Users current_user = (Users) request.getSession().getAttribute("current_user");
		if(current_user != null){
			Articlelike articlelike =articleService.getUserLikeAndDisLike(articleId,current_user.getUserId());
			boolean isAttention = articleService.getIsAttention(current_user.getUserId(),articles.getAuthor());
			model.addAttribute("isAttention", isAttention);
			model.addAttribute("articlelike", articlelike);
		}else{
			model.addAttribute("isAttention", false);
			model.addAttribute("articlelike", null);
		}

		List<Articlecomment> commentList = articleService.getCommentList(articleId);
		model.addAttribute("commentList", commentList);
		model.addAttribute("article", articles);
		model.addAttribute("articleAuthor", author);
		return "showarticle";
	}
	@RequestMapping(value="/savewriting.html")
	void savewriting(Articles articles,HttpServletResponse response,HttpServletRequest request) throws IOException{
		Users current_user = (Users) request.getSession().getAttribute("current_user");
		if (current_user == null){
			response.getWriter().write("{\"isFinish\":null}");
		}else {
			articles.setAuthorId(current_user.getUserId());
			articles.setAuthor(current_user.getUserName());
			boolean flag = articleService.savewriting(articles);
			response.getWriter().write("{\"isFinish\":" + flag + "}");
		}
	}

	@RequestMapping(value="/saveEdit.html")
	void saveEdit(Articles articles,HttpServletResponse response,HttpServletRequest request) throws IOException{
		Users current_user = (Users) request.getSession().getAttribute("current_user");
		if (current_user == null)
			response.getWriter().write("{\"isFinish\":null}");
		else {
			boolean isVaild = articleService.checkArticleRequestIsVaild(current_user, articles.getArticleId());
			if (isVaild) {
				articles.setAuthorId(current_user.getUserId());
				articles.setAuthor(current_user.getUserName());
				System.out.println(articles);
				boolean flag = articleService.saveEdit(articles);
				response.getWriter().write("{\"isFinish\":" + flag + "}");
			} else {
				response.getWriter().write("{\"isFinish\":null}");
			}
		}
	}
}
