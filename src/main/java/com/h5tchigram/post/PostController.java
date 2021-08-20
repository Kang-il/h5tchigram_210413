package com.h5tchigram.post;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


import com.h5tchigram.user.model.User;


@Controller
@RequestMapping("/post")
public class PostController {
	private Date date=new Date();

	@RequestMapping("/post_detail_view")
	public String postDetailView(Model model) {
		model.addAttribute("currentTime",date.getTime());
		model.addAttribute("userView","content_detail");
		return"template/post_content_layout";
	}
	
	@RequestMapping("/create_post_view")
	public String createPostView(Model model,HttpServletRequest request){
		model.addAttribute("currentTime",date.getTime());
		
		HttpSession session=request.getSession();
		User user=(User)session.getAttribute("user");
		
		//session 에 user 정보가 없다면 로그인 페이지로 리다이렉트 시킨다.
		if(user == null) {
			return "redirect:/user/sign_in_view";
		}
		
		model.addAttribute("userView","post_create");
		return"/template/post_content_layout";
	}
	

	
	

}
