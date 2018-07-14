package com.fengf.blog.service;

import java.util.List;

import com.fengf.blog.pojo.ArticleQueryVo;
import com.fengf.blog.pojo.Articlelike;
import com.fengf.blog.pojo.Articles;
import com.fengf.blog.pojo.Users;
import com.fengf.common.utils.Page;

public interface ArticleService {

	boolean savewriting(Articles articles);

	Page<Articles> selectAllPage(ArticleQueryVo vo);

	Articles showarticle(Integer articleId);

	boolean likeAndDislike(Boolean flag, Integer articleId, Integer userId);

	Users getArticleAuthor(String author);

	List<Users> selectHotUsers();

	Articlelike getUserLikeAndDisLike(Integer articleId, Integer userId);

	boolean getIsAttention(Integer userId, String author);

}
