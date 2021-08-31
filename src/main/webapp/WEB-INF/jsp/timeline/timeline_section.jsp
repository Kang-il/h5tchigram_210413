<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  

<div class="timeline-section">

		<%--TODO::::::
		1.forEach 작성 
		2.DB 연동후 하드코딩 된 값들 변경
		--%>
		<c:forEach var="post" items="${postList}">
			<div class="post-item-box bg-white">
			
				<div class="post-item-profile-section">
					
					<a href="user/feed/${post.userLoginId}">
					
						<c:if test="${post.profileImagePath eq null}">
							<img src="/static/images/no_profile_image.png" width="50px" class="user-info-profile">
						</c:if>
						
						<c:if test="${post.profileImagePath ne null}">
							<img src="${post.profileImagePath}" width="50px" class="user-info-profile">
						</c:if>
					</a>
					<a href="/user/feed/${post.userLoginId}" class="post-user-id ">${post.userLoginId}</a>
					<%--TODO:: 아이디에 따라 삭제버튼의 노출 여부 --%>
					<div class="post-menu-bar">
					
						<c:if test="${user.id eq post.userId}">
						<%-- 삭제버튼이 있는 모달 노출 --%>
							<button type="button" class="material-icons-outlined post-menu-btn" data-post-id="${post.id}">more_horiz</button>
						</c:if>
						
						<c:if test="${user.id ne post.userId}">
						<%-- 삭제버튼이 없는 모달 노출  버튼 수정하기--%>
							<button type="button" class="material-icons-outlined post-menu-btn not-my-post" data-post-id="${post.id}">more_horiz</button>
						</c:if>
						
					</div>
				</div>
			
				
				<div class="post-item-picture-section">
					<img src="${post.imagePath}" width="569px" height="569px"/>
				</div>
				
				<div class="post-item-action-button">
				
					<c:set var="contains" value="false"/>
					
					<c:forEach var="like" items="${post.likeList}">
						<c:forEach var="myLike" items="${likeList}">
							<c:if test="${like.userId eq myLike.userId}">
								<c:set var="contains" value="true"/>
							</c:if>
						</c:forEach>
					</c:forEach>
					
					<div>
						<c:if test="${contains eq false}">
							<button type="button" class="material-icons-outlined timeline-like-before-btn" data-post-id="${post.id}" data-post-user-id="${post.userId}">favorite_border</button>
						</c:if>
						
						<c:if test="${contains eq true}">
							<button type="button" class="material-icons-outlined timeline-like-after-btn" data-post-id="${post.id}" data-post-user-id="${post.userId}">favorite</button>
						</c:if>
						
						<button type="button" class="material-icons-outlined timeline-text-focus-btn" data-post-id="${post.id}">textsms</button>
					</div>
					
					<c:set var="contains" value="false"/>
					<c:forEach var="pin" items="${pinList}">
						<c:if test="${post.id  eq pin.postId}">
							<c:set var="contains" value="true"/>
						</c:if>
					</c:forEach> 
					<div>
						<c:if test="${contains eq true}">
							<button class="material-icons-outlined timeline-pin-after-btn" data-post-id="${post.id}">bookmark</button>
						</c:if>
						<c:if test="${contains eq false }">						
							<button type="button" class="material-icons-outlined timeline-pin-before-btn" data-post-id="${post.id}">bookmark_border</button>
						</c:if>
					</div>
				</div>
				
				
				<div class="post-item-like-section">
				
					
					
					<c:set var="likeListSize" value="${fn:length(post.likeList)}"/>
					
					<c:if test="${likeListSize > 0}" >
					
					
					<c:set var="profileImagePath" value="${post.likeList[likeListSize-1].profileImagePath}"/>
					<c:set var="userLoginId" value="${post.likeList[likeListSize-1].userLoginId}"/>
					
						<a href="/user/feed/${userLoginId}">
						
							<c:if test="${profileImagePath eq null}">
								<img src="/static/images/no_profile_image.png" class="like-profile"/>
							</c:if>
							
							<c:if test="${profileImagePath ne null}">
								<img src="${profileImagePath}" class="like-profile"/>
							</c:if>
						</a>
						<a href="/user/feed/${userLoginId}" class="like-first-id">${userLoginId}</a>
						님
						
					</c:if>
					
					<c:if test="${likeListSize > 1}">
						<a href="#" class="like-link" data-post-id="${post.id}">&nbsp;외 ${likeListSize-1}명</a>
					</c:if>
					
					<c:if test="${likeListSize > 0}" >
						<a>이 좋아합니다.</a>
					</c:if>
				</div>
				
				<div class="post-content-section">
					<a href="/user/feed/${post.userLoginId}">${post.userLoginId}</a><span class="post-content-item">${post.content}</span>
				</div>
				
					<c:set var="commentSize" value="${fn:length(post.commentList)}"/>
					
					<c:if test="${commentSize>1}">
					
						<div class="post-comment-view-section">
							<button type="button" class="show-timeline-post-detail" id="showTimelinePostDetail${post.id}" data-post-user-login-id="${post.userLoginId}" data-user-id="${user.id}" data-post-id="${post.id}">댓글 ${fn:length(post.commentList)}개 모두 보기</button>
						</div>
						
					</c:if>
					
					<c:if test="${commentSize>0}">	
						<div class="comment-unit">
							<a href="/user/feed/${post.commentList[commentSize-1].userLoginId}" class="comment-id">${post.commentList[commentSize-1].userLoginId}</a>
							<span>${post.commentList[commentSize-1].comment}</span>
							
						</div>
					</c:if>	
				<hr class="mb-0">
				
				<div class="post-comment-bar">
					<%-- emoji btn --%>
					<button type="button" class="material-icons-outlined timeline-emoji-picker" id="post-emoji-picker${post.id}" data-post-id="${post.id}">sentiment_satisfied_alt</button>
					
					<input type="text" class="comment-form" id="timeLineCommentInput${post.id}" placeholder="댓글달기..."/>
					
					<div class="btn-box">
						<button type="button" class="timeline-comment-submit-btn" data-post-id="${post.id}">게시</button>
					</div>
				</div>
			</div>
		</c:forEach>
		<%--forEach 문 끝 --%>
	</div>
	
	