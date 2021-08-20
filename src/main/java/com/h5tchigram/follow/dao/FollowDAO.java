package com.h5tchigram.follow.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.h5tchigram.follow.model.Follow;

@Repository
public interface FollowDAO {
	public List<Follow> selectFollowListByFollowingUserId(@Param("followingUserId")int followingUserId);
	public List<Follow> selectFollowListByFollowerUserId(@Param("followerUserId")int followerUserId);
	
	public List<Follow> selectOnlyFollowingUserByFollowerId(@Param("followerUserId")int followerUserId);
	
	public int selectFollowCountByFollowingUserId(@Param("followingUserId")int followingUserId);
	public int selectFollowCountByFollowerUserId(@Param("followerUserId")int followerUserId);
	
	public Follow selectFollowByFollowingUserIdAndFollowerUserId(
			@Param("followingUserId") int followingUserId
			,@Param("followerUserId") int followerUserId);
	
}
