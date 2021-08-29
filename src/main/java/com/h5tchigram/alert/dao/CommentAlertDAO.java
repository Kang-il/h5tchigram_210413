package com.h5tchigram.alert.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.h5tchigram.alert.model.CommentAlert;

@Repository
public interface CommentAlertDAO {
	public void insertCommentAlert(@Param("alertId") int alertId
								  ,@Param("postId") int postId
								  ,@Param("commentId") int commentId
								  );
	public void deleteCommentAlertByCommentId(@Param("commentId") int commentId);
	public void deleteCommentAlertByPostId(@Param("postId") int postId);
	
	public CommentAlert selectCommentAlertByCommentId( @Param("commentId") int commentId);
	public CommentAlert selectCommentAlertByAlertId(@Param("alertId") int alertId);
	public List<CommentAlert> selectCommentAlertListByPostId(@Param("postId") int postId);
}
