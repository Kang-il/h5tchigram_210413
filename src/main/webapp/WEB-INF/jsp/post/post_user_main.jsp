<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="../include/modal.jsp" />
<jsp:include page="../include/follow_modal.jsp" />
<jsp:include page="../include/comment_modal.jsp"/>

<div class="profile-section">
	<div class="profile-divide-section">

		<div class="profile-box">

			<div class="profile-image-box">

				<div class="profile-image-frame">

					<div class="profile-image-item">
						<c:if test="${feedOwner.profileImagePath eq null}">
							<img src="/static/images/no_profile_image.png"
								class="profile-image">
						</c:if>
						<c:if test="${feedOwner.profileImagePath ne null}">
							<img src="${feedOwner.profileImagePath}" class="profile-image">
						</c:if>
					</div>

				</div>

			</div>

		</div>

		<div class="profile-info-section">

			<div class="profile-info-frame">

				<div class="profile-info-box1">
					<span id="profileUserId">${feedOwner.loginId}</span>
					<c:choose>
						<%-- 내 피드 --%>
						<c:when test="${checkMyFeed eq true}">
							<button type="button" class="profile-edit-btn">프로필 편집</button>
						</c:when>
						<%-- 상대방 피드 --%>
						<c:when test="${checkMyFeed eq false}">

							<c:if test="${checkFollowing eq false}">
								<button type="button" class="profile-following-btn" data-feed-owner-id="${feedOwner.id}">팔로잉</button>
							</c:if>

							<c:if test="${checkFollowing eq true}">
								<button type="button" class="profile-follow-btn" data-feed-owner-id="${feedOwner.id}">팔로우 하기</button>
							</c:if>

						</c:when>
						<%-- 로그인이 안되어있음 --%>
						<c:when test="${checkMyFeed eq null }">
						</c:when>
					</c:choose>
				</div>

				<div class="profile-info-box2">
					<div>
						게시물 <span>${postCount}</span>
					</div>
					<div>
						팔로워 <span class="profile-info-follow profile-follower-info" id="follower">${followerCount}</span>
					</div>
					<div>
						팔로잉 <span class="profile-info-follow profile-following-info" id="following">${followingCount}</span>
					</div>
				</div>

				<div class="profile-info-box3">
					<div>
						<span>${feedOwner.nickname}</span>
					</div>
					<div>${feedOwner.introduce}</div>
				</div>

			</div>

		</div>
	</div>
	

	<hr class="m-0">

	<nav class="profile-contents-nav" data-category="${category}">
		<button type="button" class="all-contents-btn"
			data-feed-owner-id="${feedOwner.id}">게시물</button>
		<button type="button" class="only-contents-photo-btn"
			data-feed-owner-id="${feedOwner.id}">사진</button>
		<button type="button" class="only-contents-video-btn"
			data-feed-owner-id="${feedOwner.id}">동영상</button>
		<c:if test="${user.id eq feedOwner.id}">
			<button type="button" class="pined-contens-btn"
				data-feed-owner-id="${feedOwner.id}">저장됨</button>
		</c:if>
	</nav>

	<div class="profile-contents-box">
		<%--TODO:::forEach 동적으로--%>

		<c:forEach var="post" items="${postThumbnailList}" varStatus="status">
			<c:if test="${status.index % 3 eq 0 }">
				<div class="profile-contents-row">
			</c:if>

			<div class="profile-content" data-post-id="${post.postId}"
				data-content-type="${post.contentType}">
				<div class="profile-contents-unit">
					<img src="${post.imagePath}" class="post-image">
					<div class="content-simple-info">
						<span class="material-icons-outlined icon">favorite</span> 
							<span class="count post-like-list" id="thumbnailLikeCount${post.postId}">${post.likeCount}</span> 
							<span class="material-icons icon">chat_bubble</span> 
							<span class="count comment-list" id="thumbnailCommentCount${post.postId}">${post.commentCount}</span>
					</div>
				</div>
			</div>

			<c:if test="${status.index % 3 eq 2 }">
	</div>
	</c:if>
	</c:forEach>
</div>
</div>

