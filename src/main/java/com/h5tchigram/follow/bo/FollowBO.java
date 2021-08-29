package com.h5tchigram.follow.bo;

import java.util.List;	
import java.util.Stack;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.h5tchigram.alert.bo.FollowAlertBO;
import com.h5tchigram.follow.dao.FollowDAO;
import com.h5tchigram.follow.model.Follow;
import com.h5tchigram.user.bo.UserBO;
import com.h5tchigram.user.model.User;

@Service
public class FollowBO {
	@Autowired
	private FollowDAO followDAO;
	@Autowired
	private UserBO userBO;
	@Autowired
	private FollowAlertBO followAlertBO;
	
	
	private Logger logger=LoggerFactory.getLogger(this.getClass());
	
	public List<Follow> getFollowListByFollowingUserId(int followingUserId) {
		List<Follow> followingList = followDAO.selectFollowListByFollowingUserId(followingUserId);

		// 팔로잉 아이디에 자신이 담겨있으면 내가 팔로우 하는 사람
		// 팔로워 유저아이디와 사진경로를 담아주기
		for (Follow following : followingList) {
			User followingUser = userBO.getUserById(following.getFollowerUserId());
			following.setFollowUserLoginId(followingUser.getLoginId());
			following.setFollowProfileImagePath(followingUser.getProfileImagePath());
			logger.debug(":::::::::::::::"+following.getFollowUserLoginId());
		}

		return followingList;
	}

	public List<Follow> getFollowListByFollowerUserId(int followerUserId) {
		List<Follow> followerList = followDAO.selectFollowListByFollowerUserId(followerUserId);

		// 팔로워 아이디에 자신이 담겨있으면 나를 팔로우 하는 사람
		// 팔로워 유저아이디와 사진경로를 담아주기
		for (Follow follower : followerList) {
			User followerUser = userBO.getUserById(follower.getFollowingUserId());
			follower.setFollowUserLoginId(followerUser.getLoginId());
			follower.setFollowProfileImagePath(followerUser.getProfileImagePath());
			logger.debug(":::::::::::::::"+follower.getFollowUserLoginId());
		}

		return followerList;
	}

	public int getFollowCountByFollowerUserId(int followerUserId) {
		return followDAO.selectFollowCountByFollowerUserId(followerUserId);
	}

	public int getFollowCountByFollowingUserId(int followingUserId) {
		return followDAO.selectFollowCountByFollowingUserId(followingUserId);
	}

	public Follow getFollowByFollowingUserIdAndFollowerUserId(int followingUserId, int followerUserId) {
		return followDAO.selectFollowByFollowingUserIdAndFollowerUserId(followingUserId, followerUserId);
	}

	// 비교하기 쉽게 번호만 가져갈 수 있도록 가공
	public Stack<Integer> getFollowerOnlyUserId(int followerUserId) {
		Stack<Integer> followingUserIdList = new Stack<>();

		List<Follow> followList = followDAO.selectFollowListByFollowingUserId(followerUserId);

		// 숫자조합으로 가공하여 뷰 페이지에서 이용하기 쉽도록
		for (Follow following : followList) {
			followingUserIdList.push(following.getFollowerUserId());
		}

		return followingUserIdList;
	}
	
	public void insertFollow(int followingUserId,int followerUserId) {
		
		Follow follow=new Follow();
		follow.setFollowingUserId(followingUserId);
		follow.setFollowerUserId(followerUserId);
		
		//팔로우 삽입
		followDAO.insertFollow(follow);
		
		// 알람 아이디를 넣어줌
		followAlertBO.createFollowAlert(followingUserId,followerUserId,follow.getId());
	}
	
	public void deleteFollow(int followingUserId,int followerUserId) {
		
		Follow follow=followDAO.selectFollowByFollowingUserIdAndFollowerUserId(followingUserId, followerUserId);
		//팔로우 알림을 지워준다.
		followAlertBO.deleteFollowAlertByFollowId(follow.getId());
		
		followDAO.deleteFollow(followingUserId, followerUserId);
		
	}
}
