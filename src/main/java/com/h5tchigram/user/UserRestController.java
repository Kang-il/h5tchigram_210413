package com.h5tchigram.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.h5tchigram.common.EncryptUtils;
import com.h5tchigram.user.bo.UserBO;
import com.h5tchigram.user.model.User;


@RequestMapping("/user")
@RestController
public class UserRestController {

	@Autowired
	private UserBO userBO;
	
	@RequestMapping("/is_duplication_id")
	public Map<String, Boolean> isDuplicationId(@RequestParam("signUpId") String loginId){
		Map<String,Boolean> result =new HashMap<>();
		User user=userBO.getUserById(loginId);
		if(user!=null) {
			result.put("result", true);
		}else {
			result.put("result", false);
		}
		return result;
	}
	
	@PostMapping("/sign_up")
	public Map<String,Boolean> signUp(@ModelAttribute User user){
		Map<String,Boolean> result=new HashMap<>();
			
			//비밀번호 해쉬로 변환
			String encriptPassword=EncryptUtils.mb5(user.getPassword());
			user.setPassword(encriptPassword);
			
			Integer check=userBO.insertUser(user);
			
			if(check==null) {
				result.put("result", false);
			}else{
				result.put("result", true);
			}
			
		return result;
	}
	

}
