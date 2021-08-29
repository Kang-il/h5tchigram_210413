package com.h5tchigram.like.bo;

import java.util.List;	

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.h5tchigram.alert.bo.LikeAlertBO;
import com.h5tchigram.like.dao.LikeDAO;
import com.h5tchigram.like.model.Like;
import com.h5tchigram.user.bo.UserBO;
import com.h5tchigram.user.model.User;


@Service
public class LikeBO {
	
	@Autowired
	private LikeDAO likeDAO;
	@Autowired
	private UserBO userBO;
	@Autowired
	private LikeAlertBO likeAlertBO;
	
	public List<Like> getLikeListByPostId(int postId){
		List<Like> likeList=likeDAO.selectLikeListByPostId(postId);
		//Like에 유저의 정보 삽입
		for(Like like :likeList) {
			User user=userBO.getUserLoginIdAndProfileImagePathById(like.getUserId());
			like.setUserLoginId(user.getLoginId());
			like.setProfileImagePath(user.getProfileImagePath());
		}
	
		return likeList;
	}

	public int getLikeCountByPostId(int postId) {
		return likeDAO.selectLikeCountByPostId(postId);
	}
	
	public Like getLikeByUserIdAndPostId(int userId, int postId) {
		return likeDAO.selectLikeByUserIdAndPostId(userId, postId);
	}
	
	public void insertLikeByUserIdAndPostId(int userId, int postId, int alertReceiveUserId) {
		//알람 생성
		Like like=new Like();
		like.setUserId(userId);
		like.setPostId(postId);
		likeDAO.insertLikeByUserIdAndPostId(like);
		
		if(userId!=alertReceiveUserId){//내가 쓴 포스터에 내가 누른 좋아요는 알람 생성하지 않겠다
			likeAlertBO.createLikeAlert(userId,alertReceiveUserId,postId,like.getId());
		}
	}
	
	public void deleteLikeByUserIdAndPostId(int userId, int postId) {
		//알람 삭제
		//1. Like 불러오기
		Like like = likeDAO.selectLikeByUserIdAndPostId(userId, postId);
		
		likeDAO.deleteLikeByUserIdAndPostId(userId, postId);
		
		likeAlertBO.deleteLikeAlertByLikeId(like.getId());
	}
	
	public void deleteLikeByPostId(int postId) {
		//포스트 아이디로 알람 삭제
		likeDAO.deleteLikeByPostId(postId);
		likeAlertBO.deleteLikeAlertByPostId(postId);
	}

}
