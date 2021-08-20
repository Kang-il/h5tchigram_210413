package com.h5tchigram.post.model;

import java.util.Date;
import java.util.List;

import com.h5tchigram.comment.model.Comment;
import com.h5tchigram.like.model.Like;

public class Post {
	private Integer id;
	private Integer userId;
	private String contentType;
	private String content;
	private String imagePath;
	private Date createdAt;
	private Date updatedAt;
	
	private String userLoginId;
	private String profileImagePath;
	
	private List<Like> likeList;
	private List<Comment> CommentList;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getContentType() {
		return contentType;
	}
	public void setContentType(String contentType) {
		this.contentType = contentType;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getImagePath() {
		return imagePath;
	}
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public Date getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
	public String getUserLoginId() {
		return userLoginId;
	}
	public void setUserLoginId(String userLoginId) {
		this.userLoginId = userLoginId;
	}
	public String getProfileImagePath() {
		return profileImagePath;
	}
	public void setProfileImagePath(String profileImagePath) {
		this.profileImagePath = profileImagePath;
	}
	public List<Like> getLikeList() {
		return likeList;
	}
	public void setLikeList(List<Like> likeList) {
		this.likeList = likeList;
	}
	public List<Comment> getCommentList() {
		return CommentList;
	}
	public void setCommentList(List<Comment> commentList) {
		CommentList = commentList;
	}
	
	
	
}
