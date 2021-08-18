package com.h5tchigram.post;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.h5tchigram.post.bo.CommentBO;
import com.h5tchigram.post.bo.LikeBO;
import com.h5tchigram.post.bo.PostBO;


@Controller
@RequestMapping("/post")
public class PostController {
	private Date date=new Date();
	
	@Autowired
	private PostBO postBO;
	@Autowired
	private CommentBO commentBO;
	@Autowired
	private LikeBO likeBO;
	
	@RequestMapping("/post_detail_view")
	public String postDetailView(Model model) {
		model.addAttribute("currentTime",date.getTime());
		model.addAttribute("userView","content_detail");
		return"template/post_content_layout";
	}
	
	@RequestMapping("/create_post_view")
	public String createPostView(Model model){
		model.addAttribute("currentTime",date.getTime());
		model.addAttribute("userView","post_create");
		return"/template/post_content_layout";
	}
	

	
	

}
