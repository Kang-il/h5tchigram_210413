<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<%-- 게시글 메뉴창 클릭 시 보이는 모달창 --%>
<div class="menu-modal-section d-none">
	<div class="menu-modal-box">
			<%-- a태그 href는 동적으로 값이 담김 --%>
			<div class="modal-menu-item"><a href="delete" class="delete-link text-danger">삭제</a></div><hr>
			<div class="modal-menu-item"><a href="detail" class="go-to-post-link" >게시물로 이동</a></div><hr>
			<div class="modal-menu-item"><a href="#" >링크복사</a></div><hr>
			<div class="modal-menu-item"><a href="#" >퍼가기</a></div><hr>
			<div class="modal-menu-item cancel-modal" onclick="cancelModal()">취소</div>
	</div>
</div>

<%-- TODO DELETE API 작성 --%>		
<%-- 댓글 메뉴창 클릭 시 보이는 모달창 --%>
<div class="comment-description-modal d-none">
	<div class="menu-modal-box">
			<div class="modal-menu-item"><a href="delete" class="comment-delete-button text-danger">삭제</a></div><hr>
			<div class="modal-menu-item cancel-modal" onclick="cancelModal()">취소</div>
	</div>
</div>

<div class="like-modal-section d-none">
	<div class="like-modal-box">
			<div class="like-modal-subject"><span>좋아요 목록</span></div>
			
			<div class="like-unit-box">
			<%--동적으로 좋아요 목록이 담기는 공간 --%>
			</div>
	</div>
</div>


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
				<a href="/user/main_view?userId=${feedOwner.id}" class="post-owner-profile">
					
					<%--이미지가 있을경우 --%>
					<c:if test="${feedOwner.profileImagePath ne null }">
						<img src="" class="user-profile">
					</c:if>
					
					<%-- 이미지가 없을경우 --%>
					<c:if test="${feedOwner.profileImagePath eq null }">
						<img src="/static/images/no_profile_image.png" class="none-user-profile user-profile">
					</c:if>
					
				</a>
				
				<a href="/user/main_view?userId=${feedOwner.id}" class="user-id ">${feedOwner.loginId}</a>
				
				<div class="post-menu-bar">
					<button type="button" class="material-icons-outlined post-menu-btn" >more_horiz</button>
				</div>
				
			</div>
			
			<div class="comment-modal-des2">
			
				<div class="description-item">
				
					<a href="user/main_view?userId=${feedOwner.id}">
						<%--이미지가 있을경우 --%>
						<c:if test="${feedOwner.profileImagePath ne null }">
							<img src="" class="user-profile">
						</c:if>
						
						<%-- 이미지가 없을경우 --%>
						<c:if test="${feedOwner.profileImagePath eq null }">
							<img src="/static/images/no_profile_image.png" class="none-user-profile user-profile">
						</c:if>
					</a>
					
					<a href="/user/main_view?userId=${feedOwner.id}" class="comment-id">${feedOwner.loginId}</a>
					<span class="comment-modal-post-content">집에 가고 싶네여.</span>
				</div>
				
				<%-- TODO ::: forEach  --%>
				
					
					<div class="comments-box" id="commentsBox">
						
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
				
				<input type="text" class="modal-comment-form modal-comment-form" placeholder="댓글달기..."/>
				
				<div class="btn-box">
					<button type="button" class="comment-submit-btn">게시</button>
				</div>
				
			</div>
			
		</div>
		
	</div>
	
</div>

<%----------------------------------------------------%>


<div class="follow-modal-section d-none">
	<div class="follow-modal-box">
		<div class="follow-modal-title-box">
			<span>팔로우</span>
		</div>
		<hr class="m-0">
		<div class="follow-members-section">
			<div class="follow-member-item">
				<img src="/static/images/dummy_profile.jpg" class="follow-image">
				<a href="#"><span>cooiiing</span></a>
				<div class="follow-action-button-box">
					<button type="button" class="follow-action-del-btn">삭제</button>
					<button type="button" class="follow-action-following-btn d-none">팔로우</button>
				</div>
			</div>
		</div>
	</div>
</div>


<div class="follow-delete-modal-section d-none">
	<div class="follow-delete-modal-box">
		<div class="delete-user-image-box">
			<img src="/static/images/dummy_profile.jpg" class="delete-user-image">
		</div>
		<div class="follow-delete-info">
			<p class="title">팔로워를 삭제하시겠어요?</p>
			<p class="description">h5tchi님은 회원님이 팔로워 리스트에서<br>삭제된 사실을 알 수 없습니다.</p>
		</div>
		<hr class="m-0">
		<div class="delete-button-box">
			<p class="delete-btn">삭제</p>
			<hr class="m-0">
			<p class="cancel-btn">취소</p>
		</div>
	</div>
</div>

<%--글 등록 사진 클릭 시 크게 보여주는 모달창 --%>
<div class="create-post-item-modal-section d-none">
	<div class="create-post-item-modal-box">
		<div class="create-post-zoom-in">
			<span>크게보기</span>
		</div>
		<div class="create-post-zoom-photo">
			<img id="PostingZoomInPhoto">
		</div>
	</div>
</div>



