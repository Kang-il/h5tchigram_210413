<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class="timeline-section">

		<%--TODO::::::
		1.forEach 작성 
		2.DB 연동후 하드코딩 된 값들 변경
		--%>
		<div class="post-item-box bg-white">
		
			<div class="post-item-profile-section">
				<a href="#"><img src="/static/images/dummy_profile.jpg" width="50px" class="user-info-profile"></a>
				<a href="/user/main_view" class="post-user-id ">h5tchi</a>
				<div class="post-menu-bar">
					<button type="button" class="material-icons-outlined post-menu-btn">more_horiz</button>
				</div>
			</div>
			
			<div class="post-item-picture-section">
				<img src="/static/images/dummy_image.jpg" width="569px" height="569px"/>
			</div>
			
			<div class="post-item-action-button">
				<button type="button" class="material-icons-outlined">favorite_border</button>
				<button type="button" class="material-icons-outlined d-none">favorite</button>
				<button type="button" class="material-icons-outlined">textsms</button>
				<button type="button" class="material-icons-outlined icon-item"> email </button>
			</div>
			
			<div class="post-item-like-section">
				<a href="#"><img src="/static/images/dummy_profile.jpg" class="like-profile"/></a>
				<a href="#" class="like-first-id">h5tchi</a>
				님&nbsp;
				<a href="#" class="like-link">외 288명</a>
				<a>이 좋아합니다.</a>
			</div>
			
			<div class="post-content-section">
				<a href="#">h5tchi</a><span class="post-content-item">집에 가고싶네여.</span>
			</div>
			
			<div class="post-comment-view-section">
				<button type="button" id="showDetail">댓글 4개 모두 보기</button>
			</div>
			
			<div class="comment-unit">
				<a href="#" class="comment-id">h5tchi</a>
				<span>집 이시잖아여.</span>
			</div>
			
			<hr class="mb-0">
			
			<div class="post-comment-bar">
				<%-- emoji btn --%>
				<button type="button" class="material-icons-outlined timeline-emoji-picker" id="post-emoji-picker">sentiment_satisfied_alt</button>
				
				<input type="text" class="comment-form" placeholder="댓글달기..." id="comment-form"/>
				<div class="btn-box">
					<button type="button" class="comment-submit-btn">게시</button>
				</div>
			</div>
			
		</div>
		<%--forEach 문 끝 --%>
		
	</div>