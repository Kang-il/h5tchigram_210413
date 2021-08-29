package com.h5tchigram.alert.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.h5tchigram.alert.dao.FollowAlertDAO;
import com.h5tchigram.alert.model.Alert;
import com.h5tchigram.alert.model.FollowAlert;

@Service
public class FollowAlertBO {
	@Autowired
	private AlertBO alertBO;
	
	@Autowired
	private FollowAlertDAO followAlertDAO;

	public void createFollowAlert(int sendUserId, int receiveUserId, int followId) {
		//follow 시에 알람 타임라인 생성
		//생성된 알람의 아이디값을 받아옴
		Alert alert = alertBO.createAlert(sendUserId, receiveUserId, "follow");
		
		followAlertDAO.insertFollowAlert(alert.getId(),followId);
	}

	public void deleteFollowAlertByFollowId(int followId) {
		//1.FollowAlert 를 받아옴
		FollowAlert followAlert = followAlertDAO.selectFollowAlertByFollowId(followId);
		
		//2.followAlertDAO에 followId를 통하여 FollowAlert를 지움
		followAlertDAO.deleteFollowAlertByFollowId(followId);
		
		//3. AlertTimeLine에 있는 값을 지워줌
		alertBO.deleteAlertById(followAlert.getAlertId());
	}
	
	public FollowAlert getFollowAlertByFollowId(int followId) {
		return followAlertDAO.selectFollowAlertByFollowId(followId);
	}
	
	public FollowAlert getFollowAlertByAlertId(int alertId) {
		return followAlertDAO.selectFollowAlertByAlertId(alertId);
	}
}
