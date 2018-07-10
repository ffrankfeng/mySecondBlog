package com.fengf.blog.service;

import com.fengf.blog.pojo.MoodShareQueryVo;
import com.fengf.blog.pojo.Moodshare;
import com.fengf.common.utils.Page;

public interface MoodShareService {

	Page<Moodshare> selectAllMood(MoodShareQueryVo vo);

}
