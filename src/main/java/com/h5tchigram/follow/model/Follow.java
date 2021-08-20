package com.h5tchigram.follow.model;

import java.util.Date;

public class Follow {
	
	private Integer id;
	private Integer followingUserId;
	private Integer followerUserId;
	private Date createdAt;
	

	private String followUserLoginId;
	private String followProfileImagePath;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getFollowingUserId() {
		return followingUserId;
	}
	public void setFollowingUserId(Integer followingUserId) {
		this.followingUserId = followingUserId;
	}
	public Integer getFollowerUserId() {
		return followerUserId;
	}
	public void setFollowerUserId(Integer followerUserId) {
		this.followerUserId = followerUserId;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public String getFollowUserLoginId() {
		return followUserLoginId;
	}
	public void setFollowUserLoginId(String followUserLoginId) {
		this.followUserLoginId = followUserLoginId;
	}
	public String getFollowProfileImagePath() {
		return followProfileImagePath;
	}
	public void setFollowProfileImagePath(String followProfileImagePath) {
		this.followProfileImagePath = followProfileImagePath;
	}
	
	
	
	
}
