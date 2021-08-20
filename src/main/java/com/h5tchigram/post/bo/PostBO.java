package com.h5tchigram.post.bo;

import java.io.IOException;	


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.h5tchigram.common.FileManagerService;
import com.h5tchigram.post.dao.PostDAO;
import com.h5tchigram.post.model.Post;




@Service
public class PostBO {
	
	Logger logger=LoggerFactory.getLogger(Post.class);
	
	@Autowired
	private PostDAO postDAO;
	@Autowired
	private FileManagerService fileManagerService;
	
	public int createPost(int userId, String userLoginId, String content, MultipartFile file) {
		
		//사진 타입만 받도록 해준다.
		String contentType="photo";
		String imageUrl=null;
		
		//filed업로드 후  image URL을 반환받아 DB에 넣을 인자값으로 구성.
		
		try {//컴퓨터에(서버에) 파일 업로드 후 DB에 저장해 나중에 웹에서 접근할 수 있는 Image URL을 얻어낸다
			imageUrl = fileManagerService.saveFile(userLoginId, file);
		}catch(IOException e) {
			//대략적인 이유가 나오는 메시지
			logger.debug(e.getMessage());
		}
		
		
		
		return postDAO.insertPost(userId,contentType,content,imageUrl);
	}
	
	
}
