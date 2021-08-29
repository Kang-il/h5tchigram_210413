package com.h5tchigram.alert.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.h5tchigram.alert.dao.AlertDAO;
import com.h5tchigram.alert.model.Alert;

@Service
public class AlertBO {
	@Autowired
	private AlertDAO alertDAO;
	
	public Alert createAlert(int sendUserId,int receiveUserId,String alertType) {
		Alert alert=new Alert();
		
		alert.setSendUserId(sendUserId);
		alert.setReceiveUserId(receiveUserId);
		alert.setAlertType(alertType);
		
		alertDAO.insertAlert(alert);
		
		return alert;
	}
	
	public void deleteAlertById(int alertId) {
		alertDAO.deleteAlertById(alertId);
	}
	
	public List<Alert> getAlertListByReceiveUserId(int receiveUserId){
		return alertDAO.selectAlertListByReceiveUserId(receiveUserId);
	}
}
