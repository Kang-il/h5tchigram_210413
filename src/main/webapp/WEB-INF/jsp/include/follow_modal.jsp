<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


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


<div class="follow-delete-modal-section d-none">
	<div class="follow-delete-modal-box">
		<div class="delete-user-image-box">
			<img src="/static/images/dummy_profile.jpg" class="delete-user-image">
		</div>
		<div class="follow-delete-info">
			<p class="title">언팔로우 하시겠어요?</p>
			<p class="description">
				<span class="unfollow-userId">h5tchi</span>님은 회원님이<br>언팔로우 한
				사실을 알 수 없습니다.
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

