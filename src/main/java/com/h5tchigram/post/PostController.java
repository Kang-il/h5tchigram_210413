package com.h5tchigram.post;

import java.util.Date;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/post")
public class PostController {
	private Date date=new Date();
	
	@RequestMapping("/timeline_view")
	public String mainLayout(Model model) {
		model.addAttribute("currentTime", date.getTime());
		return "template/post_layout";
	}
	

}
