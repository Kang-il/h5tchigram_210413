package com.h5tchigram.timeline.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.h5tchigram.timeline.model.TimeLine;

@Repository
public interface TimeLineDAO {
	public void insertTimeline(@Param("postId") int postId
						     , @Param("userId") int userId
						     );
	
	public void deleteTimeLineByPostId(@Param("postId") int postId);
	public List<TimeLine> selectTimeLineListByUserIdList(@Param("userIdList") List<Integer> userIdList);
}
