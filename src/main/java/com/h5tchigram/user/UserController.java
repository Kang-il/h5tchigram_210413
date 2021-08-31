package com.h5tchigram.user;

import java.util.Date;		
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.h5tchigram.alert.bo.AlertTimelineBO;
import com.h5tchigram.alert.model.AlertTimeLine;
import com.h5tchigram.follow.bo.FollowBO;
import com.h5tchigram.follow.model.Follow;
import com.h5tchigram.post.bo.PostBO;
import com.h5tchigram.post.model.PostThumbnail;
import com.h5tchigram.user.bo.UserBO;
import com.h5tchigram.user.model.User;

@Controller
@RequestMapping("/user")
public class UserController {
	private Date date =new Date();
	
	@Autowired
	private UserBO userBO;
	@Autowired
	private PostBO postBO;
	@Autowired
	private FollowBO followBO;
	@Autowired
	private AlertTimelineBO alertTimeLineBO;
	
	private Logger logger=LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping("/sign_in_view")
	public String signInView(Model model) {
		
		model.addAttribute("currentTime", date.getTime());
		model.addAttribute("userView","sign_in");
		return "template/user_sign_layout";
	}
	
	@RequestMapping("/sign_up_view")
	public String signUpView(Model model) {
		
		model.addAttribute("currentTime", date.getTime());
		model.addAttribute("userView","sign_up");
		return "template/user_sign_layout";
	}
	
	@RequestMapping("/sign_out")
	public String signOut(HttpServletRequest request){
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/user/sign_in_view";
	}
	
	@RequestMapping("/feed/{userLoginId}")
	public String mainView(Model model
						  ,@PathVariable("userLoginId") String userLoginId //해당 프로필을 찾는다.
						  ,@RequestParam(value="category",required=false) String category
						  ,HttpServletRequest request) {
		
		
		model.addAttribute("currentTime", date.getTime());
		User feedOwner=null;
		
		
		//로그인내용 받아오기
		HttpSession session=request.getSession();
		User user=(User)session.getAttribute("user");
		
		if(userLoginId==null) {// 잘못된 접근 막기
			return "redirect:/user/sign_in_view";
		}else {
			feedOwner=userBO.getUserByUserLoginId(userLoginId);
		}
		
		int checkUrl=-1;
		
		if(feedOwner!=null){//해당 경로가 있다.
			checkUrl=1;
		}
		
		
		
		if(user!=null) {
			//로그인 되어있는경우 자신의 알람을 뿌린다.
			List<AlertTimeLine> alertTimelineList=alertTimeLineBO.getAlertListByReceiveUserId(user.getId());
			model.addAttribute("alertList",alertTimelineList);
			
			if(checkUrl==-1) {//잘못된 경로를 입력했는데 로그인이 되어있는 경우
				//자신의 피드로 리다이렉트 시킨다.
				return "redirect:/user/feed/"+user.getLoginId();
			}else if(checkUrl==1) {
			
				//로그인 된 경우
				//1. 본인 피드인지 비교
				//2. 본인피드라면 본인 피드가 맞는 boolean true 보내기 아니라면 false
				//3. 내가 팔로우 한 유저인지 체크
				if(user.getLoginId().equals(userLoginId)) {
					model.addAttribute("checkMyFeed", true);
					
					//user 에 본인의 정보
					
				}else {
					model.addAttribute("checkMyFeed", false);
					//나의 아이디 저장!
					int myId=user.getId();
					
					//내 피드가 아니라면 피드 주인 정보 가져오기
					user=userBO.getUserByUserLoginId(userLoginId);
					Follow followCheck=followBO.getFollowByFollowingUserIdAndFollowerUserId(myId,user.getId());
				
					if(followCheck!=null) {
						model.addAttribute("checkFollowing",false);
					}else {
						model.addAttribute("checkFollowing", true);
					}
					
					
					//user에 남의 정보
				}
				
				
			}
			
			
		}else if(user==null){
			//로그인 되어있지 않은데 경로도 잘못 된 경우
			if(checkUrl==-1) {
				return "redirect:/user/sign_in_view";
			}else if(checkUrl==1) {
				//로그인 안된경우
				//팔로우 체크 필요없음
				//내 피드 아님으로 간주
				model.addAttribute("checkMyFeed", false);
				//피드주인 정보 가져오기
				user=userBO.getUserByUserLoginId(userLoginId);
				//checkFollowing 에 null이 들어있다면 로그인 되어있지 않음?
				model.addAttribute("checkFollowing",null);
				//유저에 피드 주인정보(나인지 남인지 모름)
			}
		}
		
		model.addAttribute("feedOwner", user);
		
		List<PostThumbnail> postThumbnailList=null;
		
		int postCount =postBO.getPostCount(user.getId());
		
		if(category == null || category.equals("all")) {
			postThumbnailList = postBO.getPostThumbnailListByOwnerId(user.getId(),null);
		}else if(category.equals("photo") || category.equals("video") ) {
			postThumbnailList = postBO.getPostThumbnailListByOwnerId(user.getId(),category);
		}else if(category.equals("pinned")) {
			//TODO  pin한 이미지 썸네일 가져오기 
			postThumbnailList=postBO.getPinedPostThumbnailListByOwnerId(user.getId());
		}
		model.addAttribute("category",category);
		
		
		//팔로우 수를 세준다.
		//팔로우 수 클릭하는 순간 ajax 통신을 통해 리스트를 받아올 예정
		int followingCount=followBO.getFollowCountByFollowingUserId(user.getId());
		int followerCount=followBO.getFollowCountByFollowerUserId(user.getId());
		

		// 피드주인의 포스트썸네일 가져오기
		
		
		//model로 가공된 포스트리스트를 전달함
		model.addAttribute("postThumbnailList", postThumbnailList);
		model.addAttribute("postCount",postCount);
		model.addAttribute("followingCount", followingCount);
		model.addAttribute("followerCount", followerCount);
		
		
		return "template/user_profile_layout";
	}
	
}
