package com.h5tchigram.post.dao;

import java.util.List;	

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.h5tchigram.post.model.Post;
import com.h5tchigram.post.model.PostThumbnail;


@Repository
public interface PostDAO {
	public Post selectPostByPostId(@Param("postId") int postId);
	public List<Post> selectPostListByPostOwnerId(@Param("ownerId") int ownerId);
	public List<PostThumbnail> selectPostThumbnailListByOwnerId(@Param("ownerId") int ownerId);
	public int insertPost(@Param("userId") int userId
						 ,@Param("contentType") String contentType
						 ,@Param("content") String content
						 ,@Param("imagePath") String imagePath);
}
