package com.h5tchigram.post.dao;


import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;


@Repository
public interface PostDAO {
	public int insertPost(@Param("userId") int userId
						 ,@Param("contentType") String contentType
						 ,@Param("content") String content
						 ,@Param("imagePath") String imagePath);
}
