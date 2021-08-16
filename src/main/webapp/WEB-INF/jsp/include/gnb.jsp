<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
     
<div class="modal-window"></div>
<header>
	<div class="nav-box">
	
		<div class="header-logo-box">
			<a href="/post/timeline_view"><img src="/static/images/logo.png" width="150px"/></a>
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
							
								<div class="nav-alert-item">
									<a href="#"><img src="/static/images/dummy_profile.jpg" class="nav-alert-profile"></a>
									<span>
										<a href="#" class="nav-alert-id">h5tchi</a>
										<a href="#" class="nav-alert-description">님이 회원님의 사진을 좋아합니다.</a>
									</span>
									<a href="#"><img src="/static/images/dummy_profile.jpg" class="nav-alert-thumbnail"></a>
								</div>
								
							<%----- --%>
						</div>
					</div>
					
					<div class="profile-item-box pb-1">
						<button type="button" class="profile-btn"><img src="/static/images/dummy_profile.jpg" width="28px" class="profile-item "/></button>
		
						<div class="nav-profile-modal d-none">
						
							<div class="modal-nav-item">
								<span class="material-icons-outlined modal-icon">account_circle</span>
								<a href="#" id="profileLink">프로필</a>
							</div>
							
							<div class="modal-nav-item">
								<span class="material-icons-outlined">turned_in_not</span><a href="#">저장됨</a>
							</div>
							
							<div class="modal-nav-item">
								<span class="material-icons-outlined">settings</span><a href="#">설정</a>
							</div>
							
							<div class="modal-nav-item">
								<span class="material-icons-outlined">app_registration</span><a href="#">글 등록</a>
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




