package com.fengf.blog.mapper;

import com.fengf.blog.pojo.ArticleQueryVo;
import com.fengf.blog.pojo.Articles;
import com.fengf.blog.pojo.ArticlesExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ArticlesMapper {
    int countByExample(ArticlesExample example);

    int deleteByExample(ArticlesExample example);

    int deleteByPrimaryKey(Integer articleId);

    int insert(Articles record);

    int insertSelective(Articles record);

    List<Articles> selectByExample(ArticlesExample example);

    Articles selectByPrimaryKey(Integer articleId);

    int updateByExampleSelective(@Param("record") Articles record, @Param("example") ArticlesExample example);

    int updateByExample(@Param("record") Articles record, @Param("example") ArticlesExample example);

    int updateByPrimaryKeySelective(Articles record);

    int updateByPrimaryKey(Articles record);
    int updateLikeByPrimaryKey(Articles record);
    int updateDisLikeByPrimaryKey(Articles record);
	int articleCountByQueryVo(ArticleQueryVo articleVo);

	List<Articles> selectArticleListByQueryVo(ArticleQueryVo articleVo);

	void addReadingByPrimaryKey(Integer articleId);
}