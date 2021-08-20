package com.h5tchigram.user.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.h5tchigram.user.dao.UserDAO;
import com.h5tchigram.user.model.User;

@Service
public class UserBO {

	@Autowired
	private UserDAO userDAO;
	
	public User getUserById(String loginId) {
		return userDAO.selectUserByLoginId(loginId);
	}
	
	public Integer insertUser(User user) {
		return userDAO.insertUser(user);
	}
	
	public User getUserByLoginIdAndPassword(String loginId, String password) {
		return userDAO.selectUserByLoginIdAndPassword(loginId, password);
	}
	
	public User getUserById(int id) {
		return userDAO.selectUserById(id);
	}
	public User getUserLoginIdAndProfileImagePathById(int id) {
		return userDAO.selectUserLoginIdAndProfileImagePathById(id);
	}
	
}
