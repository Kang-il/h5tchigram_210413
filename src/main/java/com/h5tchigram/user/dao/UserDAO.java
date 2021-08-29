package com.h5tchigram.user.dao;

import org.apache.ibatis.annotations.Param;	
import org.springframework.stereotype.Repository;

import com.h5tchigram.user.model.User;

@Repository
public interface UserDAO {
	//-----INSERT------
	public Integer insertUser(User user);
	//----SELECT
	public User selectUserByLoginId(@Param("loginId") String loginId);
	public User selectUserByLoginIdAndPassword(@Param("loginId") String loginId
											  ,@Param("password") String password);
	public User selectUserLoginIdAndProfileImagePathById(@Param("id") int id);
	public User selectUserById(@Param("id") int id);
	public User seleLastLikeUserById(@Param("id") int id);
	public User selectUserByUserLoginId(@Param("userLoginId")String userLoginId);
}
