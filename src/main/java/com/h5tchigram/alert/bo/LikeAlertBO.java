package com.h5tchigram.alert.bo;

import java.util.List;	

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.h5tchigram.alert.dao.LikeAlertDAO;
import com.h5tchigram.alert.model.Alert;
import com.h5tchigram.alert.model.LikeAlert;

@Service
public class LikeAlertBO {
	@Autowired
	private LikeAlertDAO likeAlertDAO;
	@Autowired
	private AlertBO alertBO;
	
	public void createLikeAlert(int sendUserId, int receiveUserId, int postId, int likeId) {
		
		Alert alert = alertBO.createAlert(sendUserId, receiveUserId, "like");
		
		likeAlertDAO.insertLikeAlert(alert.getId(), postId, likeId);
		
	}
	
	public void deleteLikeAlertByLikeId(int likeId) {
		
		LikeAlert likeAlert=likeAlertDAO.selectLikeAlertByLikeId(likeId);
		if(likeAlert!=null){
			alertBO.deleteAlertById(likeAlert.getAlertId());
			likeAlertDAO.deleteLikeAlertByLikeId(likeId);
		}
	}
	
	public void deleteLikeAlertByPostId(int postId) {
		
		List<LikeAlert> likeAlertList=likeAlertDAO.selectLikeAlertListByPostId(postId);
		
		for(LikeAlert likeAlert : likeAlertList) {
			alertBO.deleteAlertById(likeAlert.getAlertId());
		}
		
	}
	
	public LikeAlert getLikeAlertByAlertId(int alertId) {
		return likeAlertDAO.selectLiekAlertByAlertId(alertId);
	}
	
}
