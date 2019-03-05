package com.fengf.bms.service;

import com.fengf.bms.mapper.ArticlesMapper;
import com.fengf.bms.mapper.MoodshareMapper;
import com.fengf.bms.mapper.UsersMapper;
import com.fengf.bms.pojo.*;
import com.fengf.common.utils.Page;
import com.sun.tools.internal.xjc.reader.xmlschema.bindinfo.BIConversion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class ArticleServiceImpl implements ArticleService {

    @Autowired
    private ArticlesMapper articlesMapper;
    @Autowired
    private MoodshareMapper moodshareMapper;
    @Autowired
    private UsersMapper usersMapper;

    private int aritcleCount;
    private int modeCount;
    private int userCount;
    private int readCount;
    @Override
    public ArticleVo getArticleInfo() {
        List<Articles> list = articlesMapper.selectAllArticleList();
         List<Moodshare> moodlist = moodshareMapper.selectAllMoodList();
        List<Users> userlist = usersMapper.selectAllUserList();

        ArticleVo articleVo = new ArticleVo();
        readCount = 0;
        for (Articles article:list){
            readCount +=article.getReading();
        }
        articleVo.setmoodCount(moodlist.size());
        articleVo.setUserCount(userlist.size());
        articleVo.setAritcleCount(list.size());
        articleVo.setReadCount(readCount);

        return articleVo;
    }
    public String getupDate() throws ParseException {
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
        page.setSize(10);
        vo.setSize(10);

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

}

