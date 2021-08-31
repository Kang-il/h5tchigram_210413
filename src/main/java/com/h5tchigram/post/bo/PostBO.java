package com.h5tchigram.post.bo;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.h5tchigram.comment.bo.CommentBO;
import com.h5tchigram.comment.model.Comment;
import com.h5tchigram.common.FileManagerService;
import com.h5tchigram.follow.bo.FollowBO;

import com.h5tchigram.like.bo.LikeBO;
import com.h5tchigram.like.model.Like;
import com.h5tchigram.pin.bo.PinBO;
import com.h5tchigram.pin.model.Pin;
import com.h5tchigram.post.dao.PostDAO;
import com.h5tchigram.post.model.Post;
import com.h5tchigram.post.model.PostThumbnail;
import com.h5tchigram.timeline.bo.TimeLineBO;
import com.h5tchigram.timeline.model.TimeLine;
import com.h5tchigram.user.bo.UserBO;
import com.h5tchigram.user.model.User;




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
	@Autowired
	private PinBO pinBO;
	@Autowired
	private UserBO userBO;
	@Autowired
	private TimeLineBO timeLineBO;
	@Autowired
	private FollowBO followBO;
	
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
		
		//포스트 유저의 로그인 아이디글 가져옴, 이미지 경로 가져옴
		User user=userBO.getUserLoginIdAndProfileImagePathById(post.getUserId());
		post.setUserLoginId(user.getLoginId());
		post.setProfileImagePath(user.getProfileImagePath());
		
		return post;
	}
	
	public Post getOnlyPostById(int id) {
		return postDAO.selectPostByPostId(id);
	}
	
	public List<PostThumbnail> getPostThumbnailListByOwnerId(int ownerId,String category){
		
		List<PostThumbnail> postThumbnailList=postDAO.selectPostThumbnailListByOwnerId(ownerId,category);
		
		for(PostThumbnail post : postThumbnailList) {
			//포스트 썸네일에 좋아요 수와 댓글 수를 담아준다.
			post.setLikeCount(likeBO.getLikeCountByPostId(post.getPostId()));
			post.setCommentCount(commentBO.getCommentCountByPostId(post.getPostId()));
		}
		
		return postThumbnailList;
	}
	
	public List<PostThumbnail> getPinedPostThumbnailListByOwnerId(int ownerId){
		//피드 오너 아이디로 핀리스트 가져옴
		List<Pin> pinList= pinBO.getPinListUserId(ownerId);
		//썸네일 리스트 생성
		List<PostThumbnail> postThumbnailList=new ArrayList<>();
		
		for(Pin pin : pinList) {//핀의 포스트 아이디로 포스트썸네일을 가져옴
			postThumbnailList.add( postDAO.selectPostThumbnailByPostId(pin.getPostId()));
		}
		for(PostThumbnail post : postThumbnailList) {
			post.setLikeCount(likeBO.getLikeCountByPostId(post.getPostId()));
			post.setCommentCount(commentBO.getCommentCountByPostId(post.getPostId()));
		}
		Collections.reverse(postThumbnailList);
		
		return postThumbnailList;
	}
	
	public List<PostThumbnail> getPostThumbnailForDetailViewByUserId(int userId){
		List<PostThumbnail> postThumbnailList=postDAO.selectPostThumbnailForDetailViewByUserId(userId);
		for(PostThumbnail post:postThumbnailList) {
			post.setLikeCount(likeBO.getLikeCountByPostId(post.getPostId()));
			post.setCommentCount(commentBO.getCommentCountByPostId(post.getPostId()));
		}
		return postThumbnailList;
	}
	
	public List<Post> getPostListByTimeLine(int userId){
		List<Post> postList=new ArrayList<>();
		//1.유저 아이디로 내가 팔로우 하는 유저아이디를 모두 가져옴
		List<Integer> followList =followBO.getFollowerOnlyUserId(userId);
		//타임라인에 나의아이디도 넣어 같이 추가해줄 것
		followList.add(userId);
		//2.내가 팔로우한 유저들을 기준으로 타임라인 리스트를 가져옴
		List<TimeLine> timeLineList=timeLineBO.getTimeLineListByUserIdList(followList);
		
		
		for(TimeLine timeLine : timeLineList) {
			//타임라인리스트에서 타임라인에 저장되어있는 postId로 순서대로 post를 가져온다
			postList.add(getPostById(timeLine.getPostId()));
		}
		
		return postList;
	}
	
	public int getPostCount(int ownerId) {
		return postDAO.selectPostCountByUserId(ownerId);
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
		
		Post post=new Post();
		post.setUserId(userId);
		post.setContent(content);
		post.setContentType(contentType);
		post.setImagePath(imageUrl);
		
		int row = postDAO.insertPost(post);
		
		//타임라인 추가
		timeLineBO.insertTimeLine(post.getId(), userId);
		
		if(row == 1) {
			
		}
		
		return row;
	}
	
	public void deletePost(int postId , int userId) {
		Post post= postDAO.selectPostByPostId(postId);
		
		if(userId == post.getUserId()) {
			
			postDAO.deletePost(postId);
			
			//타임라인 삭제
			timeLineBO.deleteTimeLineByPostId(postId);
			
			//1. 파일 삭제
			try {
				fileManagerService.deleteFile(post.getImagePath());
			} catch (IOException e) {
				logger.error("파일 삭제 오류:::::::::::::::"+e.getMessage());
			}
			//2. 댓글 삭제
			commentBO.deleteCommentByPostId(postId);
			//3. 라이크 삭제
			likeBO.deleteLikeByPostId(postId);
			//4. 해당 게시글 핀 정보 삭제하기
			pinBO.deletePinByPostId(postId);
		}
	}
	
}
