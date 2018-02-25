package com.wpdrc.mapper;

import java.util.List;

import com.wpdrc.pojo.User;

public interface UserMapper {
	List<User> select();

	int verification(User user);
}
