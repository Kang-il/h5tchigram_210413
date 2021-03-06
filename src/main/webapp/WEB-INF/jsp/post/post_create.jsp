<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

	<div class="create-post-box">
	
		<div class="create-post-subject">
			<span>새 게시물</span>
		</div>
		
		<div class="create-post-items">
				
			<div class="create-post-photo-box">
			
				<div class="zoon-in-photo-unit d-none">
					<img id="createPostImage" class="d-none">
					<div class="zoom-in-simple-info">
						<span class="zoon-in-alert">크게보기</span>
					</div>
				</div>	
									
				<label for="createFileInput" id="createPostImageFrame">사진을 추가해 주세요</label>
				<input type="file" class="create-file-input" id="createFileInput">
				
			</div>
			
			<div class="create-post-text-box">
			
				<textarea class="create-post-textarea" cols="101" rows="6" placeholder="내용을 입력 해 주세요." id="createContent"></textarea>
				
				<div class="create-post-emoji-picker">
					<button type="button" class="material-icons-outlined" id="createPostAddImageBtn">library_add</button>
					<button type="button" id="postCreateEmojiPicker" class="material-icons-outlined">sentiment_satisfied_alt</button>
				</div>
				
			</div>
					
		</div>
				
		<div class="create-post-btn-box">
			<button type="button" id="createPostSubmitBtn">공유</button>
		</div>
	</div>
