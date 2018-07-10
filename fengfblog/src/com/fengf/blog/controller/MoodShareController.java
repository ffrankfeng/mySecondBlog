package com.fengf.blog.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fengf.blog.pojo.Articles;
import com.fengf.blog.pojo.MoodShareQueryVo;
import com.fengf.blog.pojo.Moodshare;
import com.fengf.blog.service.MoodShareService;
import com.fengf.common.utils.Page;


@Controller
public class MoodShareController {
	
	@Autowired
	private MoodShareService moodShareService;
	
	@RequestMapping(value="/moodshare")
	public String moodshare(MoodShareQueryVo vo,Model model){
		Page<Moodshare>  page = moodShareService.selectAllMood(vo);
		model.addAttribute("page", page);
		return "moodshare";
	}
	@RequestMapping(value="/mymoodshare")
	public String mymoodshare(Model model){
		return "mymoodshare";
	}
}
