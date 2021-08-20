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

		<script>
		//이미지 클릭시 이미지 크게보기
		//사진 올리면 미리보기 가능하도록 하기
		$("#createFileInput").on("change",function(e){

			let files=e.target.files;
			let filesArr=Array.prototype.slice.call(files);
		
			filesArr.forEach(function(f){
				if(!f.type.match("image.*")){
					alert("확장자는 이미지 확장자만 가능합니다.");
					$("#createFileInput").val('');
					return;
				}
					
				sel_file=f;
					
				let reader=new FileReader();
				reader.onload=function(e){
					$("#createPostImage").attr("src",e.target.result);
					$("#createPostImage").removeClass("d-none");
					$("#createPostImageFrame").addClass("d-none");
					$(".zoon-in-photo-unit").removeClass("d-none");
				}
					
				reader.readAsDataURL(f);
					
			});
		});
		
		$('#createPostSubmitBtn').on('click',function(){
			let content=$('#createContent').val();
			if(content==''){
				alert('내용을 입력 해 주세요');
				return;
			}
			
			let file=$('#createFileInput').val();
			if(file==''){
				alert('사진이 없습니다.');
				return;
			}
			
			let formData=new FormData();
			formData.append('content',content);
			formData.append('file',$('#createFileInput')[0].files[0]);
			
			$.ajax({
				type:'POST'
				,url:'/post/post_create'
				,data:formData
				,processData:false
				,contentType:false
				,enctype:'multipart/form-data'
				,success:function(data){
					alert(data.result);
					location.href='/timeline/timeline_view';
				}
				,error:function(e){
					alert('메모저장 실패 관리자에게 문의하세요');
				}
			});
			
			
		});
		
		</script>