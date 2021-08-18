package com.h5tchigram.timeline;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.h5tchigram.user.model.User;

@RequestMapping("/timeline")
@Controller
public class TimelineController {

	private Date date=new Date();
	
	@RequestMapping("/timeline_view")
	public String mainLayout(Model model, HttpServletRequest request) {
		model.addAttribute("currentTime", date.getTime());
		//TODO userId 세션에서 받아오기 
		HttpSession session=request.getSession();
		
		User user=(User)session.getAttribute("user");
		
		if(user==null) {
			return "redirect:/user/sign_in_view";
		}
		if(user!=null) {
			//TODO:: 포스트가져오기 댓글 가져오기 코멘트 가져오기
		}

		return "template/timeline_layout";
	}
	
	
	
}
