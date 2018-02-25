package com.wpdrc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wpdrc.mapper.UserMapper;
import com.wpdrc.pojo.User;

@Service("userServiceImpl")
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userMapper;

	public List<User> get() {
		return userMapper.select();
	}

	public boolean verification(String account, String password) {
		User user = new User();
		user.setAccount(account);
		user.setPassword(password);
		if (1 == userMapper.verification(user)) {
			return true;
		} else {
			return false;
		}
	}

}
