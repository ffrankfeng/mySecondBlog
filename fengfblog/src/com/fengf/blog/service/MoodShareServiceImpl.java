package com.fengf.blog.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fengf.blog.mapper.MoodshareMapper;
import com.fengf.blog.pojo.Articles;
import com.fengf.blog.pojo.MoodShareQueryVo;
import com.fengf.blog.pojo.Moodshare;
import com.fengf.common.utils.Page;

@Service
public class MoodShareServiceImpl implements MoodShareService {

	@Autowired
	private MoodshareMapper moodshareMapper;
	@Override
	public Page<Moodshare> selectAllMood(MoodShareQueryVo vo) {
		Page<Moodshare> page=new Page<Moodshare>();
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
			page.setTotal(moodshareMapper.moodCountByQueryVo(vo));
			page.setRows(moodshareMapper.selectMoodListByQueryVo(vo));
		}
		return page;
	}

}
