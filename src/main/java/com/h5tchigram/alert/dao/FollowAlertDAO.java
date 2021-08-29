package com.h5tchigram.alert.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.h5tchigram.alert.model.FollowAlert;

@Repository
public interface FollowAlertDAO {
	public void insertFollowAlert(@Param("alertId")int alertId ,@Param("followId") int followId);
	
	public void deleteFollowAlertByFollowId(@Param("followId")int followId);
	
	public FollowAlert selectFollowAlertByFollowId(@Param("followId")int followId);
	public FollowAlert selectFollowAlertByAlertId(@Param("alertId") int alertId);
}
