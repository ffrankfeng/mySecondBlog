package com.fengf.blog.service;

import com.fengf.blog.pojo.Users;

public interface UserService {

	Users userLogin(Users user);

	boolean userInsert(Users user);

	boolean checkUsername(String userName);

	String getJoinday(Users current_user);

	boolean personEdit(Users user);

}
