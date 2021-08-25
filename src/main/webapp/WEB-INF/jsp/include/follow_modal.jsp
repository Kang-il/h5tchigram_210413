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

<script>
function getFollowList(feedOwnerId,division,URL){
	$('.follow-members-section').empty();
	$.ajax({
		type:'POST'
		,data:{'feedOwnerId':feedOwnerId}
		,url: URL
		,success:function(data){
			//성공시 oppend
			if(data.loginCheck==true){
				//내가 로그인 되어있는 경우에만 팔로우 팔로잉 리스트 뿌릴 것
				
				//내 아이디 분리
				let myId=data.loginUserFollowingList.pop();
				
					console.log(data.loginUserFollowingList);
					
					console.log(myId);
					
				data.followList.map(follow =>{
					
					let followUserId = division=='following'? follow.followerUserId : follow.followingUserId;
					
					let button='';
					
					console.log("::::::::::"+followUserId);
					
					if(data.loginUserFollowingList.indexOf(followUserId)!=-1){
						//내가 팔로우 한 유저
						button='<button type="button" id="unfollowBtn'+followUserId+'" class="follow-action-del-btn" data-user-id="'+followUserId+'"data-user-login-id="'
								+follow.followUserLoginId+'">삭제</button>';
					}else{
						
						//내가 팔로우 하지 않은 유저
						button='<button type="button" id="followingBtn'+followUserId+'" class="follow-action-following-btn" data-user-id="'+followUserId+'">팔로우</button>';
					}
					
					if(followUserId == myId){//팔로워 유저 아이디가 나라면
						button='';
					}
					
					
					let imageUrl='';
					if(follow.followProfileImagePath==null){
						imageUrl="/static/images/no_profile_image.png";
						
					}else{
						imageUrl=follow.followProfileImagePath;
					}
					
					let html='<div class="follow-member-item">'
								+'<img src="'+imageUrl+'" class="follow-image" id="followUserImg'+followUserId+'">'
								+'<a href="/user/main_view?userId='
										+followUserId+'" class="follow-login-id">'
									+'<span>'+follow.followUserLoginId+'</span>'
								+'</a>'
								+'<div class="follow-action-button-box">'
									+button
								+'</div>'
							+'</div>';
							
					$('.follow-members-section').append(html).trigger("create");
					
				});
				
				
				
			}else{
				//내가 로그인 되어있지 않은경우 로그인 페이지로 리다이렉트 시킬 것
				location.href='/user/sign_in_view';
			}
			
		}
		,error:function(e){
			alert(e);
		}
	});
}

