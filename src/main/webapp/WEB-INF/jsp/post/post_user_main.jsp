<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  

<jsp:include page="../include/modal.jsp"/>
<jsp:include page="../include/follow_modal.jsp"/>


<div class="profile-section">
		<div class="profile-divide-section">
		
			<div class="profile-box">
			
				<div class="profile-image-box">
				
					<div class="profile-image-frame">
					
						<div class="profile-image-item">
							<c:if test="${feedOwner.profileImagePath eq null}">
								<img src="/static/images/no_profile_image.png" class="profile-image">
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
						<span>${feedOwner.loginId}</span>
						<c:choose>
							<%-- 내 피드 --%>
							<c:when test="${checkMyFeed eq true}">
								<button type="button" class="profile-edit-btn">프로필 편집</button>
							</c:when>
							<%-- 상대방 피드 --%>
							<c:when test="${checkMyFeed eq false}">
							
								<c:if test="${checkFollowing eq true }">
									<button type="button" class="profile-follow-btn">팔로우</button>
								</c:if>
								
								<c:if test="${checkFollowing eq false}">								
									<button type="button" class="profile-follow-btn">팔로우 하기</button>
								</c:if>
								
							</c:when>
							<%-- 로그인이 안되어있음 --%>
							<c:when test="${checkMyFeed eq null }">
							</c:when>
						</c:choose>
					</div>
					
					<div class="profile-info-box2">
						<div>게시물 <span>${postCount}</span></div>
						<div>팔로워 <span class="profile-info-follow">${followerCount}</span></div>
						<div>팔로잉 <span class="profile-info-follow">${followingCount}</span></div>
					</div>
					
					<div class="profile-info-box3">
						<div><span>${feedOwner.nickname}</span></div>
						<div>${feedOwner.introduce}</div>
					</div>
					
				</div>
				
			</div>
		</div>
		
		<hr class="m-0">
		
		<nav class="profile-contents-nav" data-category="${category}">
			<button type="button" class="all-contents-btn" data-feed-owner-id="${feedOwner.id}">게시물</button>
			<button type="button" class="only-contents-photo-btn" data-feed-owner-id="${feedOwner.id}">사진</button>
			<button type="button" class="only-contents-video-btn" data-feed-owner-id="${feedOwner.id}">동영상</button>
			<c:if test="${user.id eq feedOwner.id}">
				<button type="button" class="pined-contens-btn" data-feed-owner-id="${feedOwner.id}">저장됨</button>
			</c:if>
		</nav>
		
		<div class="profile-contents-box">
			<%--TODO:::forEach 동적으로--%>
			
		<c:forEach var="post" items="${postThumbnailList}" varStatus="status">
			<c:if test="${status.index % 3 eq 0 }">
				<div class="profile-contents-row">
			</c:if>
			
				<div class="profile-content" data-post-id="${post.postId}" data-content-type="${post.contentType}">
					<div class="profile-contents-unit">
						<img src="${post.imagePath}" class="post-image">
						<div class="content-simple-info">
							<span class="material-icons-outlined icon">favorite</span>
							<span class="count post-like-list" >${post.likeCount}</span>
							<span class="material-icons icon">chat_bubble</span>
							<span class="count comment-list">${post.commentCount}</span>
						</div>
					</div>
				</div>
				
			<c:if test="${status.index % 3 eq 2 }">
				</div>
			</c:if>
