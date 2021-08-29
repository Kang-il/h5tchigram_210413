package com.h5tchigram.like;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Stack;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.h5tchigram.follow.bo.FollowBO;
import com.h5tchigram.like.bo.LikeBO;
import com.h5tchigram.like.model.Like;
import com.h5tchigram.user.model.User;

@RequestMapping("/like")
@RestController
public class LikeRestController {
	
	@Autowired
	private LikeBO likeBO;
	@Autowired
	private FollowBO followBO;
	
	private Logger logger=LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping("/check_like")
	public Map<String,Boolean> checkLike(@RequestParam("postId") int postId, HttpServletRequest request){
		//해당 포스터의 like여부를 체크하기 위한 메서드
		HttpSession session =request.getSession();
		User user=(User)session.getAttribute("user");
		
		Map<String,Boolean> result=new HashMap<>();
		Like like=null;
		
		if(user!=null) {
			//로그인 되어있을 경우 실행
			like = likeBO.getLikeByUserIdAndPostId(user.getId(), postId);
		}
		
		if(like==null) {
			//like가 없을 경우 false
			result.put("result", false);
		}else {
			//like되어있을 경우 true
			result.put("result", true);
		}
		
		return result;
	}
	
	//TODO 로그인 체크 보내주기
	@PostMapping("/set_like/{postId}")
	public Map<String,Object> insertLike(@PathVariable("postId") int postId
									    , @RequestParam("userId") int userId
										, HttpServletRequest request){
		HttpSession session =request.getSession();
		User user=(User)session.getAttribute("user");
		
		Map<String,Object> result=new HashMap<>();
		if(user!=null) {
			//로그인 되어있을 경우 실행
			if(likeBO.getLikeByUserIdAndPostId(user.getId(), postId)==null) {
				
				likeBO.insertLikeByUserIdAndPostId(user.getId(), postId, userId);
				
			}else {
				likeBO.deleteLikeByUserIdAndPostId(user.getId(), postId);
			}
			
			//스택구조 후입선출 구조 이용
			//제일 마지막에 자신을 넣음. pop을 통해 꺼내는 순간 자신의 아이디가 나옴
			Stack<Integer> followingList=followBO.getFollowerOnlyUserId(user.getId());
			followingList.push(user.getId());
			
			//::::::::::::::: 좋아요 누른 유저 목록과 그 유저를 내가 팔로우 했는지 여부를 보내줘 동적으로 값을 변경 할 예정
			//로그인 체크 여부 
			result.put("loginCheck",true);
			//팔로잉 리스트
			result.put("followingList",followingList);
			//좋아요 목록
			result.put("likeList", likeBO.getLikeListByPostId(postId));
			//DB통신 결과
			result.put("result", true);
			
		}else {
			//로그인 되어있지 않을 경우
			result.put("result",false);
			result.put("loginCheck",false);
		}
		
		return result;
		
	}
	
	@RequestMapping("/get_like_list")
	public Map<String,Object> getLikeList(@RequestParam("postId")int postId
										 ,HttpServletRequest request
										 ){
		
		HttpSession session=request.getSession();
		User user=(User)session.getAttribute("user");
		
		Map<String,Object> result=new HashMap<>();
		
		if(user!=null) {
			Stack<Integer> followList=followBO.getFollowerOnlyUserId(user.getId());
			followList.push(user.getId());
			
			List<Like> likeList=likeBO.getLikeListByPostId(postId);
			
			result.put("loginCheck", true);
			result.put("followingList", followList);
			result.put("likeList", likeList);
			logger.debug("::::::::::::::"+likeList);
			logger.debug("::::::::::::::"+followList);
			
		}else {
			result.put("loginCheck", false);
		}
		
		
		return result;
	}
	

}
