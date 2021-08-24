package com.h5tchigram.comment.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	
	public void deleteCommentByPostId(int postId) {
		commentDAO.deleteCommentByPostId(postId);
	}
	
}
