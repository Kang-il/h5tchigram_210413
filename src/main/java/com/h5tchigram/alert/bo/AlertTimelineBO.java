package com.h5tchigram.alert.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.h5tchigram.alert.model.Alert;
import com.h5tchigram.alert.model.AlertTimeline;
import com.h5tchigram.alert.model.CommentAlert;
import com.h5tchigram.alert.model.FollowAlert;
import com.h5tchigram.alert.model.LikeAlert;
import com.h5tchigram.comment.bo.CommentBO;
import com.h5tchigram.comment.model.Comment;
import com.h5tchigram.follow.bo.FollowBO;
import com.h5tchigram.follow.model.Follow;
import com.h5tchigram.post.bo.PostBO;
import com.h5tchigram.post.model.Post;
import com.h5tchigram.user.bo.UserBO;
import com.h5tchigram.user.model.User;

@Service
public class AlertTimelineBO {

	@Autowired
	private UserBO userBO;
	@Autowired
	private PostBO postBO;
	@Autowired
	private CommentBO commentBO;
	@Autowired
	private FollowBO followBO;
	@Autowired
	private AlertBO alertBO;
	@Autowired
	private CommentAlertBO commentAlertBO;
	@Autowired
	private FollowAlertBO followAlertBO;
	@Autowired
	private LikeAlertBO likeAlertBO;
	
	public List<AlertTimeline> getAlertListByReceiveUserId(int receiveUserId){
		List<Alert> alertList=alertBO.getAlertListByReceiveUserId(receiveUserId);
		List<AlertTimeline> alertTimelineList= new ArrayList<>();
		
		for( Alert alert : alertList ) {
			
			User user=userBO.getUserById(alert.getSendUserId());
			
			if(alert.getAlertType().equals("like")) {
				//넣어줄 사항
				LikeAlert likeAlert = likeAlertBO.getLikeAlertByAlertId(alert.getId());
				Post post=postBO.getOnlyPostById(likeAlert.getPostId());
				//alertType
				//sendUserId
				//receiveUserId
				//sendUserLoginId
				//sendUserProfileImagePath
				//postImagePath
				
				//알람타입
				likeAlert.setAlertType(alert.getAlertType());
				//보내는 사람의 아이디
				likeAlert.setSendUserId(alert.getSendUserId());
				//받는 사람 아이디
				likeAlert.setReceiveUserId(alert.getReceiveUserId());
				//받는 사람 로그인 아이디
				likeAlert.setSendUserLoginId(user.getLoginId());
				//받는 사람 프로필사진
				likeAlert.setSendUserProfileImagePath(user.getProfileImagePath());
				//알람을 받는 대상 게시물
				likeAlert.setPostImagePath(post.getImagePath());
				
				alertTimelineList.add(likeAlert);
				
			}else if(alert.getAlertType().equals("comment")) {
				//댓글 내용 가져오기
				CommentAlert commentAlert=commentAlertBO.getCommentAlertByAlertId(alert.getId());
				Post post =postBO.getOnlyPostById(commentAlert.getPostId());
				Comment comment=commentBO.getCommentById(commentAlert.getCommentId());
				
				//alertType
				//sendUserId
				//receiveUserId
				//sendUserLoginId
				//sendUserProfileImagePath
				//postImagePath
				
				//알람타입
				commentAlert.setAlertType(alert.getAlertType());
				//보내는 사람 아이디
				commentAlert.setSendUserId(alert.getSendUserId());
				//받는 사람 아이디
				commentAlert.setReceiveUserId(alert.getReceiveUserId());
				//보내는 사람 로그인 아이디
				commentAlert.setSendUserLoginId(user.getLoginId());
				//보내는 사람 프로필 사진
				commentAlert.setSendUserProfileImagePath(user.getProfileImagePath());
				//알람을 받는 대상 게시물
				commentAlert.setPostImagePath(post.getImagePath());
				
				commentAlert.setComment(comment.getComment());
				
				alertTimelineList.add(commentAlert);
			}else if(alert.getAlertType().equals("follow")) {
				
				FollowAlert followAlert=followAlertBO.getFollowAlertByAlertId(alert.getId());
				
				//알람을 받는 사람 입장에서 팔로우가 되어있는지 확인
				Follow follow=followBO.getFollowByFollowingUserIdAndFollowerUserId(alert.getReceiveUserId(), alert.getSendUserId());
				//alertType
				//sendUserId
				//receiveUserId
				//sendUserLoginId
				//sendUserProfileImagePath
				
				//알람타입
				followAlert.setAlertType(alert.getAlertType());
				//보내는 사람 아이디
				followAlert.setSendUserId(alert.getSendUserId());
				//받는 사람 아이디
				followAlert.setReceiveUserId(alert.getReceiveUserId());
				//보내는 사람 로그인 아이디
				followAlert.setSendUserLoginId(user.getLoginId());
				//보내는 사람 프로필 사진
				followAlert.setSendUserProfileImagePath(user.getProfileImagePath());
				
				if(follow!=null) {
					followAlert.setCheckFollowing(true);
				}else {
					followAlert.setCheckFollowing(false);
				}
				
				
				alertTimelineList.add(followAlert);
			}
		}
		
		
		
		
		
		return alertTimelineList;
	}
}
