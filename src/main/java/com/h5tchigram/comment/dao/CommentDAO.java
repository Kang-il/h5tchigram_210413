package com.h5tchigram.comment.dao;

import java.util.List;	

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.h5tchigram.comment.model.Comment;

@Repository
public interface CommentDAO {
	public int selectCommentCountByPostId(@Param("postId") int postId);
	public List<Comment> selectCommentListByPostId(@Param("postId") int postId);
	public void deleteCommentByPostId(@Param("postId") int postId);
}
