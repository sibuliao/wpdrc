package com.wpdrc.service;

import java.util.List;

import com.wpdrc.pojo.User;

public interface UserService {
	List<User> get();

	/**
	 * 账号验证
	 * 
	 * @param account
	 * @param password
	 * @return
	 */
	boolean verification(String account, String password);
}
