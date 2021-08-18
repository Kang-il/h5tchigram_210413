<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 게시글 메뉴창 클릭 시 보이는 모달창 --%>
<div class="menu-modal-section d-none">
	<div class="menu-modal-box">
			<div class="modal-menu-item"><a href="#" class="modal-menu-item text-danger">삭제</a></div><hr>
			<div class="modal-menu-item"><a href="/post/post_detail_view"" >게시물로 이동</a></div><hr>
			<div class="modal-menu-item"><a href="#" >링크복사</a></div><hr>
			<div class="modal-menu-item"><a href="#" >퍼가기</a></div><hr>
			<div class="modal-menu-item cancel-modal" onclick="cancelModal()">취소</div>
	</div>
</div>

<%-- 댓글 메뉴창 클릭 시 보이는 모달창 --%>
<div class="comment-description-modal d-none">
	<div class="menu-modal-box">
			<div class="modal-menu-item"><a href="#" class="modal-menu-item text-danger">삭제</a></div><hr>
			<div class="modal-menu-item cancel-modal" onclick="cancelModal()">취소</div>
	</div>
</div>

<%-- 댓글 더보기 클릭 시 보이는 모달창 --%>
<div class="comment-modal-section d-none">
	<div class="comment-modal-box">
	
		<div class="comment-modal-picture">
			<img src="/static/images/dummy_image.jpg" width="600px"/>
		</div>
		
		<div class="comment-modal-description">
			<div class="comment-modal-des1">
			
				<a href="#"><img src="/static/images/dummy_profile.jpg" class="user-profile"></a>
				
				<a href="/user/main_view" class="user-id ">h5tchi</a>
				
				<div class="post-menu-bar">
					<button type="button" class="material-icons-outlined post-menu-btn">more_horiz</button>
				</div>
				
			</div>
			
			<div class="comment-modal-des2">
			
				<div class="description-item">
					<a href="#"><img src="/static/images/dummy_profile.jpg" class="user-profile"></a>
					<a href="#" class="comment-id">h5tchi</a>
					<span>집에 가고 싶네여.</span>
				</div>
				
				<%-- TODO ::: forEach  --%>
				<div class="comment-item">
					<div>
						<a href="#"><img src="/static/images/dummy_profile.jpg" class="user-profile"></a>
						<a href="#" class="comment-id">cooiiiing</a> <span>집 이시잖아요.</span>
					</div>
					
					<div>
						<button type="button" class="material-icons-outlined menu-btn">more_horiz</button>
					</div>
					
				</div>
				<%--forEach--%>
				
			</div>
			
			<hr class="m-0">
			
			<div class="comment-modal-des3">
			
				<div class="action-button">
					<button type="button" class="material-icons-outlined">favorite_border</button>
					<button type="button" class="material-icons-outlined d-none">favorite</button>
					<button type="button" class="material-icons-outlined action-text-focus-btn">textsms</button>
					<button type="button" class="material-icons-outlined icon-item"> email </button>
				</div>
					
				<div class="item-like-section">
					<a href="#"><img src="/static/images/dummy_profile.jpg" class="like-profile"/></a>
					<a href="#" class="like-first-id">h5tchi</a>님&nbsp;
					<a href="#" class="like-link">외 288명</a>
					<a>이 좋아합니다.</a>
				</div>
				
				<div class="post-date">
					4주 전
				</div>
				
			</div>
			
			
			<hr class="m-0">
			
			<div class="comment-modal-des4">
			
				<button type="button" id="modal-emoji-picker" class="material-icons-outlined item-emoji-picker">sentiment_satisfied_alt</button>
				
				<input type="text" class="modal-comment-form modal-comment-form" placeholder="댓글달기..."/>
				
				<div class="btn-box">
					<button type="button" class="comment-submit-btn">게시</button>
				</div>
				
			</div>
			
		</div>
		
	</div>
	
</div>

