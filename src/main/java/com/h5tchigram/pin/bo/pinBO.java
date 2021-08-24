package com.h5tchigram.pin.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.h5tchigram.pin.dao.PinDAO;
import com.h5tchigram.pin.model.Pin;

@Service
public class pinBO {
	@Autowired
	private PinDAO pinDAO;

	public Pin getPinByPostIdAndUserId(int postId, int userId) {
		return pinDAO.selectPinByPostIdAndUserId(postId, userId);
	}
	
	public List<Pin> getPinListUserId(int userId){
		return pinDAO.selectPinListByUserId(userId);
	}
	
	public int insertPin(int postId, int userId) {
		return pinDAO.insertPin(postId, userId);
	}

	public int deletePin(int postId, int userId) {
		return pinDAO.deletePin(postId, userId);
	}

}
