package com.h5tchigram.pin;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.h5tchigram.pin.bo.pinBO;
import com.h5tchigram.user.model.User;

@RequestMapping("/pin")
@RestController
public class PinRestController {

	@Autowired
	private pinBO pinBO;
	
	@RequestMapping("/check_pin")
	public Map<String,Boolean> checkPin(@RequestParam("postId") int postId
										,HttpServletRequest request){
		
		Map<String, Boolean> result=new HashMap<>();
		HttpSession session=request.getSession();
		User user=(User)session.getAttribute("user");
		
		
		if(user!=null) {
			//유저 아이디와 포스트 아이디로 데이터가 있는지 확인
			if(pinBO.getPinByPostIdAndUserId(postId,user.getId())!=null) {
				//있으면 저장된 컨텐츠
				result.put("result", true);
			}else {
				//없으면 저장 안된 컨텐츠
				result.put("result", false);
			}
		}
		
		return result;	
	}
	
	@RequestMapping("/create_pin")
	public Map<String,Boolean> createPin(@RequestParam("postId") int postId,HttpServletRequest request){
		Map<String, Boolean> result=new HashMap<>();
		HttpSession session=request.getSession();
		User user=(User)session.getAttribute("user");
		if(user!=null) {
			int row = pinBO.insertPin(postId,user.getId());
			
			if(row==0) {
				//실패
				result.put("result", false);
			}else if(row==1){
				//성공
				result.put("result", true);
			}
			
		}
		
		return result;
	}
	
	@RequestMapping("/delete_pin")
	public Map<String,Boolean> deletePin(@RequestParam("postId") int postId, HttpServletRequest request){
		Map<String, Boolean> result=new HashMap<>();
		HttpSession session=request.getSession();
		User user=(User)session.getAttribute("user");
		if(user!=null) {
			int row=pinBO.deletePin(postId,user.getId());
			
			if(row==0) {
				//실패
				result.put("result", false);
			}else if(row==1){
				//성공
				result.put("result", true);
			}
			
		}
		return result;
	}
	
}
