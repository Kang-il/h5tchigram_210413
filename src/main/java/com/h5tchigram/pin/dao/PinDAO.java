package com.h5tchigram.pin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.h5tchigram.pin.model.Pin;

@Repository
public interface PinDAO {
	public Pin selectPinByPostIdAndUserId(@Param("postId") int postId
										 ,@Param("userId") int userId
										 );
	
	public List<Pin> selectPinListByUserId(@Param("userId") int userId);
	
	public int insertPin(@Param("postId") int postId
						,@Param("userId") int userId
						);
	
	public int deletePin(@Param("postId") int postId
						,@Param("userId") int userId
						);
	
	
}
