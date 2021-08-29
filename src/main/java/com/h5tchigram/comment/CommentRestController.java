package com.h5tchigram.comment;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.h5tchigram.comment.bo.CommentBO;
import com.h5tchigram.comment.model.Comment;
import com.h5tchigram.post.bo.PostBO;
import com.h5tchigram.post.model.Post;
import com.h5tchigram.user.model.User;

@RequestMapping("/comment")
@RestController
public class CommentRestController {
	@Autowired
	private CommentBO commentBO;
	
	@Autowired
	private PostBO postBO;
	
	@PostMapping("/create_comment")
	public Map<String,Object> createComment(@RequestParam("postId")int postId
										  , @RequestParam("comment") String comment
										  ,HttpServletRequest request){
		
		Map<String,Object> result=new HashMap<>();
		//코멘트 넣기 
		//코멘트 뿌리기
		HttpSession session= request.getSession();
		User user=(User)session.getAttribute("user");
		
		if(user!=null) {//로그인 되어있는 상태
			
			Post post=postBO.getPostById(postId);
			
			//댓글 남기기
			commentBO.insertComment(user.getId(), postId, post.getUserId(), comment);
			//코멘트 리스트 가져오기
			List<Comment> commentList=commentBO.getCommentListByPostId(postId);
			
			
			result.put("myId", user.getId());
			result.put("postUserId", post.getUserId());
			result.put("commentList", commentList);
			result.put("loginCheck", true);
		}else {//로그인 안되어있는 상태
			
			result.put("loginCheck", true);
		}
		
		
		return result;
	}
	
	@RequestMapping("/delete_comment")
	public Map<String,Object> deleteComment(@RequestParam("commentId")int commentId
											,@RequestParam("postId")int postId
											,HttpServletRequest request){
		
		Map<String,Object> result=new HashMap<>();
		//코멘트 지우기
		//바뀐 코멘트 뿌리기
		HttpSession session= request.getSession();
		User user=(User)session.getAttribute("user");
		
		//1.포스트의 유저아이디와 내 아이디 일치여부 확인(일치하면 지울 수 있는 권한이 있음)
		//2.댓글 유저아이디와 내 아이디 일치여부 확인(일치하면 지울 수 있는 권한이 있음)
		//---둘 중 한개만 일치해도 지울 수 있다.
		if(user!=null) {
			Post post=postBO.getPostById(postId);
			Comment comment=commentBO.getCommentById(commentId);
			if( post.getUserId()==user.getId() || comment.getUserId()==user.getId() ) {
				//일치하는 경우
				commentBO.deleteCommentById(commentId);
			}
			
			//삭제 후 할 일 코멘트 새로 뿌리기
			//postUserId myId를 뿌려야함
			//삭제 후 리스트 얻어오기
			List<Comment> commentList=commentBO.getCommentListByPostId(postId);
			
			result.put("loginCheck", true);
			result.put("myId", user.getId());
			result.put("postUserId", post.getUserId());
			result.put("commentList",commentList);
			
		}else {
			result.put("loginCheck", false);
		}
		
		
		return result;
	}
									
	
}