</c:forEach>
		</div>
	</div>
	
	
	<script>
		//ㅇㅇ이 좋아요를 눌렀다. ㅇㅇ 외 ㅇㅇ명이 좋아요를 눌렀다 를 구성하는 function
		function createLikeCount(likeList){
			
			if(likeList.length==0){
				//좋아요가 없을 경우
				$('.item-like-section').empty();
				
			}else if(likeList.length==1){
				//좋아요가 1명일경우
				$('.item-like-section').empty();
				likeList.map(like=>{
					let likeProfileImagePath=like.porfileImagePath==null ? "/static/images/no_profile_image.png":like.profileImagePath;
					$('.item-like-section').append('<a href="/user/main_view?userId='+like.userId+'"><img src="'+likeProfileImagePath+'" class="like-profile"/></a>'
															+'<a href="/user/main_view?userId='+like.userId+'" class="like-first-id ml-1">'+like.userLoginId+'</a>'
															+'<span class="ml-1">님이 좋아합니다.</span>');
				});
			}else{
				//좋아요가 1명 이상일 경우
				$('.item-like-section').empty();
				
				let lastLike=likeList[likeList.length-1];
				
				
				let likeProfileImagePath=lastLike.porfileImagePath==null ? "/static/images/no_profile_image.png":like.profileImagePath;
				//대략적으로 몇명이 좋아요 누른지 알게 해주는 설명
				$('.item-like-section').append(
						'<a href="/user/main_view?userId='+lastLike.userId+'"><img src="'+likeProfileImagePath+'" class="like-profile"/></a>'
						+'<a href="/user/main_view?userId='+lastLike.userId+'" class="like-first-id ml-1">'+lastLike.userLoginId+'</a>'
						+'<span class="ml-1">님 외</span>'
						+'<button class="like-headcount-btn" type="button">'+(likeList.length-1)+'</button>'
						+'<span>명이 좋아합니다</span>');
				
			}
		}
		
		
		function createLikeList(loginCheck,likeList,followingList){
			//모달창 열 때마다 초기화 시킬 것
			$('.like-unit-box').empty();
			
			if(loginCheck===false){
				//모달창에 로그인 후 이용가능하다는 메시지 남기기
			}else{
				//stack 구조라 가장 마지막에 자신의 아이디가 들어감
				let myId = followingList.pop();
				
				
				likeList.map(like =>{
					//1.라이크 누른 사람들이 내가 팔로우를 했는지의 여부를 가져올 것
					//userId... followingList
					
					// 프로필이 있는지 없는지 확인
					let likeProfileImagePath=like.porfileImagePath==null ? "/static/images/no_profile_image.png":like.profileImagePath;

					let button='';
					
					//팔로우 리스트에 같은값이 존재한다면 팔로우가 되어있으니 팔로잉 버튼을 보여줄것
					
					//TODO ::::: 팔로잉 언팔로우 기능 구현할 때 버튼 수정!!!! 
					if(followingList.indexOf(like.userId)!=-1){
						//TODO :::: 팔로우 버튼 클릭 시 바로 팔로우 처리 할 예정
						button = '<button type="button" class="like-section-follower-btn" onclick="following('+like.userId+')">팔로잉</button>';
					}else{
					//팔로우 리스트에 같은값이 없다면 팔로우가 안되어있으니 팔로우 버튼을 보여줄 것
					//팔로우 취소할 지 한 번 더 물어보기 위해 onClick시에 유저의 아이디를 넘겨주는 function을 만듦
						button = '<button type="button" class="like-section-following-btn" onclick="sendUserId('+like.userId+')">팔로우</button>';
					}
					
					//좋아요 누른 사람의 아이디번호가 로그인된 아이디 번호와 같다면 버튼을 없앨 것
					if(like.userId==myId){
						button='';
					}
					
					//미리 html을 만들어줌
					let html=('<div class="like-item">'
									+'<div>'
										+'<a href="/user/main_view?userId='+like.userId+'" class="like-pic-link">'
											+'<img src="'+likeProfileImagePath+'"class="like-modal-user-pic">'
										+'</a>'
										+'<a href="/user/main_view?userId='+like.userId+'" class="like-user-link">'+like.userLoginId+'</a>'
									+'</div>'
									+'<div>'
										+button //버튼 추가
										+'</div>'
									+'</div>');
					//동적으로 값을 넣어줌
					$('.like-unit-box').append(html);
					
				});
			}
		}
		$(document).ready(function(){
			if($('.profile-contents-nav').data('category')=='all'){
				$('.all-contents-btn').focus();
			}else if($('.profile-contents-nav').data('category')=='video'){
				$('.only-contents-video-btn').focus();
			}else if($('.profile-contents-nav').data('category')=='photo'){
				$('.only-contents-photo-btn').focus();
			}else if($('.profile-contents-nav').data('category')=='pinned'){
				$('.pinned-contents-btn').focus();
			}
			
			$('.all-contents-btn').on('click',function(){
				let feedOwnerId = $(this).data('feed-owner-id');
				location.href="/user/main_view?userId="+feedOwnerId+'&category=all';
				$(this).focus();
			});
			
			$('.only-contents-photo-btn').on('click',function(){
				let feedOwnerId = $(this).data('feed-owner-id');
				location.href="/user/main_view?userId="+feedOwnerId+'&category=photo';
				$(this).focus();
			});
			
			$('.only-contents-video-btn').on('click',function(){
				let feedOwnerId = $(this).data('feed-owner-id');
				location.href="/user/main_view?userId="+feedOwnerId+'&category=video';
				$(this).focus();
			});
			
			$('.pined-contens-btn').on('click',function(){
				let feedOwnerId = $(this).data('feed-owner-id');
				location.href="/user/main_view?userId="+feedOwnerId+'&category=pinned';
				$(this).focus();
			});
			
			//좋아요 클릭
			//좋아요 리스트를 가져온다.
			$('.modal-like-before-btn').on('click',function(){
				let postId=$(this).data("post-id");
				
				$.ajax({
					type:'POST'
					,data:{'postId':postId}
					,url:'/like/insert_like'
					,success:function(data){
						if(data.result===true){
							//좋아요 버튼 클릭시 좋아요 버튼 전환
							$('.modal-like-before-btn').addClass('d-none');
							$('.modal-like-after-btn').removeClass('d-none');
							//좋아요 카운트를 동적으로 바꿔준다
							createLikeCount(data.likeList);
							//좋아요 목록 클릭 시 동적으로 변화 시켜준다 -- 자신의 좋아요가 반영될 수 있도록
							createLikeList(data.loginCheck,data.likeList,data.followingList);
						}else{
							alert('로그인 하세요');
							location.href='/user/sign_in_view';
						}
						
					}
					,error:function(e){
						alert(e);
					}
				});
			});
			
			//좋아요 취소
			$('.modal-like-after-btn').on('click',function(){
				let postId=$(this).data("post-id");
				$.ajax({
					type:'POST'
					,data:{'postId':postId}
					,url:'/like/delete_like'
					,success:function(data){
						if(data.result===true){
							//좋아요 취소 클릭시 좋아요 버튼 전환
							$('.modal-like-before-btn').removeClass('d-none');
							$('.modal-like-after-btn').addClass('d-none');
							//좋아요 카운트를 동적으로 바꿔준다.
							createLikeCount(data.likeList);
							//좋아요 목록 클릭 시 동적으로 변화 시켜준다 -- 자신의 좋아요가 반영될 수 있도록
							createLikeList(data.loginCheck,data.likeList,data.followingList);
						}else{
							alert('로그인 하세요');
							location.href='/user/sign_in_view';
						}
					}
					,error:function(e){
						alert(e);
					}
				});
			});
			
			$('.modal-pin-before-btn').on('click',function(){
				//저장하기 클릭
				let postId=$(this).data('post-id');
				console.log(postId);
				$.ajax({
					type:'get'
					,url:'/pin/create_pin'
					,data:{'postId':postId}
					,success: function(data){
						if(data.result===true){
							$('.modal-pin-before-btn').addClass('d-none');
							$('.modal-pin-after-btn').removeClass('d-none');
						}else{
							alert("저장 실패 관리자에게 문의하세요");
						}
					}
					,error:function(e){
						alert(e);
					}
				});
			});
			
			$('.modal-pin-after-btn').on('click',function(){
				//저장하기 취소
				let postId=$(this).data('post-id');
				
				$.ajax({
					type:'get'
					,url:'/pin/delete_pin'
					,data:{'postId':postId}
					,success: function(data){
						if(data.result===true){
							$('.modal-pin-before-btn').removeClass('d-none');
							$('.modal-pin-after-btn').addClass('d-none');
						}else{
							alert("삭제 실패 관리자에게 문의하세요");
						}
					}
					,error:function(e){
						alert(e);
					}
				});
			});
			
			$(".profile-content").on('click',function(){
				let postId=$(this).data("post-id");
				
				//1.내가 좋아요를 눌렀는지 알아야 함
				//userId--세션에서 가져감 postId만 전송
				//좋아요를 눌렀는지 체크 하는 기능
				$('.modal-like-before-btn').data('post-id', postId);
				$('.modal-like-after-btn').data('post-id', postId);
				
				//2. 내가 pin 을 했는지 알아야 함 --
				$('.modal-pin-before-btn').data('post-id',postId);
				$('.modal-pin-after-btn').data('post-id',postId);
				
				$.ajax({
					type:'GET'
					,url:'/pin/check_pin'
					,data:{'postId':postId}
					,success:function(data){
						if(data.result===true){//저장되어있음
							$('.modal-pin-before-btn').addClass('d-none');
							$('.modal-pin-after-btn').removeClass('d-none');
						}else if(data.result===false){
							$('.modal-pin-after-btn').addClass('d-none');
							$('.modal-pin-before-btn').removeClass('d-none');
						}
					}
					,error: function(e){
						alert(e);
					}
				});
				
				
				//다른 게시물 클릭 시 input 창에 쓰여져있는 텍스트를 모두 지워준다
				$('.modal-comment-form').val('');
				
				$.ajax({
					type:'GET'
					,url:'/like/check_like'
					,data:{'postId':postId}
					,success:function(data){

						if(data.result===true){//좋아요 누름
							$('.modal-like-before-btn').addClass('d-none');
							$('.modal-like-after-btn').removeClass('d-none');
						}else{
							$('.modal-like-before-btn').removeClass('d-none');
							$('.modal-like-after-btn').addClass('d-none');
						}
					}
					,error:function(e){
						alert(e);
					}
				});
				
				
				$.ajax({
					type:"post"
					,url:'/post/get_post'
					,data:{'postId':postId}
					,success:function(data){
						$('.comment-modal-content-picture').attr('src',data.post.imagePath);
						$('.delete-link').attr('href','/post/delete_post?postId='+data.post.id);
						$('.go-to-post-link').attr('href','/post/post_detail_view?postId='+data.post.id);
						// 프로필 사진 링크
						
						$('.content-user-link, .user-id, .comment-id').attr('href','/user/main_view?userId='+data.post.userId);
						$('.user-id, .comment-id').text(data.post.userLoginId);
						console.log(data.post.userLoginId);
						$('.comment-modal-post-content').text(data.post.content);
						//댓글 작성 동적으로 반복해서 추가해 준다.
						data.post.commentList.map(comment=>{
							
							let profileImagePath= comment.profileImagePate==null ? "/static/images/no_profile_image.png" : comment.profileImagePath;
							$('.comments-box').append('<div class="comment-item">'+'<div><a href="/user/main_view?userId='+comment.userId+'">'
																+'<img src="'+profileImagePath+'" class="user-profile"/></a>'
																+'<a href="/user/main_view?userId='+comment.userId+'"class="comment-id">'+comment.userLoginId+'</a>'
																+'<span class="ml-2">'+comment.comment+'</span>'
															+'</div>'
															+'<div class="comment-menu-box">'
																+'<button type="button" class="material-icons-outlined menu-btn" onclick="deleteModal('+comment.id+')" >more_horiz</button>'
														+'</div>').trigger("create");
						
						});
							
						//라이크 대략적으로 몇명인지 작성해주는 메서드
						createLikeCount(data.post.likeList);
						
						//라이크 리스트를 작성해주는 메서드
						createLikeList(data.loginCheck,data.post.likeList,data.followingList);
						
					}
				});
				
			});
			
			$('.item-like-section').on('click','.like-headcount-btn',function(){
				$('.like-modal-section').removeClass('d-none');
			});
			
			$('.like-modal-section').on('click',function(e){
				if(!$('.item-like-section').has(e.target).length){
					$('.like-modal-section').addClass('d-none');
					//comment-modal-section에 d-none클래스가 없다면 --보이고있다면
					if($('.comment-modal-section').hasClass('d-none')===true){ 
						$('body').removeClass('no-scrollbar');
					}
				}
			});
			
		});
	
	</script>