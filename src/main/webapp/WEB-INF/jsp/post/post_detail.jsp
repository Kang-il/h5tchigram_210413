<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="detail-content-box">
		<div class="detail-content-picture">
			<img src="/static/images/dummy_image.jpg" width="539px"/>
		</div>
		
		<div class="detail-content-description">
			<div class="detail-content-des1">
			
				<a href="#"><img src="/static/images/dummy_profile.jpg" class="user-profile"></a>
				
				<a href="/user/feed/h5tchi" class="user-id ">h5tchi</a>
				
				<div class="post-menu-bar">
					<button type="button" class="material-icons-outlined post-menu-btn">more_horiz</button>
				</div>
				
			</div>
			
			<div class="detail-content-des2">
			
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
			
			<div class="detail-content-des3">
			
				<div class="action-button">
					<button type="button" class="material-icons-outlined">favorite_border</button>
					<button type="button" class="material-icons-outlined d-none">favorite</button>
					<button type="button" class="material-icons-outlined detail-section-focus-btn">textsms</button>
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
			
			<div class="detail-content-des4">
			
				<button type="button" id="detail-emoji-picker" class="material-icons-outlined detail-emoji-picker">sentiment_satisfied_alt</button>
				
				<input type="text" class="detail-comment-form" placeholder="댓글달기..."/>
				
				<div class="btn-box">
					<button type="button" class="comment-submit-btn">게시</button>
				</div>
				
			</div>
		</div>
	</div>

