package com.h5tchigram.post;

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
import org.springframework.web.multipart.MultipartFile;

import com.h5tchigram.follow.bo.FollowBO;
import com.h5tchigram.post.bo.PostBO;
import com.h5tchigram.post.model.Post;
import com.h5tchigram.user.model.User;

@RequestMapping("/post")
@RestController
public class PostRestController {

	@Autowired
	private PostBO postBO;
	@Autowired
	private FollowBO followBO;
	
	
	@RequestMapping("/get_post")
	public Map<String,Object> getPost(@RequestParam("postId") int postId , HttpServletRequest request){
		
		
		Map<String,Object> result=new HashMap<>();
		
		Post post =postBO.getPostById(postId);
		
		result.put("post", post);
		
		HttpSession session=request.getSession();
		User user=(User)session.getAttribute("user");
		
		if(user!=null) {
			result.put("loginCheck",true);
			
			Stack<Integer> followingList=followBO.getFollowerOnlyUserId(user.getId());
			followingList.push(user.getId());
			result.put("followingList",followingList);
			
			result.put("myId", user.getId());
			
		}else {
			result.put("loginCheck",false);
			result.put("followingList",null);
		}
		
		return result;
	}
	
	@PostMapping("/post_create")
	public Map<String,String> createPost(@RequestParam("content") String content
										,@RequestParam("file") MultipartFile file
										,HttpServletRequest request){
		Map<String,String> result=new HashMap<>();
		HttpSession session=request.getSession();
		
		User user= (User) session.getAttribute("user");
		
		Integer userId=null;
		String userLoginId=null;
		
		if(user==null) {
			result.put("result", "로그인 상태가 아닙니다.");
		}else {
			userId=user.getId();
			userLoginId=user.getLoginId();
		}
		
		int row=postBO.createPost(userId,userLoginId,content,file);
		
		if(row==0) {
			result.put("result", "파일 업로드 실패");
		}else {
			result.put("result", "등록 되었습니다.");
		}
		
		
		return result;
		
	}
	
}
