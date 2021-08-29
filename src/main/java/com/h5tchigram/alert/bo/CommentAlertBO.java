package com.h5tchigram.alert.bo;

import java.util.List;	

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.h5tchigram.alert.dao.CommentAlertDAO;
import com.h5tchigram.alert.model.Alert;
import com.h5tchigram.alert.model.CommentAlert;

@Service
public class CommentAlertBO {
	@Autowired
	private CommentAlertDAO commentAlertDAO;
	
	@Autowired
	private AlertBO alertBO;
	
	public void createCommentAlert(int userId, int postUserId, int postId, int commentId) {
		
		Alert alert = alertBO.createAlert(userId,postUserId,"comment");
		
		commentAlertDAO.insertCommentAlert(alert.getId(),postId,commentId);
	}
	
	public CommentAlert getCommentAlertByAlertId(int alertId) {
		return commentAlertDAO.selectCommentAlertByAlertId(alertId);
	}
	
	public void deleteCommentAlertByCommentId(int commentId) {
		//댓글 삭제 시 실행
		CommentAlert commentAlert = commentAlertDAO.selectCommentAlertByCommentId(commentId);
		if(commentAlert!=null) {
			alertBO.deleteAlertById(commentAlert.getAlertId());
			commentAlertDAO.deleteCommentAlertByCommentId(commentId);
		}
	}
	
	public void deleteCommentAlertByPostId(int postId) {
		//Post삭제 시 실행
		//1. postId로 commentAlertList를 가져온다
		List<CommentAlert> commentAlertList=commentAlertDAO.selectCommentAlertListByPostId(postId);
		
		//2. 해당 commentAlert의 alertId를 이용해 Alert를 모두 지워준다.
		for(CommentAlert commentAlert : commentAlertList) {
			alertBO.deleteAlertById(commentAlert.getAlertId());
		}
		
		//3. postId로 comment를 지워준다.
		commentAlertDAO.deleteCommentAlertByPostId(postId);
	}
	

}
