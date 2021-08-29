package com.h5tchigram.alert.model;

import java.util.Date;

public class CommentAlert implements AlertTimeline{
	//alert TABLE 정보
	private int alertId;// FK -- Alert TABLE에서 참조
	private	String alertType;
	private int sendUserId;
	private int receiveUserId;
	
	//commentAlert TABLE 정보
	private int id;
	private int commentId;
	private int postId;
	
	private Date createdAt;
	
	//추가사항
	private String sendUserLoginId;
	private String sendUserProfileImagePath;
	private String postImagePath;
	private String comment;
	
	public int getAlertId() {
		return alertId;
	}
	public void setAlertId(int alertId) {
		this.alertId = alertId;
	}
	public String getAlertType() {
		return alertType;
	}
	public void setAlertType(String alertType) {
		this.alertType = alertType;
	}
	public int getSendUserId() {
		return sendUserId;
	}
	public void setSendUserId(int sendUserId) {
		this.sendUserId = sendUserId;
	}
	public int getReceiveUserId() {
		return receiveUserId;
	}
	public void setReceiveUserId(int receiveUserId) {
		this.receiveUserId = receiveUserId;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCommentId() {
		return commentId;
	}
	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}
	public int getPostId() {
		return postId;
	}
	public void setPostId(int postId) {
		this.postId = postId;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public String getSendUserLoginId() {
		return sendUserLoginId;
	}
	public void setSendUserLoginId(String sendUserLoginId) {
		this.sendUserLoginId = sendUserLoginId;
	}
	public String getSendUserProfileImagePath() {
		return sendUserProfileImagePath;
	}
	public void setSendUserProfileImagePath(String sendUserProfileImagePath) {
		this.sendUserProfileImagePath = sendUserProfileImagePath;
	}
	public String getPostImagePath() {
		return postImagePath;
	}
	public void setPostImagePath(String postImagePath) {
		this.postImagePath = postImagePath;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}

	
	
	
	
}