$(document).ready(function(){
	
	//팔로잉 칸 클릭시
	$('#following').on('click',function(){
		$('.follow-modal-section').removeClass('d-none');
		$('.content-simple-info').addClass('d-none');
		$('body').addClass('no-scrollbar');
		
		$('.follow-title').text('팔로잉');
		$('.follow-title').data('follow-title','following');
		//팔로잉을 클릭했을 때 
		//follow-members-section 에 following 한 사람들을 가져옴
		let feedOwnerId=$('.follow-title').data('feed-owner-id');
		const URL='/follow/get_following';
		let division='following';
		getFollowList(feedOwnerId,division,URL);
	});
	
	//팔로워 칸 클릭 시
	$('#follower').on('click',function(){
		$('.follow-modal-section').removeClass('d-none');
		$('.content-simple-info').addClass('d-none');
		$('body').addClass('no-scrollbar');
		
		$('.follow-title').text('팔로워');
		$('.follow-title').data('follow-title','follower');
		//팔로워를 클릭했을 때 follow-members-section에 follower들을 가져옴
		let feedOwnerId=$('.follow-title').data('feed-owner-id');
		const URL='/follow/get_follower';
		let division='follower';
		getFollowList(feedOwnerId,division,URL);
	});
	
	//팔로잉 팔로우 모달창에서 팔로잉
	$('.follow-members-section').on('click','.follow-action-following-btn',function(){
		let followId=$(this).data('user-id');
		//팔로잉 모달인지 팔로워 모달인지 확인하는 변수
		let feedOwnerId=$('.follow-title').data('feed-owner-id');
		let division = $('.follow-title').data('follow-title');
		const URL= division=='following' ? '/follow/get_following' :'/follow/get_follower';
		//팔로잉 할 것
		$.ajax({
			type:"POST"
			,data:{'followId':followId
					,'feedOwnerId':feedOwnerId}
			,url:'/follow/do_follow'
			,success:function(data){
				//loginCheck:true시만 진행
				//success 시 팔로우 리스트 다시 뿌리기
				if(data.loginCheck===true){
					if(data.result===true){
						//성공시 리스트 가져오기
						if(data.checkMyFeed===true){
							
								let followingCount=data.followingCount;
								let followerCount=data.followerCount;
								$('#follower').text(followerCount);
								$('#following').text(followingCount);
							
						}
						getFollowList(feedOwnerId,division,URL);
						
					}else{
						alert('팔로우 실패 관리자에게 문의해주세요!');
					}
				}else{
					location.href="/user/sign_in_view";
				}
				
			}
			,error:function(e){
				alert(e);
			}
		});
	});
	
	//팔로잉 팔로우 모달창에서 언팔로우
	$('.follow-members-section').on('click','.follow-action-del-btn',function(){
		
		//언팔로우 는 한 번 더 묻기 위해 모달창을 연다.
		$('.follow-delete-modal-section').removeClass('d-none');
		//해당 유저의 이름을 삽입
		let userId=$(this).data('user-login-id');
		$('.unfollow-userId').text(userId);
		
		
		let followId=$(this).data('user-id');
		let feedOwnerId=$('.follow-title').data('feed-owner-id');
		$('.delete-user-image').attr('src',$('#followUserImg'+followId).attr('src'));
		
		//팔로잉 모달인지 팔로워 모달인지 확인하는 변수
		let division = $('.follow-title').data('follow-title');
		const URL= division=='following' ? '/follow/get_following' :'/follow/get_follower';

		$('.delete-btn').data('follow-id',followId);
		$('.delete-btn').data('feed-owner-id',feedOwnerId);
		$('.delete-btn').data('division',division);
		$('.delete-btn').data('URL',URL);
		
	});
	
	//좋아요 목록에서 팔로잉/언팔로우
	$('.like-unit-box').on('click','.like-section-following-btn',function(){
		let followId=$(this).data('user-id');
		let postId=$(this).data('post-id');
		//feedOwnerId
		let feedOwnerId=$('.all-contents-btn').data('feed-owner-id');
		
		$.ajax({
			type:'POST'
			,data:{'followId':followId
				  ,'feedOwnerId':feedOwnerId}
			,url:'/follow/do_follow'
			,success:function(data){
				if(data.loginCheck===true){
					//팔로우 시 
					//팔로우 리스트 다시 불러오기
					//1. loginCheck
					//2. likeList
					//3. followingList //getFollower
					if(data.checkMyFeed===true){
						let followingCount=data.followingCount;
						let followerCount=data.followerCount;
						$('#follower').text(followerCount);
						$('#following').text(followingCount);			
					}
					
					$.ajax({
						type:'GET'
						,data:{'postId':postId}
						,url:'/like/get_like_list'
						,success:function(likeData){
							console.log(likeData.loginCheck,likeData.likeList,likeData.followingList)
							createLikeList(likeData.loginCheck
											,likeData.likeList
											,likeData.followingList);
						}
						,error:function(e){
							
						}
					});
					
				}else{
					location.href="/user/sign_in_view";
				}
				
			}
			,error:function(e){
				alert(e);
			}
			
		});
	});
	
	//좋아요 목록에서 팔로잉/언팔로우
	$('.like-unit-box').on('click','.like-section-follower-btn',function(){
		//팔로우 취소
		let followId=$(this).data('user-id');
		let postId=$(this).data('post-id');
		
		let userId=$(this).data('like-user-login-id');

		$('.unfollow-userId').text(userId);
		
		$('.delete-user-image').attr('src',$('#likeUserImg'+followId).attr('src'));
		//feedOwnerId
		let feedOwnerId=$('.all-contents-btn').data('feed-owner-id');
		$('.follow-delete-modal-section').removeClass('d-none');
		
		
		
		$('.delete-btn').data('follow-id',followId);
		$('.delete-btn').data('feed-owner-id',feedOwnerId);
		
		
		$('.delete-btn').data('post-id',postId);
		$('.delete-btn').data('division',null);
		$('.delete-btn').data('URL',null);
		
	});
	
	//유저 피드에 팔로우하기 버튼 클릭 시 팔로우 진행
	$('.profile-follow-btn').on('click',function(){
		let followId=$(this).data('feed-owner-id');
		$.ajax({
			type:'POST'
			,url:'/follow/do_follow'
			,data:{'followId':followId,
				   'feedOwnerId':followId}
			,success:function(data){
				location.reload();
			}
			,error:function(e){
				alert(e);
			}
			
		});
	});
	
	//유저 피드에 팔로잉 버튼 클릭 시 언팔로우 진행
	$('.profile-following-btn').on('click',function(){
		let followId=$(this).data('feed-owner-id');
		$('.follow-delete-modal-section').removeClass('d-none');
		
		$('.unfollow-userId').text($('#profileUserId').text());
		$('.delete-user-image').attr('src',$('.profile-image').attr('src'));
		
		//상대방 피드에서 팔로우 하는 것이기때문에 이 정보만 필요
		$('.delete-btn').data('follow-id',followId);
		$('.delete-btn').data('feed-owner-id',followId);
		
		$('.delete-btn').data('post-id',null);
		$('.delete-btn').data('division',null);
		$('.delete-btn').data('URL',null);
	});

	//삭제 버튼 클릭 시
	$('.delete-btn').on('click',function(){
		let followId=$(this).data('follow-id');
		let feedOwnerId=$(this).data('feed-owner-id');
		
		let postId=$(this).data('post-id');
		//좋아요 목록에서 팔로우 시 null임
		let division = $(this).data('division');
		const URL=$(this).data('URL');
		
		$.ajax({
			type:'POST'
			,data:{'followId':followId
				,'feedOwnerId':feedOwnerId}
			,url:'/follow/do_unfollow'
			,success:function(data){
				//loginCheck:true시만 진행
				//result::: success 시 팔로우 리스트 다시 뿌리기
				if(data.loginCheck===true){
					
					if(data.checkMyFeed===true){
						let followingCount=data.followingCount;
						let followerCount=data.followerCount;
						$('#follower').text(followerCount);
						$('#following').text(followingCount);
					}
					
					if(division !== null && URL !== null){
						getFollowList(feedOwnerId,division,URL);
					}else if(division === null && URL ===null && postId !== null){
						
						$.ajax({
							
							type:'GET'
							,data:{'postId':postId}
							,url:'/like/get_like_list'
							,success:function(likeData){
								createLikeList(likeData.loginCheck
												,likeData.likeList
												,likeData.followingList);
							}
							,error:function(e){
								
							}
						});
						
					}else if(division===null && URL === null && postId === null){
						location.reload();
					}
					
				}else{
					location.href="/user/sign_in_view";
				}
				
			}
			,error:function(e){
				alert(e);
			}
			
		});

		
		$('.follow-delete-modal-section').addClass('d-none');
		
	});
	
	
	$('.follow-modal-section').on('click',function(e){
		if(!$('.follow-modal-box').has(e.target).length){
			
			$('.follow-modal-section').addClass('d-none');
			$('.content-simple-info').removeClass('d-none');
			$('body').removeClass('no-scrollbar');
		}
	});
		
	$('.follow-action-del-btn').on('click',function(){
		$('.follow-delete-modal-section').removeClass('d-none');
		$('body').addClass('no-scrollbar');
	});
		
	$('.cancel-btn').on('click',function(){
		$('.follow-delete-modal-section').addClass('d-none');
	});
		
	$('.follow-delete-modal-section').on('click',function(e){
		if(!$('.follow-delete-modal-box').has(e.target).length){
			$('.follow-delete-modal-section').addClass('d-none');
		}
	});
});

</script>
