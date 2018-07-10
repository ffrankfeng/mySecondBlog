package com.fengf.blog.service;

import com.fengf.blog.pojo.ArticleQueryVo;
import com.fengf.blog.pojo.Articles;
import com.fengf.blog.pojo.Users;
import com.fengf.common.utils.Page;

public interface ArticleService {

	boolean savewriting(Articles articles);

	Page<Articles> selectAllPage(ArticleQueryVo vo);

	Articles showarticle(Integer articleId);

	int likeAndDislike(Boolean flag, Integer articleId);

	Users getArticleAuthor(String author);

}
