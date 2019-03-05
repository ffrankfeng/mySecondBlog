package com.fengf.blog.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.fengf.blog.pojo.MoodQueryVo;
import com.fengf.blog.pojo.MoodShareQueryVo;
import com.fengf.blog.pojo.Moodshare;
import com.fengf.blog.pojo.Users;
import com.fengf.blog.service.MoodShareService;
import com.fengf.common.utils.Page;


@Controller
public class MoodShareController {
	
	@Autowired
	private MoodShareService moodShareService;
	
	
	@RequestMapping(value="/moodshare")
	public String moodshare(MoodShareQueryVo vo,Model model,HttpServletRequest request){
		Users current_user = (Users) request.getSession().getAttribute("current_user");
		vo.setMoodLikeUserId("%|"+current_user.getUserId()+"|%");
		Page<MoodShareQueryVo>  page = moodShareService.selectAllMood(vo);
		model.addAttribute("page", page);
		return "moodshare";
	}
	@RequestMapping(value="/mymoodshare")
	public String mymoodshare(MoodShareQueryVo vo,Model model,HttpServletRequest request){
		Users current_user = (Users) request.getSession().getAttribute("current_user");
		vo.setMoodAuthor(current_user.getUserName());
		Page<MoodShareQueryVo>  page = moodShareService.selectAllMood(vo);
		model.addAttribute("page", page);
		return "mymoodshare";
	}
	@RequestMapping(value="/likeMood")
	public void likeMood(Integer moodId,Model model,HttpServletResponse response,HttpServletRequest request) throws IOException{
		
		Users current_user = (Users) request.getSession().getAttribute("current_user");
		boolean flag =moodShareService.likeMood(moodId,current_user.getUserId());
		response.getWriter().write("{\"isFinish\":"+flag+"}");
	}
	@RequestMapping(value="/writeMyMood")
	public void writeMyMood(String moodContent,MultipartFile moodPic,Model model,HttpServletRequest request,HttpServletResponse response) throws IOException{
		Users current_user = (Users) request.getSession().getAttribute("current_user");
		Moodshare moodshare =new Moodshare();
		moodshare.setMoodContent(moodContent);
		moodshare.setMoodAuthor(current_user.getUserName());
		
		//保存图片到 
		
		if(moodPic.getOriginalFilename() != null && moodPic.getOriginalFilename() != ""){
			String name = UUID.randomUUID().toString().replaceAll("-", "");
			//jpg
			String ext = FilenameUtils.getExtension(moodPic.getOriginalFilename());
			String path ="d:\\fengfImg\\fengfblog\\mood\\";
			File picfile = new File(path + name + "." + ext);
			moodPic.transferTo(picfile);
			moodshare.setMoodPic("d:\\fengfImg\\fengfblog\\mood\\"+name + "." + ext);
		}
		boolean flag = moodShareService.writeMyMood(moodshare);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		if(!flag){
			out.println("<script language='javaScript'> alert('发布失败，请重新发布！');</script>");
			response.setHeader("refresh","0.2;url=librarian_book_add");
		}else{
			out.println("<script language='javaScript'> alert('发布成功');</script>");
		}
		response.setHeader("refresh","0.2;url=mymoodshare");
	}
}
