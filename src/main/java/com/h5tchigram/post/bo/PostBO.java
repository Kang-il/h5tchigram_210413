package com.h5tchigram.post.bo;

import java.io.IOException;	
import java.util.List	;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.h5tchigram.comment.bo.CommentBO;
import com.h5tchigram.comment.model.Comment;
import com.h5tchigram.common.FileManagerService;
import com.h5tchigram.like.bo.LikeBO;
import com.h5tchigram.like.model.Like;
import com.h5tchigram.post.dao.PostDAO;
import com.h5tchigram.post.model.Post;
import com.h5tchigram.post.model.PostThumbnail;




@Service
public class PostBO {
	
	Logger logger=LoggerFactory.getLogger(Post.class);
	
	@Autowired
	private PostDAO postDAO;
	@Autowired
	private FileManagerService fileManagerService;
	@Autowired
	private LikeBO likeBO;
	@Autowired
	private CommentBO commentBO;
	
	//포스트 리스트를 가져옴
	public List<Post> getPostListByPostOwnerId(int ownerId){
		List<Post> postList=postDAO.selectPostListByPostOwnerId(ownerId);
		
		for(Post post : postList) {
			int postId=post.getId();
			// 각 포스터에 댓글이랑 좋아요 리스트를 삽입
			post.setCommentList(commentBO.getCommentListByPostId(postId));
			post.setLikeList(likeBO.getLikeListByPostId(postId));
		}
		
		return postList;
	}
	
	public Post getPostById(int id) {
		Post post=postDAO.selectPostByPostId(id);
		
		//포스트에 코멘트 리스트를 가져온다
		List<Comment> commentList=commentBO.getCommentListByPostId(post.getId());
		
		//포스트에 있는 라이크 목록을 가져온다. 
		List<Like> likeList=likeBO.getLikeListByPostId(post.getId());
		logger.debug(":::::::::::::::::::::::::: 좋아요 목록"+likeList.size());
		//각 리스트를 포스트에 담아준다.
		post.setCommentList(commentList);
		post.setLikeList(likeList);
		
		return post;
	}
	
	public List<PostThumbnail> getPostThumbnailListByOwnerId(int ownerId){
		
		List<PostThumbnail> postThumbnailList=postDAO.selectPostThumbnailListByOwnerId(ownerId);
		
		for(PostThumbnail post : postThumbnailList) {
			//포스트 썸네일에 좋아요 수와 댓글 수를 담아준다.
			post.setLikeCount(likeBO.getLikeCountByPostId(post.getPostId()));
			post.setCommentCount(commentBO.getCommentCountByPostId(post.getPostId()));
		}
		
		return postThumbnailList;
	}
	
	public int createPost(int userId, String userLoginId, String content, MultipartFile file) {
		//사진 타입만 받도록 해준다
		String contentType="photo";
		String imageUrl=null;
		
		//filed업로드 후  image URL을 반환받아 DB에 넣을 인자값으로 구성.
		
		try {//컴퓨터에(서버에) 파일 업로드 후 DB에 저장해 나중에 웹에서 접근할 수 있는 Image URL을 얻어낸다
			imageUrl = fileManagerService.saveFile(userLoginId, file);
		}catch(IOException e) {
			//대략적인 이유가 나오는 메시지
			logger.debug(e.getMessage());
		}
		
		
		
		return postDAO.insertPost(userId,contentType,content,imageUrl);
	}
	
	
}
