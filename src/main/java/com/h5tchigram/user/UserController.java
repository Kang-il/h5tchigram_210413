package com.h5tchigram.user;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
public class UserController {
	private Date date =new Date();
	
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
}
