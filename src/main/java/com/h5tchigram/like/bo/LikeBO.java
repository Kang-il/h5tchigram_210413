package com.h5tchigram.like.bo;

import java.util.List;	

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public void insertLikeByUserIdAndPostId(int userId, int postId) {
		likeDAO.insertLikeByUserIdAndPostId(userId, postId);
	}
	public void deleteLikeByUserIdAndPostId(int userId, int postId) {
		likeDAO.deleteLikeByUserIdAndPostId(userId, postId);
	}

}
