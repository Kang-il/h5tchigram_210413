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
			<div class="modal-menu-item cancel-modal" onclick="cancelModal()">취소</div>
	</div>
</div>

<div class="menu-modal-section-not-owner d-none">
	<div class="menu-modal-box-not-owner">
			<%-- a태그 href는 동적으로 값이 담김 --%>
			<div class="modal-menu-item"><a href="detail" class="go-to-post-link" >게시물로 이동</a></div><hr>
			<div class="modal-menu-item cancel-modal" onclick="cancelModal()">취소</div>
	</div>
</div>


<%-- TODO DELETE API 작성 --%>		
<%-- 댓글 메뉴창 클릭 시 보이는 모달창 --%>
<div class="comment-description-modal d-none">
	<div class="menu-modal-box">
			<div class="modal-menu-item"><a class="comment-delete-button text-danger">삭제</a></div><hr>
			<div class="modal-menu-item cancel-modal" onclick="cancelModal()">취소</div>
	</div>
</div>

<%-- TODO DELETE API 작성 --%>		
<%-- 댓글 메뉴창 클릭 시 보이는 모달창 --%>
<div class="detail-comment-description-modal d-none">
	<div class="menu-modal-box">
			<div class="detail-modal-menu-item"><a class="detail-comment-delete-button text-danger">삭제</a></div><hr>
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

<div class="follow-delete-modal-section d-none">
	<div class="follow-delete-modal-box">
		<div class="delete-user-image-box">
			<img src="/static/images/dummy_profile.jpg" class="delete-user-image">
		</div>
		<div class="follow-delete-info">
			<p class="title">언팔로우 하시겠어요?</p>
			<p class="description">
				<span class="unfollow-userId">h5tchi</span>
				님은 회원님이<br>언팔로우 한 사실을 알 수 없습니다.
			</p>
		</div>
		<hr class="m-0">
		<div class="delete-button-box">
			<p class="delete-btn">삭제</p>
			<hr class="m-0">
			<p class="cancel-btn">취소</p>
		</div>
	</div>
</div>

<div class="follow-modal-section d-none">
	<div class="follow-modal-box">
		<div class="follow-modal-title-box">
			<span class="follow-title" data-feed-owner-id="${feedOwner.id}">팔로우</span>
		</div>
		<hr class="m-0">

		<div class="follow-members-section">

			<div class="follow-member-item">
				<img src="/static/images/dummy_profile.jpg" class="follow-image">
				<a href="#"><span>cooiiing</span></a>
				<div class="follow-action-button-box">
					<button type="button" class="follow-action-del-btn">삭제</button>
					<button type="button" class="follow-action-following-btn">팔로우</button>
				</div>
			</div>

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


