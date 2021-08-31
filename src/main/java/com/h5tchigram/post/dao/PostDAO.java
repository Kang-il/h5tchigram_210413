package com.h5tchigram.post.dao;

import java.util.List;	

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.h5tchigram.post.model.Post;
import com.h5tchigram.post.model.PostThumbnail;


@Repository
public interface PostDAO {
	public Post selectPostByPostId(@Param("postId") int postId);
	public int selectPostCountByUserId(@Param("ownerId") int ownerId);
	public List<Post> selectPostListByPostOwnerId(@Param("ownerId") int ownerId);
	public List<PostThumbnail> selectPostThumbnailListByOwnerId(@Param("ownerId") int ownerId
																,@Param("category")String category
																);
	public List<PostThumbnail> selectPostThumbnailForDetailViewByUserId(@Param("userId") int userId);
	public PostThumbnail selectPostThumbnailByPostId(@Param("postId") int postId);
	
	public int insertPost(Post post);
	public void deletePost(@Param("postId") int postId);
}
