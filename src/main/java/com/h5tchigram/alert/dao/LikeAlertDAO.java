package com.h5tchigram.alert.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.h5tchigram.alert.model.LikeAlert;

@Repository
public interface LikeAlertDAO {
	public void insertLikeAlert(@Param("alertId") int alertId
							   ,@Param("postId") int postId
							   ,@Param("likeId") int likeId);
	
	public LikeAlert selectLikeAlertByLikeId(@Param("likeId") int likeId);
	public List<LikeAlert> selectLikeAlertListByPostId(@Param("postId") int postId);
	public LikeAlert selectLiekAlertByAlertId(@Param("alertId") int alertId);
	
	public void deleteLikeAlertByLikeId(@Param("likeId")int likeId);
	public void deleteLikeAlertByPostId(@Param("postId") int postId);
}
