package com.fengf.blog.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fengf.blog.mapper.ArticlesMapper;
import com.fengf.blog.mapper.UsersMapper;
import com.fengf.blog.pojo.ArticleQueryVo;
import com.fengf.blog.pojo.Articles;
import com.fengf.blog.pojo.Users;
import com.fengf.common.utils.Page;

@Service
public class ArticleServiceIpml implements ArticleService {

	@Autowired
	private ArticlesMapper articlesMapper;
	@Autowired
	private UsersMapper usersMapper;
	
	public String getupDate() throws ParseException{
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		String date=sdf.format(new Date());
		return date;
	}
	@Override
	public boolean savewriting(Articles articles) {
		articles.setCatalog("0");
		articles.setDislike(0);
		articles.setLikecount(0);
		articles.setReading(0);
		articles.setTop("0");
		try {
			articles.setUptime(getupDate());
		} catch (ParseException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		System.out.println(articles);
		int flag = articlesMapper.insertSelective(articles);
		if(flag<=0)
			return false;
		else {
			Users users = usersMapper.selectByusername(articles.getAuthor());
			usersMapper.addUserArticleCount(users.getUserId());
			return true;
		}
			
	}
	@Override
	public Page<Articles> selectAllPage(ArticleQueryVo vo) {
		Page<Articles> page=new Page<Articles>();
		//每页数
		page.setSize(5);
		vo.setSize(5);
		
		if(vo!=null ){
			//判断当前页
			if(vo.getPage()!=null){
				page.setPage(vo.getPage());
				vo.setStartRow((vo.getPage()-1)*vo.getSize());
			}
			//总条数
			page.setTotal(articlesMapper.articleCountByQueryVo(vo));
			page.setRows(articlesMapper.selectArticleListByQueryVo(vo));
		}
		return page;
	}
	@Override
	public Articles showarticle(Integer articleId) {
		articlesMapper.addReadingByPrimaryKey(articleId);
		return articlesMapper.selectByPrimaryKey(articleId);
	}
	@Override
	public int likeAndDislike(Boolean flag,Integer articleId) {
		int flag1=0;
		Articles article = articlesMapper.selectByPrimaryKey(articleId);
		if(flag){
			article.setLikecount(article.getLikecount()+1);
			flag1=articlesMapper.updateLikeByPrimaryKey(article);
			return article.getLikecount();
		}
		else{
			article.setDislike(article.getDislike()-1);
			flag1=articlesMapper.updateDisLikeByPrimaryKey(article);
			return article.getDislike();
		}
	}
	@Override
	public Users getArticleAuthor(String author) {
		Users users = usersMapper.selectByusername(author);
		return users;
	}
	@Override
	public List<Users> selectHotUsers() {
		return usersMapper.selectHotUsers(5);
	}

}
