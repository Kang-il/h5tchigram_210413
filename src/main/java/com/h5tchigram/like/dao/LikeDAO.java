package com.h5tchigram.like.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.h5tchigram.like.model.Like;

@Repository
public interface LikeDAO {
	public List<Like> selectLikeListByPostId(@Param("postId") int postId);
	public int selectLikeCountByPostId(@Param("postId") int postId);
	public Like selectLikeByUserIdAndPostId(@Param("userId") int userId, @Param("postId") int postId);
	public void insertLikeByUserIdAndPostId(@Param("userId") int userId , @Param("postId") int postId);
	public void deleteLikeByUserIdAndPostId(@Param("userId") int userId, @Param("postId") int postId);
	public void deleteLikeByPostId(@Param("postId")int postId);
}
