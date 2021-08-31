<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  

<div class="detail-content-box">
	
		<div class="detail-content-picture">
			<img src="${post.imagePath}" width="539px" height="539px"/>
		</div>
		
		<div class="detail-content-description">
			<div class="detail-content-des1">
			
				<c:if test="${post.profileImagePath eq null}">
					<a href="/user/feed/${post.userLoginId}"><img src="/static/images/no_profile_image.png" class="user-profile"></a>
				</c:if>
				
				<c:if test="${post.profileImagePath ne null}">
					<a href="/user/feed/${post.userLoginId}"><img src="${post.profileImagePath}" class="user-profile"></a>
				</c:if>
				
				<a href="/user/feed/${post.userLoginId}" class="user-id ">${post.userLoginId}</a>
				
				<div class="post-menu-bar">
					<c:if test="${user.id eq post.userId }">
						<button type="button" class="material-icons-outlined post-menu-btn" data-post-id="${post.id}">more_horiz</button>
					</c:if>
					<c:if test="${user.id ne post.userId }">
						<button type="button" class="material-icons-outlined post-menu-btn not-my-post" data-post-id="${post.id}">more_horiz</button>
					</c:if>
				</div>
				
			</div>
			
			<div class="detail-content-des2">
			
				<div class="description-item">
				
					<a href="/user/feed/${post.userLoginId}">
						<c:if test="${post.profileImagePath eq null}">
							<img src="/static/images/no_profile_image.png" class="user-profile">
						</c:if>
						
						<c:if test="${post.profileImagePath ne null}">
							<img src="${post.profileImagePath}" class="user-profile">
						</c:if>
					</a>
					
					<a href="/user/feed/${post.userLoginId}" class="comment-id">${post.userLoginId}</a>
					<span>${post.content}</span>
				</div>
				
				<%-- TODO ::: forEach  --%>
				<c:forEach var="comment" items="${post.commentList}">
				
					<div class="comment-item">
						<div>
							<a href="/user/feed/${comment.userLoginId}">
							
								<c:if test="${comment.profileImagePath eq null}">
									<img src="/static/images/no_profile_image.png" class="user-profile">
								</c:if>
								
								<c:if test="${comment.profileImagePath ne null}">
									<img src="${comment.profileImagePath}" class="user-profile">
								</c:if>
						
							</a>
							<a href="/user/feed/${comment.userLoginId}" class="comment-id">${comment.userLoginId}</a> 
							<span>${comment.comment}</span>
						</div>
						<c:if test="${comment.userId eq user.id || post.userId eq user.id}">
							<div>
								<button type="button" class="material-icons-outlined detail-comment-menu-btn" data-comment-id="${comment.id}" data-post-id="${post.id}">more_horiz</button>
							</div>
						</c:if>
					</div>
				
				</c:forEach>
				<%--forEach--%>
				
			</div>
			
			<hr class="m-0">
			
			<div class="detail-content-des3">
			
				<div class="action-button">
					<div>
						<c:if test="${likeCheck eq null}">
							<button type="button" class="material-icons-outlined detail-like-before-btn" data-post-id="${post.id}" data-post-user-id="${post.userId}">favorite_border</button>
						</c:if>
						
						<c:if test="${likeCheck ne null}">
							<button type="button" class="material-icons-outlined detail-like-after-btn" data-post-id="${post.id}" data-post-user-id="${post.userId}">favorite</button>
						</c:if>
						<button type="button" class="material-icons-outlined detail-text-focus-btn">textsms</button>
					</div>
					<div>
						<c:if test="${pinCheck eq null }">
							<button type="button" class="material-icons-outlined detail-pin-before-btn" data-post-id="${post.id}">bookmark_border</button>
						</c:if>
						
						<c:if test="${pinCheck ne null }">
							<button class="material-icons-outlined detail-pin-after-btn" data-post-id="${post.id}">bookmark</button>
						</c:if>
					</div>
				</div>
				<div>
					
				</div>
					
				<div class="item-like-section">
					<c:if test="${post.likeList ne null }">
						<c:set var="likeListSize" value="${fn:length(post.likeList)}"/>
						
						<c:if test="${likeListSize>0}">
							<c:set var="userLoginId" value="${post.likeList[likeListSize-1].userLoginId}"/>
							<c:set var="profileImagePath" value="${post.likeList[likeListSize-1].profileImagePath}"/>
							<a href="/user/feed/${userLoginId}">
								<c:if test="${profileImagePath eq null}">
									<img src="/static/images/no_profile_image.png" class="like-profile"/>								
								</c:if>
								
								<c:if test="${profileImagePath ne null}">
									<img src="${profileImagePath}" class="like-profile"/>								
								</c:if>
							</a>
							<a href="user/feed/${userLoginId}" class="like-first-id">${userLoginId}</a>님
						</c:if>
						
						<c:if test="${likeListSize>1}">
							<span>&nbsp;외</span>
							<a href="#" class="like-link" data-post-id="${post.id}">${likeListSize-1}명</a>
						</c:if>
						<c:if test="${likeListSize>0}">
							<span>이 좋아합니다.</span>
						</c:if>
					</c:if>
				</div>

				
			</div>
			
			<hr class="m-0">
			
			<div class="detail-content-des4">
			
				<button type="button" id="detail-emoji-picker" class="material-icons-outlined detail-emoji-picker">sentiment_satisfied_alt</button>
				
				<input type="text" class="detail-comment-form" placeholder="댓글달기..."/>
				
				<div class="btn-box">
					<button type="button" class="detail-comment-submit-btn" data-post-id="${post.id}">게시</button>
				</div>
				
			</div>
		</div>
	</div>
