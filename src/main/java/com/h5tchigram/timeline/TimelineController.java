package com.h5tchigram.timeline;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.h5tchigram.alert.bo.AlertTimelineBO;
import com.h5tchigram.alert.model.AlertTimeLine;
import com.h5tchigram.like.bo.LikeBO;
import com.h5tchigram.like.model.Like;
import com.h5tchigram.pin.model.Pin;
import com.h5tchigram.post.bo.PostBO;
import com.h5tchigram.post.model.Post;
import com.h5tchigram.user.model.User;

@RequestMapping("/timeline")
@Controller
public class TimelineController {
	
	@Autowired
	private PostBO postBO;
	
	@Autowired
	private LikeBO likeBO;
	
	@Autowired
	private com.h5tchigram.pin.bo.PinBO pinBO;
	
	@Autowired
	private AlertTimelineBO alertTimeLineBO;
	
	private Date date=new Date();
	
	@RequestMapping("/timeline_view")
	public String mainLayout(Model model, HttpServletRequest request) {
		
		model.addAttribute("currentTime", date.getTime());
		//TODO userId 세션에서 받아오기 
		HttpSession session=request.getSession();
		
		User user=(User)session.getAttribute("user");
		
		if(user==null) {
			return "redirect:/user/sign_in_view";
		}else if(user!=null) {
			//TODO:: 포스트가져오기 댓글 가져오기 코멘트 가져오기
			List<AlertTimeLine> alertTimeLineList=alertTimeLineBO.getAlertListByReceiveUserId(user.getId());
			List<Post> postList=postBO.getPostListByTimeLine(user.getId());
			List<Like> likeList=likeBO.getLikeListByUserId(user.getId());
			List<Pin> pinList = pinBO.getPinListUserId(user.getId());
			
			
			model.addAttribute("postList",postList);
			model.addAttribute("likeList", likeList);
			model.addAttribute("pinList",pinList);
			model.addAttribute("alertList", alertTimeLineList);
			
		}

		return "template/timeline_layout";
	}
	
	
	
}
