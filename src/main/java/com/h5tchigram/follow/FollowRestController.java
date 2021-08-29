package com.h5tchigram.follow;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Stack;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.h5tchigram.follow.bo.FollowBO;
import com.h5tchigram.follow.model.Follow;
import com.h5tchigram.user.model.User;

@RequestMapping("/follow")
@RestController
public class FollowRestController {

	@Autowired
	private FollowBO followBO;

	@PostMapping("/get_following")
	public Map<String, Object> getFollowing(@RequestParam("feedOwnerId") int feedOwnerId
										  , HttpServletRequest request) {
		
		// feedOwner의 아이디를 가져와서 피드 주인이 팔로우한 인원들을 가져올 것
		Map<String, Object> result = new HashMap<>();
		// 1. 나의 로그인 유무 가져오기
		// 2. 내가 팔로우 하고있는 사람들 목록 가져오기
		// 3. 팔로우/팔로잉 멤버에 내가 있는경우 별도 처리(내 피드말고 남의 피드를 보았을때)

		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");

		getMyFollowingList(user, result);

		// 팔로잉 구하기 -- 팔로워아이디 내가 팔로우하는사람
		List<Follow> followingList = followBO.getFollowListByFollowingUserId(feedOwnerId);

		result.put("followList", followingList);

		return result;
	}

	@PostMapping("/get_follower")
	public Map<String, Object> getFollower(@RequestParam("feedOwnerId") int feedOwnerId, 
										   HttpServletRequest request) {
		
		// feedOwner의 아이디를 가져와서 팔로워들을 가져올 것
		Map<String, Object> result = new HashMap<>();
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");

		getMyFollowingList(user, result);

		// 팔로워 구하기 --- 팔로잉에 나를 팔로우 하는 사람
		List<Follow> followerList = followBO.getFollowListByFollowerUserId(feedOwnerId);

		result.put("followList", followerList);

		return result;
	}

	private void getMyFollowingList(User user, Map<String, Object> result) {
		
		Stack<Integer> followingList = null;

		if (user != null) {
			// 내가 로그인 한 경우
			result.put("loginCheck", true);
			// 로그인 한 경우 나의 팔로워멤버를 가져옴
			followingList = followBO.getFollowerOnlyUserId(user.getId());
			// 나의 아이디를 가장 끝에 넣어줌
			followingList.push(user.getId());

			result.put("loginUserFollowingList", followingList);
		} else {
			result.put("loginCheck", false);
		}

	}

	@PostMapping("/do_follow")
	public Map<String, Object> doFollow(@RequestParam("followId") int followId
										,@RequestParam(value="feedOwnerId",required=false) Integer feedOwnerId
										,HttpServletRequest request) {
		
		Map<String, Object> result = new HashMap<>();
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");

		if (user != null) {
			// 로그인체크
			result.put("loginCheck", true);
			if (followBO.getFollowByFollowingUserIdAndFollowerUserId(user.getId(), followId) == null) {

				// 내가 팔로우 하지 않은 상태에서만 팔로우를 진행 할 것이다.
				followBO.insertFollow(user.getId(), followId);
				if(feedOwnerId!=null) {
					if (user.getId() == feedOwnerId) {// 내 피드
						
						int followingCount = followBO.getFollowCountByFollowingUserId(user.getId());
						int followerCount = followBO.getFollowCountByFollowerUserId(user.getId());
						result.put("followingCount", followingCount);
						result.put("followerCount", followerCount);
						result.put("checkMyFeed", true);
						
					} else {//내 피드 아님
						result.put("checkMyFeed", false);
					}
				}
				result.put("result", true);
				
			} else {// null이 아니라면 이미 팔로우 한 상태 
				result.put("result", false);
			}

		} else {
			result.put("loginCheck", false);
		}

		return result;

	}

	@RequestMapping("/do_unfollow")
	public Map<String, Object> doUnFollow(@RequestParam("followId") int followId
										, @RequestParam(value="feedOwnerId",required=false) Integer feedOwnerId
										, HttpServletRequest request) {
		
		Map<String, Object> result = new HashMap<>();
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");

		if (user != null) {
			// 로그인 체크
			result.put("loginCheck", true);
			if (followBO.getFollowByFollowingUserIdAndFollowerUserId(user.getId(), followId) != null) {//팔로우 하고있다.
				// 팔로우 한 상대여야 팔로우 취소를 진행 할 것이다.
				followBO.deleteFollow(user.getId(), followId);
				if(feedOwnerId!=null) {
					if (user.getId() == feedOwnerId) {// 내 피드라는 뜻
						int followingCount = followBO.getFollowCountByFollowingUserId(user.getId());
						int followerCount = followBO.getFollowCountByFollowerUserId(user.getId());
						result.put("checkMyFeed", true);
						result.put("followingCount", followingCount);
						result.put("followerCount", followerCount);
					}else {//내 피드가 아님
						result.put("checkMyFeed", false);
					}
				}
				//언팔로우 성공
				result.put("result", true);
				
			}else {//팔로우 하지 않고 있다.
				result.put("result", false);
			}

		}else {
			
			//언팔로우 실패
			result.put("loginCheck", false);
		}

		return result;

	}

}
