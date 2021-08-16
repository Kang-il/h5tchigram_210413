package com.h5tchigram.user.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.h5tchigram.user.model.User;

@Repository
public interface UserDAO {
	public User selectUserByLoginId(@Param("loginId") String loginId);
	public Integer insertUser(User user);
	public User selectUserByLoginIdAndPassword(@Param("loginId") String loginId
											  ,@Param("password") String password);
}
