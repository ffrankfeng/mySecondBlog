package com.fengf.blog.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fengf.blog.mapper.UsersMapper;
import com.fengf.blog.pojo.Users;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UsersMapper usersMapper;
	@Override
	public Users userLogin(Users user) {
		Users current_user = usersMapper.selectByusername(user.getUserName());
		current_user.setJoinday(getJoinday(current_user));
		if(current_user != null && (user.getUserPassword().equals(current_user.getUserPassword())))
			return current_user;
		else return null;
		
	}
	public String getupDate() throws ParseException{
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		String date=sdf.format(new Date());
		return date;
	}
	@Override
	public boolean userInsert(Users user) {
		user.setArticlecount(0);
		user.setAttention(0);
		user.setFans(0);
		user.setGold(0);
		user.setMoodcount(0);
		user.setIntroduction("赶快介绍一下自己吧...");
		user.setProfession("未填写");
		try {
		user.setJoinday(getupDate());
		} catch (ParseException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		int flag = usersMapper.insert(user);
		if(flag<=0)
		return false;
		else return true;
	}
	@Override
	public boolean checkUsername(String userName) {
		Users user = usersMapper.selectByusername(userName);
		if(user != null)
			return false;
		else return true;
	}
	@Override
	public String getJoinday(Users current_user) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		long jointime=0;
		try {
			jointime = sdf.parse(current_user.getJoinday()).getTime();
		} catch (ParseException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		long time = new Date().getTime();
		return (time-jointime)/1000/24/60/60+"";
	}
	@Override
	public boolean personEdit(Users user) {
		int flag = usersMapper.updateByPrimaryKey(user);
		if(flag<=0)
			return false;
		else return true;
	}

}
