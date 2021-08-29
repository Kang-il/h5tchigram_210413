package com.h5tchigram.comment.bo;

import java.util.List;	

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.h5tchigram.alert.bo.CommentAlertBO;
import com.h5tchigram.comment.dao.CommentDAO;
import com.h5tchigram.comment.model.Comment;
import com.h5tchigram.user.bo.UserBO;
import com.h5tchigram.user.model.User;

@Service
public class CommentBO {
	
	@Autowired
	private CommentDAO commentDAO;
	
	@Autowired
	private UserBO userBO;
	
	
	@Autowired
	private CommentAlertBO commentAlertBO;
	
	public Comment getCommentById(int commentId) {
		return commentDAO.selectCommentById(commentId);
	}
	
	public int getCommentCountByPostId(int postId) {
		return commentDAO.selectCommentCountByPostId(postId);
	}
	
	public List<Comment> getCommentListByPostId(int postId){
		List<Comment> commentList= commentDAO.selectCommentListByPostId(postId);
		
		 for(Comment comment : commentList) {
			 //commentList 에 각 comment 객체에 유저의 로그인 아이디와 프로필사진 이미지 경로를 받아 값을 넣어준다.
			User user=userBO.getUserLoginIdAndProfileImagePathById(comment.getUserId());
			comment.setUserLoginId(user.getLoginId());
			comment.setProfileImagePath(user.getProfileImagePath());
		 }
		return commentList;
	}
	
	public void insertComment(int userId, int postId , int postUserId , String content) {
		
		Comment comment=new Comment();
		comment.setUserId(userId);
		comment.setPostId(postId);
		comment.setComment(content);
		
		commentDAO.insertComment(comment);
		
		
		if(userId!=postUserId) {
			commentAlertBO.createCommentAlert(userId, postUserId, postId, comment.getId());
		}
	}
	public void deleteCommentById(int commentId){
		//commentId 를 통해 commentAlert제거
		commentAlertBO.deleteCommentAlertByCommentId(commentId);
		//commentId 를 통해 comment제거
		commentDAO.deleteCommentById(commentId);
		
		
	}
	
	public void deleteCommentByPostId(int postId) {
		//게시글을 지울 경우 실행
		commentDAO.deleteCommentByPostId(postId);
		//postId로 해당 포스트에 달려있는 댓글 모두 삭제하기
		commentAlertBO.deleteCommentAlertByPostId(postId);
	}
	
}
