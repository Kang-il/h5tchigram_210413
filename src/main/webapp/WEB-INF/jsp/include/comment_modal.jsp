<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  

<%-- 댓글 더보기 클릭 시 보이는 모달창 --------------------------------------------------%>
<div class="comment-modal-section d-none">
	<div class="comment-modal-box">
	
		<div class="comment-modal-picture">
			<%--피드 사진 클릭 시 사진 동적으로 바뀜 --%>
			<img class="comment-modal-content-picture" width="600px" height="600px;"/>
		</div>
		
		<div class="comment-modal-description">
			<div class="comment-modal-des1">
				<%--글쓴이 아이디 --%>
				<a href="/user/feed/${feedOwner.loginId}" class="post-owner-profile">
					
					<%--이미지가 있을경우 --%>
					<c:if test="${feedOwner.profileImagePath ne null }">
						<img src="" class="user-profile">
					</c:if>
					
					<%-- 이미지가 없을경우 --%>
					<c:if test="${feedOwner.profileImagePath eq null }">
						<img src="/static/images/no_profile_image.png" class="none-user-profile user-profile">
					</c:if>
					
				</a>
				
				<a href="/user/feed/${feedOwner.loginId}" class="user-id ">${feedOwner.loginId}</a>
				
				<div class="post-menu-bar">
					<button type="button" class="material-icons-outlined post-menu-btn" >more_horiz</button>
				</div>
				
			</div>
			
			<div class="comment-modal-des2">
			
				<div class="description-item">
				
					<a class="content-user-link" href="/user/feed/?userId=${feedOwner.loginId}">
						<%--이미지가 있을경우 --%>
						<c:if test="${feedOwner.profileImagePath ne null }">
							<img src="" class="user-profile">
						</c:if>
						
						<%-- 이미지가 없을경우 --%>
						<c:if test="${feedOwner.profileImagePath eq null }">
							<img src="/static/images/no_profile_image.png" class="none-user-profile user-profile">
						</c:if>
					</a>
					
					<a href="/user/feed/${feedOwner.loginId}" class="owner-id">${feedOwner.loginId}</a>
					<div class="comment-modal-post-content">집에 가고 싶네여.</div>
				</div>
				
				
				<%-- TODO ::: forEach  --%>
				
					
					<div class="comments-box" id="commentsBox">
						
					</div>
					
				
				<%--forEach--%>
				
			</div>
			
			<hr class="m-0">
			
			<div class="comment-modal-des3">
			
				<div class="action-button">
					<div>
						<button type="button" class="material-icons-outlined d-none modal-like-before-btn" id="modalLikeBeforeBtn">favorite_border</button>
						<button type="button" class="material-icons-outlined d-none modal-like-after-btn" id="modalLikeAfterBtn">favorite</button>
						<button type="button" class="material-icons-outlined action-text-focus-btn">textsms</button>
					</div>
					<div>
						<button type="button" class="material-icons-outlined modal-pin-before-btn" >bookmark_border</button>
						<button class="material-icons-outlined d-none modal-pin-after-btn">bookmark</button>
					</div>
				</div>

				<div class="item-like-section">
					<a href="#"><img src="/static/images/dummy_profile.jpg" class="like-profile"/></a>
					<a href="#" class="like-first-id">아이디</a>님&nbsp;
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
				
				<div class="comment-input-box">
					<input type="text" class="modal-comment-form" name="commentForm" placeholder="댓글을 입력해 주세요..">
				</div>
				
				<div class="btn-box">
					<button type="button" class="comment-submit-btn">게시</button>
				</div>
				
			</div>
			
		</div>
		
	</div>
	
</div>