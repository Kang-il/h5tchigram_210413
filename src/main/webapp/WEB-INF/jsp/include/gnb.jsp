<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
     
 <div class="alert-follow-delete-section d-none">
	<div class="alert-follow-delete-box">
		<div class="alert-delete-user-image-box">
			<img src="/static/images/dummy_profile.jpg" class="alert-delete-user-image">
		</div>
		<div class="alert-follow-delete-info">
			<p class="title">언팔로우 하시겠어요?</p>
			<p class="description">
				<span class="unfollow-userId">h5tchi</span>
				님은 회원님이<br>언팔로우 한 사실을 알 수 없습니다.
			</p>
		</div>
		<hr class="m-0">
		<div class="alert-delete-button-box">
			<p class="alert-delete-btn">삭제</p>
			<hr class="m-0">
			<p class="alert-cancel-btn">취소</p>
		</div>
	</div>
</div>    
     
<div class="modal-window"></div>
<header>
	<div class="nav-box">
	
		<div class="header-logo-box">
			<a href="/timeline/timeline_view"><img src="/static/images/logo.png" width="150px"/></a>
		</div>
		<%-- 세션에 user값이 null 이 아니라면 로그인 되어있지 않은 것 --%>
		<c:if test="${user ne null}">
			<div class="header-nav-box mt-2">
					<button class="menu-item"><span class="material-icons icon-item"> home </span></button> 
					<button class="menu-item"><span class="material-icons-outlined icon-item"> email </span></button> 
					<button class="menu-item"><span class="material-icons-outlined icon-item"> explore </span></button>
					
					<div class="alert-item-box">
						<button class="menu-item alert-item"><span class="material-icons-outlined icon-item"> favorite_border </span></button>
						<div class="nav-alert-modal d-none">
							<%-- TODO:::반복문 걸기 --%>
							<c:forEach var="alert" items="${alertList}">
								<div class="nav-alert-item">
									<c:if test="${alert.sendUserProfileImagePath eq null}">
										<a href="/user/feed/${alert.sendUserLoginId}"><img src="/static/images/no_profile_image.png" class="nav-alert-profile" id="alertUserProfile${alert.sendUserId}"></a>
									</c:if>
									<c:if test="${alert.sendUserProfileImagePath ne null }">
										<a href="/user/feed/${alert.sendUserLoginId}"><img src="${alert.sendUserProfileImagePath}" class="nav-alert-profile" id="alertUserProfile${alert.sendUserId}"></a>
									</c:if>
									
									<c:choose>
										<c:when test="${alert.alertType eq 'like'}">
											<div class="nav-alert-link-box">
												<a href="/user/feed/${alert.sendUserLoginId}" class="nav-alert-id">${alert.sendUserLoginId}</a>
												<a href="/user/feed/${alert.sendUserLoginId}" class="nav-alert-description">님이 회원님의 사진을 좋아합니다.</a>
											</div>
											<%--게시물 상세보기 페이지로 이동 --%>
											<a href="#"><img src="${alert.postImagePath}" class="nav-alert-thumbnail"></a>
										</c:when>
										
										<c:when test="${alert.alertType eq 'comment'}">
											<div class="nav-alert-link-box">
												<a href="/user/feed/${alert.sendUserLoginId}" class="nav-alert-id">${alert.sendUserLoginId}</a>
												<a href="/user/feed/${alert.sendUserLoginId}" class="nav-alert-description">님이 댓글을 남겼습니다. : ${alert.comment}</a>
											</div>
											<%--게시물 상세보기 페이지로 이동 --%>
											<a href="#"><img src="${alert.postImagePath }" class="nav-alert-thumbnail"></a>
										</c:when>
										
										<c:when test="${alert.alertType eq 'follow'}">
											<div class="nav-alert-link-box">
												<a href="/user/feed/${alert.sendUserLoginId}" class="nav-alert-id">${alert.sendUserLoginId}</a>
												<a href="/user/feed/${alert.sendUserLoginId}" class="nav-alert-description">님이 회원님을 팔로우하기 시작했습니다.</a>
											</div>
											<%--게시물 상세보기 페이지로 이동 --%>
											<c:if test="${alert.checkFollowing eq true}">
												<div class="alert-modal-follow-btn-box" id="alertModalFollowBtnBox${alert.sendUserId}">
													<button class="alert-modal-unfollow-btn" data-send-user-id="${alert.sendUserId}" 
														data-send-user-profile-image="${alert.sendUserProfileImagePath}" data-send-user-login-id="${alert.sendUserLoginId}">팔로잉</button>
												</div>
											</c:if>
											
											<c:if test="${alert.checkFollowing eq false}">
												<div class="alert-modal-follow-btn-box" id="alertModalFollowBtnBox${alert.sendUserId}">	
													<button class="alert-modal-follow-btn" data-send-user-id="${alert.sendUserId}" 
														data-send-user-profile-image="${alert.sendUserProfileImagePath}" data-send-user-login-id="${alert.sendUserLoginId}">팔로우</button>
												</div>
											</c:if>
												
											
										</c:when>
										
									</c:choose>
								</div>
							</c:forEach>
							<%----- --%>
						</div>
					</div>
					
					<script>
						$(document).ready(function(){
							
							$('.alert-modal-follow-btn-box').on('click','.alert-modal-unfollow-btn',function(){
								let sendUserId=$(this).data('send-user-id');
								let sendUserProfileImagePath=$(this).data('send-user-profile-image');
								let sendUserLoginId=$(this).data('send-user-login-id');

								
								$('.alert-follow-delete-section').removeClass('d-none');
								$('body').addClass('no-scrollbar');
								
								let profileImagePath = sendUserProfileImagePath == '' ? '/static/images/no_profile_image.png' : sendUserProfileImagePath;
								
								$('.alert-delete-user-image').attr('src', profileImagePath);
								$('.unfollow-userId').text(sendUserLoginId);
								
								
								$('.alert-delete-btn').data('send-user-id',sendUserId);
								$('.alert-delete-btn').data('send-user-profile-image',sendUserProfileImagePath);
								$('.alert-delete-btn').data('send-user-login-id',sendUserLoginId);

								
							});
							
							$('.alert-delete-btn').on('click',function(){
								
								let sendUserId = $(this).data('send-user-id');
								let sendUserProfileImagePath = $(this).data('send-user-profile-image');
								let sendUserLoginId = $(this).data('send-user-login-id');

								$.ajax({
									type:'POST'
									,data:{'followId':sendUserId}
									,url:'/follow/do_unfollow'
									,success:function(data){
										if(data.loginCheck===true){
											$('#alertModalFollowBtnBox'+sendUserId).empty();
											
											let html ='<button class="alert-modal-follow-btn" data-send-user-id="'+sendUserId
														+'" data-send-user-profile-image="'+sendUserProfileImagePath
														+'" data-send-user-login-id="'+sendUserLoginId+'">팔로잉</button>';
														
											$('#alertModalFollowBtnBox'+sendUserId).append(html);
										}
									}
									,error: function(e){
										alert(e);
									}
								});
								
								$('.alert-follow-delete-section').addClass('d-none');
								$('body').removeClass('no-scrollbar');
								
							});
							
							$('.alert-modal-follow-btn-box').on('click','.alert-modal-follow-btn',function(){
								let sendUserId = $(this).data('send-user-id');
								let sendUserProfileImagePath = $(this).data('send-user-profile-image');
								let sendUserLoginId = $(this).data('send-user-login-id');
								
								$.ajax({
									type:'POST'
									,data:{'followId':sendUserId}
									,url:'/follow/do_follow'
									,success:function(data){
											if(data.loginCheck===true){
												$('#alertModalFollowBtnBox'+sendUserId).empty();
												
												let html ='<button class="alert-modal-unfollow-btn"data-send-user-id="'+sendUserId
															+'" data-send-user-profile-image="'+sendUserProfileImagePath
															+'" data-send-user-login-id="'+sendUserLoginId+'">팔로잉</button>';
												
												$('#alertModalFollowBtnBox'+sendUserId).append(html);
											}
									}
									,error: function(e){
											alert(e);
									}
								});
							});
							
							$('.alert-cancel-btn').on('click',function(){
								$('.alert-follow-delete-section').addClass('d-none');
								$('body').removeClass('no-scrollbar');
							});
							
							$('.alert-follow-delete-section').on('click',function(e){
								if(!$('.alert-follow-delete-box').has(e.target).length){
									$('.alert-follow-delete-section').addClass('d-none');
									$('body').removeClass('no-scrollbar');
								}
							});
							
						});
					</script>
					
					<div class="profile-item-box pb-1">
						<button type="button" class="profile-btn">
							<c:if test="${user.profileImagePath eq null}">
								<img src="/static/images/no_profile_image.png" width="28px" class="profile-item "/>
							</c:if>
							<c:if test="${user.profileImagePath ne null}">
								<img src="${user.profileImagePath}" width="28px" class="profile-item "/>
							</c:if>
						</button>
		
						<div class="nav-profile-modal d-none">
						
							<div class="modal-nav-item">
								<span class="material-icons-outlined modal-icon">account_circle</span>
								<a href="/user/feed/${user.loginId}" id="profileLink">프로필</a>
							</div>
							
							<div class="modal-nav-item">
								<span class="material-icons-outlined">turned_in_not</span><a href="#">저장됨</a>
							</div>
							
							<div class="modal-nav-item">
								<span class="material-icons-outlined">settings</span><a href="#">설정</a>
							</div>
							
							<div class="modal-nav-item">
								<span class="material-icons-outlined">app_registration</span><a href="/post/create_post_view">글 등록</a>
							</div>
							
							<hr class="mb-2 mt-2">
							
							<div class="modal-nav-logout">
								<a href="/user/sign_out">로그아웃</a>
							</div>
							
						</div>
						
					</div>
			</div>
		</c:if>
		<%-- 세션에 user값이 null 이라면 로그인 되어있지 않은 것 --%>
		<c:if test="${user eq null}">
			<div class="header-nav-box mt-2">
				<button class="nav-sign-in-btn" onclick="location.href='/user/sign_in_view'">로그인</button>
				<button class="nav-sign-up-btn" onclick="location.href='/user/sign_up_view'">회원가입</button>
			</div>
		</c:if>
		
	</div>
</header>




