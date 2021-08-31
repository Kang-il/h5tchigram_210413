package com.h5tchigram.alert.model;

import java.util.Date;

public class FollowAlert implements AlertTimeLine{
	//alert TABLE 정보
	private int alertId;// FK -- Alert TABLE에서 참조
	private String alertType;
	private int sendUserId; // 팔로잉 유저
	private int receiveUserId; //팔로우 당하는 유저
		
	//followAlert TABLE 정보
	private int id;
	private int followId;
	private Date createdAt;
	
	//추가사항
	private String sendUserLoginId;
	private String sendUserProfileImagePath;
	private boolean checkFollowing;
	
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
	public int getFollowId() {
		return followId;
	}
	public void setFollowId(int followId) {
		this.followId = followId;
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
	public boolean isCheckFollowing() {
		return checkFollowing;
	}
	public void setCheckFollowing(boolean checkFollowing) {
		this.checkFollowing = checkFollowing;
	}
	
}
