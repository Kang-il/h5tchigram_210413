package com.h5tchigram.alert.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.h5tchigram.alert.model.Alert;

@Repository
public interface AlertDAO {

	public void insertAlert(Alert alert);
	public void deleteAlertById(@Param("alertId")int alertId);
	public List<Alert> selectAlertListByReceiveUserId(@Param("receiveUserId")int receiveUserId);
	
}
