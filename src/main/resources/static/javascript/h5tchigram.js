/**
 * 
 */
 function getCommentModalPost(postId,userId){
	$('.modal-comment-form').attr('id', 'commentForm' + postId);
	$('.comment-submit-btn').attr('id', 'commentSubmitBtn' + postId);

	//1.내가 좋아요를 눌렀는지 알아야 함
	//userId--세션에서 가져감 postId만 전송
	//좋아요를 눌렀는지 체크 하는 기능
	$('.modal-like-before-btn').data('post-id', postId);
	$('.modal-like-after-btn').data('post-id', postId);
	 $('.modal-like-before-btn').data('user-id', userId);
	 $('.modal-like-after-btn').data('user-id', userId);

	 //2. 내가 pin 을 했는지 알아야 함 --
	 $('.modal-pin-before-btn').data('post-id', postId);
	 $('.modal-pin-after-btn').data('post-id', postId);

	 $.ajax({
		 type: 'GET'
		 , url: '/pin/check_pin'
		 , data: { 'postId': postId }
		 , success: function(data) {
			 if (data.result === true) {//저장되어있음
				 $('.modal-pin-before-btn').addClass('d-none');
				 $('.modal-pin-after-btn').removeClass('d-none');
			 } else if (data.result === false) {
				 $('.modal-pin-after-btn').addClass('d-none');
				 $('.modal-pin-before-btn').removeClass('d-none');
			 }
		 }
		 , error: function(e) {
			 alert(e);
		 }
	 });

	 //다른 게시물 클릭 시 input 창에 쓰여져있는 텍스트를 모두 지워준다
	 $('.modal-comment-form').val('');

	 //좋아요 체크 ajax
	 $.ajax({
		 type: 'GET'
		 , url: '/like/check_like'
		 , data: { 'postId': postId }
		 , success: function(data) {

			 if (data.result === true) {//좋아요 누름
				 $('.modal-like-before-btn').addClass('d-none');
				 $('.modal-like-after-btn').removeClass('d-none');
			 } else {
				 $('.modal-like-before-btn').removeClass('d-none');
				 $('.modal-like-after-btn').addClass('d-none');
			 }
		 }
		 , error: function(e) {
			 alert(e);
		 }
	 });

	 //포스트의 정보를 가져오는 포스트
	 $.ajax({
		 type: "post"
		 , url: '/post/get_post'
		 , data: { 'postId': postId }
		 , success: function(data) {

			 //게시물 이미지
			 $('.comment-modal-content-picture').attr('src', data.post.imagePath);

			 //포스트 지우는 링크에 값을 넣어줌
			 $('.delete-link').attr('href', '/post/delete_post?postId=' + data.post.id);

			 //게시물 상세보기 페이지 이동
			 $('.go-to-post-link').attr('href','/post/post_detail_view?postId=' + data.post.id);

			 // 프로필 사진 링크
			 $('.content-user-link, .user-id, .owner-id').attr('href', '/user/feed/' + data.post.userLoginId);
			 //
			 $('.user-id, .comment-id').text(data.post.userLoginId);
			 $('.comment-modal-post-content').text(data.post.content);
			 $('.comment-submit-btn').data('post-id', postId);
			 $('.item-emoji-picker').data('post-id', postId);


			 createCommentList(data.post.commentList, data.post.userId, data.myId);

			 //라이크 대략적으로 몇명인지 작성해주는 메서드
			 createLikeCount(data.post.likeList);

			 //라이크 리스트를 작성해주는 메서드
			 createLikeList(data.loginCheck, data.post.likeList, data.followingList);

		 }
	 });

}
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
					
				data.followList.map(follow =>{
					
					
					let followUserId =   division=='following'? follow.followerUserId : follow.followingUserId;
					
					
					let button='';
					
					if(data.loginUserFollowingList.indexOf(followUserId)!=-1){
						//내가 팔로우 한 유저
						button='<button type="button" id="unfollowBtn'+followUserId+'" class="follow-action-del-btn" data-user-id="'+followUserId+'"data-user-login-id="'+follow.followUserLoginId+'">삭제</button>';
					}else{
						//내가 팔로우 하지 않은 유저
						button='<button type="button" id="followingBtn'+followUserId+'" class="follow-action-following-btn" data-user-id="'+followUserId+'">팔로우</button>';
					}
					
					if(followUserId == myId){
						//팔로워 유저 아이디가 로그인한 유저인 경우
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
								+'<a href="/user/feed/'
										+follow.followUserLoginId+'" class="follow-login-id">'
									+'<span>'+follow.followUserLoginId+'</span>'
								+'</a>'
								+'<div class="follow-action-button-box">'
									+button
								+'</div>'
							+'</div>';
							
					$('.follow-members-section').append(html).trigger("create");
				});
				
			}else{
			//로그인 되어있지 않은경우 로그인 페이지로 보낼 것
				location.href='/user/sign_in_view';
			}
			
		}
		,error:function(e){
			alert(e);
		}
	});
}
 
 
//모달창에 ㅇㅇ이 좋아요를 눌렀다. ㅇㅇ 외 ㅇㅇ명이 좋아요를 눌렀다 를 구성하는 function
function createLikeCount(likeList) {

	if (likeList.length == 0) {
		//좋아요가 없을 경우
		$('.item-like-section').empty();

	} else if (likeList.length == 1) {
		//좋아요가 1명일경우
		$('.item-like-section').empty();
		likeList.map(like => {
			let likeProfileImagePath = like.porfileImagePath == null ? "/static/images/no_profile_image.png" : like.profileImagePath;
			let html='<a href="/user/feed/' + like.userLoginId + '">'
						+'<img src="' + likeProfileImagePath + '" class="like-profile"/>'
					 +'</a>'
					 + '<a href="/user/feed/' + like.userLoginId + '" class="like-first-id ml-1">' 
					 		+ like.userLoginId 
					 + '</a>'
					+ '<span class="ml-1">님이 좋아합니다.</span>';
			$('.item-like-section').append(html);
		});
	} else {
		//좋아요가 1명 초과일 경우
		$('.item-like-section').empty();
		
		let lastLike = likeList[likeList.length - 1];
		
		let likeProfileImagePath = lastLike.porfileImagePath == null ? "/static/images/no_profile_image.png" : like.profileImagePath;
		//대략적으로 몇명이 좋아요 누른지 알게 해주는 설명
		let html='<a href="/user/feed/' + lastLike.userLoginId + '">'
				+'<img src="' + likeProfileImagePath + '" class="like-profile"/>'
			+'</a>'
			+'<a href="/user/feed/' + lastLike.userLoginId + '" class="like-first-id ml-1">' 
				+ lastLike.userLoginId 
			+'</a>'
			+'<span class="ml-1">님 외</span>'
			+'<button class="like-headcount-btn" type="button">' 
				+ (likeList.length - 1) 
			+'</button>'
			+ '<span>명이 좋아합니다</span>';
		
		$('.item-like-section').append(html);

	}
}

function createLikeList(loginCheck, likeList, followingList) {
	//모달창 열 때마다 초기화 시킬 것
	$('.like-unit-box').empty();

	if(loginCheck === false){
		//모달창에 로그인 후 이용가능하다는 메시지 남기기
	}else{
		//stack 구조라 가장 마지막에 자신의 아이디가 들어감
		let myId = followingList.pop();

		likeList.map(like => {
			//1.라이크 누른 사람들이 내가 팔로우를 했는지의 여부를 가져올 것
			//userId... followingList

			// 프로필이 있는지 없는지 확인
		let likeProfileImagePath = like.porfileImagePath == null ? "/static/images/no_profile_image.png" : like.profileImagePath;

		let button = '';

			//팔로우 리스트에 같은값이 존재한다면 팔로우가 되어있으니 팔로잉 버튼을 보여줄것
		if(followingList.indexOf(like.userId) != -1){

				button = '<button type="button" class="like-section-follower-btn" data-user-id="' + like.userId + '"data-like-user-login-id="' + like.userLoginId + '" data-post-id="' + like.postId + '">삭제</button>';
		}else{
				//팔로우 리스트에 같은값이 없다면 팔로우가 안되어있으니 팔로우 버튼을 보여줄 것
				//팔로우 취소할 지 한 번 더 물어보기 위해 onClick시에 유저의 아이디를 넘겨주는 function을 만듦
				button = '<button type="button" class="like-section-following-btn" data-user-id="' + like.userId + '" data-post-id="' + like.postId + '">팔로우</button>';
		}
			//좋아요 누른 사람의 아이디번호가 로그인된 아이디 번호와 같다면 버튼을 없앨 것
		if(like.userId == myId){
				button = '';
		}

			//미리 html을 만들어줌
			let html = ('<div class="like-item">'
							+'<div>'
								+'<a href="/user/feed/' + like.userLoginId + '" class="like-pic-link">'
									+'<img src="' + likeProfileImagePath + '" id="likeUserImg' + like.userId + '" class="like-modal-user-pic">'
								+'</a>'
								+'<a href="/user/feed/' + like.userLoginId + '" class="like-user-link">' + like.userLoginId + '</a>'
							+'</div>'
							+'<div>'
								+ button //버튼 추가
							+'</div>'
						+'</div>');
			//동적으로 값을 넣어줌
			$('.like-unit-box').append(html);
		});
	}
}
		
function createCommentList(commentList, postUserId, myId) {

	// 댓글 메뉴는 본인 포스터 글 또는 본인이 쓴 댓글만 지울 수 있도록 노출한다.
	//userId postId-- checkMyPost
	//
	$('.comments-box').empty();
	//댓글 작성 동적으로 반복해서 추가해 준다.
	commentList.map(comment => {
		let button = '';
		if (myId == comment.userId || postUserId == myId) { //내 아이디와 코멘트 유저의 아이디 일치하다면 혹은 포스트작성자와 내 아이디가 일치하면 버튼을 생성하겠다.
			button = '<button type="button" class="material-icons-outlined comment-menu-btn" data-comment-id="' + comment.id + '"data-post-id="'+comment.postId+'">more_horiz</button>';
		}
		let profileImagePath = comment.profileImagePate == null ? "/static/images/no_profile_image.png" : comment.profileImagePath;
		
		let html='<div class="comment-item">'
					 + '<div>'
					 		+'<a href="/user/feed/' + comment.userLoginId + '">'
								+ '<img src="' + profileImagePath + '" class="user-profile"/>'
							+'</a>'
							+ '<a href="/user/feed/' + comment.userLoginId + '"class="comment-id">' 
								+ comment.userLoginId 
							+ '</a>'
							+ '<span class="ml-2">' 
								+ comment.comment 
							+ '</span>'
					+ '</div>'
					+ '<div class="comment-menu-box">'
						+ button
					+ '</div>'
				+'</div>';
		
		$('.comments-box').append(html).trigger("create");
		
		$('.comment-input-box').empty();
		$('.comment-input-box').append('<input type="text" class="modal-comment-form" placeholder="댓글을 입력해 주세요.."/>');
		
	});
} 
 
  //회원가입 function
  function signUp(){

		let signUpId=$('#signUpId').val().trim();
		let signUpName=$('#signUpName').val().trim();
		let signUpNickname=$('#signUpNickname').val().trim();
		let signUpPassword=$('#signUpPassword').val().trim();
		
		//아이디에 입력값이 없을 경우
		if(signUpId==''){
			$('#notEnterIdAlert').removeClass('d-none');
			$('#duplicationAlert').addClass('d-none');
			$('#idLengthAlert').addClass('d-none');
			return;
		}
		
		if(signUpId.length<=4){
			$('#idLengthAlert').removeClass('d-none');
			$('#notEnterIdAlert').addClass('d-none');
			$('#duplicationAlert').addClass('d-none');
			return;
		}
		
		//정규식을 이용한 비밀번호 유효성 검사
		//조건1. 비밀번호는 6~20자이다. 
		//조건2. 영문 숫자 특수문자의 조합 (숫자와 영문 특수문자가 최소 1가지 이상은 들어가야함)
		let checkNum=signUpPassword.search(/[0-9]/g);
		let checkEng=signUpPassword.search(/[a-z]/ig);
		//
		if(( /^(?=.*[a-zA-Z])(?=.*\W).{6,20}$/.test(signUpPassword)===false ) || (checkNum<0 || checkEng<0)){
			$('#passwordValidationCheck').removeClass('d-none');
			$('.sign-up-box').css('height','530px');
			return;
		}
			
		//1.아이디 중복 체크
		$.ajax({	
			type:'GET'
			,data:{'signUpId':signUpId}
			,url:'/user/is_duplication_id'
			,success: 
				function(data){
					if(data.result===true){
						
					//중복일 경우 띄워줌
					$('#duplicationAlert').removeClass('d-none');
					$('#idLengthAlert').addClass('d-none');
					$('#notEnterIdAlert').addClass('d-none');
					return;
					
					}if(data.result===false){
						
						//중복이 아닐경우 DB접근하여 회원가입 시작
						$.ajax({
							type:'POST'
							,url:'/user/sign_up'
							,data:{'loginId':signUpId
								 	,'password':signUpPassword
								 	,'name':signUpName
								 	,'nickname':signUpNickname
								   }
							,success:function(data){
								
									if(data.result===true){
										alert('회원가입 성공! 로그인 해주세요');
										//성공시 로그인 페이지로 이동
										location.href='/user/sign_in_view';
										return;
									}else{
										alert('회원가입 실패!');
										return;
									}
								}
							,error:function(e){
								alert(e);
								}
						});//회원가입ajax끝

					}
				}
				,error:function(e){
					alert(e);
				}
			});//중복확인ajax끝
		}
		
	//로그인 function
	function signIn(){
				
		let loginId=$('#loginId').val().trim();
		let password=$('#loginPassword').val().trim();
		
		//아이디가 비어있는경우 경고문 
		if(loginId==''){
			$('.login-alert-box').removeClass('d-none');
			return;
		}
		//비밀번호가 비어있는 경우 경고문			
		if(password==''){
			$('.login-alert-box').removeClass('d-none');
			return;
		}
		
		//아이디와 비밀번호로 DB연동하여 일치여부 확인 		
		$.ajax({
			type:'POST'
			,url:'/user/sign_in'
			,data:{'loginId':loginId,'password':password}
			,success:function(data){
				if(data.result===true){
					//성공시 타임라인 페이지로 이동시킨다.
					location.href="/timeline/timeline_view";
				}else{
					//로그인 실패시 경고창 발생
					$('.login-alert-box').removeClass('d-none');
				}
			}
			,error:function(e){
				alert(e);
			}
		});
	}	
	
 	//모달창 종료 (게시글 메뉴창에 취소버튼을 눌렀을 경우)
	function cancelModal(){
		$('.menu-modal-section').addClass('d-none');
		$('.menu-modal-section-not-owner').addClass('d-none');
		$('.comment-description-modal').addClass('d-none');
		$('.detail-comment-description-modal').addClass('d-none');
		if($('.comment-modal-section').hasClass('d-none')){
			$('body').removeClass('no-scrollbar');			
		}
 	}

 	//emoji picker 메서드
 	function setPicker(buttonId,inputClass){
		const picker = new EmojiButton({
				position:'top'
		});		
		const button = document.querySelector(buttonId);			
		picker.togglePicker(button);
					
		//z-index 추가해서 맨 앞으로 나오도록 하기
		$('.wrapper').css('z-index',10);		
		picker.on('emoji',emoji=>{
			let comment =$(inputClass).val()+emoji;
			$(inputClass).val(comment);
			return;
		});
	}

$(document).ready(function(){
	
	//::::::::::::::Sign_UP
	 
	//아이디 값 변경시 유효성 검사문 제거
	$('#signUpId').on('input',function(){
		$('#notEnterIdAlert').addClass('d-none');
		$('#duplicationAlert').addClass('d-none');
		$('#idLengthAlert').addClass('d-none');
	});
	
	//비밀번호 값 변경 시 유효성 검사문 제거
	$('#signUpPassword').on('input',function(){
		$('#passwordValidationCheck').addClass('d-none');
		$('.sign-up-box').css('height','500px');
	});

	//signUp --- 값이 모두 입력되어야 회원가입 버튼 활성화
	$('#signUpId,#signUpName,#signUpNickName,#signUpPassword').on('input',function(){
		let signUpId=$('#signUpId').val().trim().length;
		let signUpName=$('#signUpName').val().trim().length;
		let signUpNickname=$('#signUpNickname').val().trim().length;
		let signUpPassword=$('#signUpPassword').val().trim().length;
		
		if(signUpId!=0 && signUpName!=0 && signUpNickname!=0 && signUpPassword!=0){
			$('#signUpBtn').attr('disabled',false);
		}else{
			$('#signUpBtn').attr('disabled',true);
		}
	});
		
	//유효성 검사 및 회원가입 -- 각 input 창에서 엔터키 입력 시 해당 버튼이 눌림 --버튼이 활성화 되있을 경우만 유효하다.
	$('#signUpId,#signUpName,#signUpPassword,#signUpNickname').keypress(function(key){
			if(key.keyCode==13){
				if($('#signUpBtn').attr('disabled')!='disabled'){
					signUp();
				}
			}
	});
		
	//유효성 검사 및 회원가입 -- 버튼 클릭 시
	$('#signUpBtn').on('click',function(e){
		e.preventDefault();
		signUp();	
	});
	
	//::::::::::::::Sign_IN 
	
	//로그인 패스워드 창 감지하여 값이 모두 입력되어있지 않으면 버튼 비활성화 시킬 것
	//keyup 이나 keydown으로 이벤트를 가져오면 알림div나 버튼의 비활성화가 적절하게 이루어지지 않았다.
	$('#loginId , #loginPassword').on('input',function(){

		$('.login-alert-box').addClass('d-none');
		let loginId=$('#loginId').val().trim();
		let password=$('#loginPassword').val().trim();
				
		if(loginId!='' && password!=''){
			$('#loginBtn').attr('disabled',false);
		}else{
			$('#loginBtn').attr('disabled',true);
		}
	});
	
	//로그인 버튼 클릭 시 로그인 function 실행
	$('#loginBtn').on('click',function(e){
				e.preventDefault();
				signIn();
	});
	
	//id input password input에 focus된 상태에서 엔터키를 누를 경우 로그인 function 실행		
	$('#loginId,#loginPassword').keypress(function(key){
		if(key.keyCode==13){
			if($('#loginBtn').attr('disabled')!='disabled'){
				signIn();
			}
		}
	});
	

		
	//trigger이용해서 사진추가 아이콘 클릭 시 숨겨놓은 input file 에 강제로 클릭하는 이벤트 삽입
	$('#createPostAddImageBtn').on('click',function(){
		$('#createPostImageFrame').trigger('click');
	});
		
	//클릭시 모달창을 통해서 이미지 크게보기
	$(".zoom-in-simple-info").on('click',function(){
		$('.create-post-item-modal-section').removeClass('d-none');
		$('body').addClass('no-scrollbar');
		$(".zoom-in-simple-info").addClass("d-none");
		//이미지 태그의 src값 받아오기
			
		let currentImagePath=$('#createPostImage').attr('src');
		$('#PostingZoomInPhoto').attr('src',currentImagePath);

	});
	
	//모달창 외부 영역 클릭 시 모달창 꺼지기
	$('.create-post-item-modal-section').on('click',function(e){
		if(!$('.create-post-item-modal-box').has(e.target).length){
			$('.create-post-item-modal-section').addClass('d-none');
			$(".zoom-in-simple-info").removeClass("d-none");
			$('body').removeClass('no-scrollbar');
		}
	});

	$('.profile-btn').on('focus',function(){
		$('.nav-profile-modal').removeClass('d-none');
		$('#userInfoSection').addClass('user-info-set-z-index');
		$('.modal-window').removeClass('d-none');
		$('.nav-alert-modal').addClass('d-none');
	});

	$('.modal-window').on('click',function(){
		$('.nav-profile-modal').addClass('d-none');
		$('#userInfoSection').removeClass('user-info-set-z-index');
		$('.modal-window').addClass('d-none');
		$('.nav-alert-modal').addClass('d-none');
	});
	
	$('.alert-item').on('focus',function(){
		$('.nav-alert-modal').removeClass('d-none');
		$('#userInfoSection').addClass('user-info-set-z-index');
		$('.modal-window').removeClass('d-none');
		$('.nav-profile-modal').addClass('d-none');
	});
	
	$('.post-menu-btn').on('click',function(){
		let postId =$(this).data('post-id');
		$('.go-to-post-link').attr('href','/post/post_detail_view?postId='+postId);
		if(!$(this).hasClass('not-my-post')){
			$('.menu-modal-section').removeClass('d-none');
			$('body').addClass('no-scrollbar');
		}else{
			$('.menu-modal-section-not-owner').removeClass('d-none');
			$('body').addClass('no-scrollbar');
		}

	});
	
	$('.menu-modal-section-not-owner').on('click',function(e){
		if(!$('.menu-modal-box-not-owner').has(e.target).length){
			$('.menu-modal-section-not-owner').addClass('d-none');
			//comment-modal-section에 d-none클래스가 없다면 --보이고있다면
			if($('.comment-modal-section').hasClass('d-none')===true){ 
				$('body').removeClass('no-scrollbar');
			}
		}
	});
	
	$('.menu-modal-section').on('click',function(e){
		if(!$('.menu-modal-box').has(e.target).length){
			$('.menu-modal-section').addClass('d-none');
			//comment-modal-section에 d-none클래스가 없다면 --보이고있다면
			if($('.comment-modal-section').hasClass('d-none')===true){ 
				$('body').removeClass('no-scrollbar');
			}
		}
	});
	
	$('.comment-description-modal').on('click',function(e){
		if(!$('.menu-modal-box').has(e.target).length){
			
			$('.comment-description-modal').addClass('d-none');
			//comment-modal-section에 d-none클래스가 없다면 --보이고있다면
			if($('.comment-modal-section').hasClass('d-none')===true){ 
				$('body').removeClass('no-scrollbar');
			}
		}
	});
	
	
	
	$('.comment-modal-section').on('click',function(e){
		if(!$('.comment-modal-box').has(e.target).length){
			
			$('.comment-modal-section').addClass('d-none');
			$('.content-simple-info').removeClass('d-none');
			$('body').removeClass('no-scrollbar');
			$('.comments-box').empty();
			location.reload();
			
		}
	});
	
	$('.action-text-focus-btn').on('click',function(){
		$('.modal-comment-form').focus();
	});
	
	$('.detail-section-focus-btn').on('click',function(){
		$('.detail-comment-form').focus();
	});
	
	
	
	$('.profile-content').on('click',function(){
		$('.comment-modal-section').removeClass('d-none');
		$('.content-simple-info').addClass('d-none');
		$('body').addClass('no-scrollbar');
	});
		
		
	//::::::::::::::::::::::: user main view
	if ($('.profile-contents-nav').data('category') == 'all') {
		$('.all-contents-btn').focus();
	} else if ($('.profile-contents-nav').data('category') == 'video') {
		$('.only-contents-video-btn').focus();
	} else if ($('.profile-contents-nav').data('category') == 'photo') {
		$('.only-contents-photo-btn').focus();
	} else if ($('.profile-contents-nav').data('category') == 'pinned') {
		$('.pinned-contents-btn').focus();
	}

	$('.comments-box').on('click', '.comment-menu-btn', function() {
		let commentId = $(this).data('comment-id');
		let postId=$(this).data('post-id');

		$('.comment-description-modal').removeClass('d-none');
		$('.comment-delete-button').data('comment-id',commentId);
		$('.comment-delete-button').data('post-id',postId);
		$('body').addClass('no-scrollbar');
	});
	
	$('.all-contents-btn').on('click', function() {
		let feedOwnerId = $(this).data('feed-owner-id');
		location.href = "/user/feed/" + feedOwnerId + '?category=all';
		$(this).focus();
	});

	$('.only-contents-photo-btn').on('click', function() {
		let feedOwnerId = $(this).data('feed-owner-id');
		location.href = "/user/feed/" + feedOwnerId + '?category=photo';
		$(this).focus();
	});

	$('.only-contents-video-btn').on('click', function() {
		let feedOwnerId = $(this).data('feed-owner-id');
		location.href = "/user/feed/" + feedOwnerId + '?category=video';
		$(this).focus();
	});

	$('.pined-contens-btn').on('click', function() {
		let feedOwnerId = $(this).data('feed-owner-id');
		location.href = "/user/feed/" + feedOwnerId + '?category=pinned';
		$(this).focus();
	});

	//좋아요 클릭
	//좋아요 리스트를 가져온다.
	$('.modal-like-before-btn').on('click', function() {
		let postId = $(this).data("post-id");
		let userId = $(this).data("user-id");
		$.ajax({
			type: 'POST'
			, url: '/like/set_like/'+postId
			, data :{'userId':userId}
			, success: function(data) {
				if (data.result === true) {
					//좋아요 버튼 클릭시 좋아요 버튼 전환
					$('.modal-like-before-btn').addClass('d-none');
					$('.modal-like-after-btn').removeClass('d-none');

					//썸네일 좋아요 수 바꿔주기
					$('#thumbnailLikeCount' + postId).text(data.likeList.length);
					//좋아요 카운트를 동적으로 바꿔준다
					createLikeCount(data.likeList);
					//좋아요 목록 클릭 시 동적으로 변화 시켜준다 -- 자신의 좋아요가 반영될 수 있도록
					createLikeList(data.loginCheck, data.likeList, data.followingList);


				} else {
					alert('로그인 하세요');
					location.href = '/user/sign_in_view';
				}

			}
			, error: function(e) {
				alert(e);
			}
		});
	});

	//좋아요 취소
	$('.modal-like-after-btn').on('click', function() {
		let postId = $(this).data("post-id");
		let userId = $(this).data("user-id");
		$.ajax({
			type: 'POST'
			, url: '/like/set_like/'+postId
			, data :{'userId':userId}
			, success: function(data) {
				if (data.result === true) {
					//좋아요 취소 클릭시 좋아요 버튼 전환
					$('.modal-like-before-btn').removeClass('d-none');
					$('.modal-like-after-btn').addClass('d-none');

					//썸네일 좋아요 수 바꿔주기
					$('#thumbnailLikeCount' + postId).text(data.likeList.length);
					//좋아요 카운트를 동적으로 바꿔준다.
					createLikeCount(data.likeList);
					//좋아요 목록 클릭 시 동적으로 변화 시켜준다 -- 자신의 좋아요가 반영될 수 있도록
					createLikeList(data.loginCheck, data.likeList, data.followingList);


				} else {
					alert('로그인 하세요');
					location.href = '/user/sign_in_view';
				}
			}
			, error: function(e) {
				alert(e);
			}
		});
	});

	$('.modal-pin-before-btn').on('click', function() {
		//저장하기 클릭
		let postId = $(this).data('post-id');
		$.ajax({
			type: 'get'
			, url: '/pin/create_pin'
			, data: { 'postId': postId }
			, success: function(data) {
				if (data.result === true) {
					$('.modal-pin-before-btn').addClass('d-none');
					$('.modal-pin-after-btn').removeClass('d-none');
				} else {
					alert("저장 실패 관리자에게 문의하세요");
				}
			}
			, error: function(e) {
				alert(e);
			}
		});
	});

	$('.modal-pin-after-btn').on('click', function() {
		//저장하기 취소
		let postId = $(this).data('post-id');

		$.ajax({
			type: 'get'
			, url: '/pin/delete_pin'
			, data: { 'postId': postId }
			, success: function(data) {
				if (data.result === true) {
					$('.modal-pin-before-btn').removeClass('d-none');
					$('.modal-pin-after-btn').addClass('d-none');
				} else {
					alert("삭제 실패 관리자에게 문의하세요");
				}
			}
			, error: function(e) {
				alert(e);
			}
		});
	});

	$(".profile-content").on('click', function() {
		
		let postId = $(this).data("post-id");
		let userId = $(this).data("user-id");

		getCommentModalPost(postId,userId);
	});



	$('.btn-box').on('click', '.comment-submit-btn', function(e) {
		//코멘트 내용 가져오기
		//코멘트에 필요한 내용 쓰는 유저 아이디.--세션
		// 포스트 아이디
		e.preventDefault();
		let postId = $(this).data('post-id');
		let comment = $('.modal-comment-form').val();

		$.ajax({
			type: 'post'
			, url: '/comment/create_comment'
			, data: {
				'postId': postId
				, 'comment': comment
			}
			, success: function(data) {
				if (data.loginCheck === true) {
					//썸네일 라이크 갯수 바꿔야됨
					createCommentList(data.commentList, data.postUserId, data.myId);

					let commentCount = parseInt($('#thumbnailCommentCount' + postId).text());
					$('#thumbnailCommentCount' + postId).text(commentCount + 1);

				} else {
					location.href = "/user/sign_in_view";
				}
			}
			, error: function(e) {
				alert(e);
			}
		});


	});
	
	//댓글 지우기 기능
	$('.comment-delete-button').on('click',function(){
		let commentId=$(this).data('comment-id');
		let postId=$(this).data('post-id');
		
		
	
		
		$.ajax({
			type:'POST'
			,url:'/comment/delete_comment'
			,data:{'commentId':commentId
					,'postId':postId}
			,success:function(data){
				if(data.loginCheck===true){
					$('#thumbnailCommentCount'+postId).text(data.commentList.length);
					createCommentList(data.commentList,data.postUserId,data.myId);
					$('body').removeClass('no-scrollbar');
					$('.comment-description-modal').addClass('d-none');
					$('#showTimelinePostDetail'+postId).text('댓글'+(data.commentList.length)+'개 모두보기');
						if( $('.comment-modal-section').hasClass('d-none') ){
							$('body').removeClass('no-scrollbar');			
						}else{
							$('body').addClass('no-scrollbar');
						}
					
				}else{
					location.href='/user/sign_in_view';
				}
			}
			,error:function(e){
				alert(e);
			}
			
			
			
		});
		
	
		
	});

	$('.item-like-section').on('click', '.like-headcount-btn', function() {
		$('.like-modal-section').removeClass('d-none');
	});

	$('.like-modal-section').on('click', function(e) {
		if (!$('.like-modal-box').has(e.target).length) {
			$('.like-modal-section').addClass('d-none');
			//comment-modal-section에 d-none클래스가 없다면 --보이고있다면
			if ($('.comment-modal-section').hasClass('d-none') === true) {
				$('body').removeClass('no-scrollbar');
			}
		}
	});	
	
	//------------------------------------user main view-----------
	
	
	
	//create post view--------------------------------
	
	//이미지 클릭시 이미지 크게보기
	//사진 올리면 미리보기 가능하도록 하기
	$("#createFileInput").on("change", function(e) {

		let files = e.target.files;
		let filesArr = Array.prototype.slice.call(files);

		filesArr.forEach(function(f) {
			if (!f.type.match("image.*")) {
				alert("확장자는 이미지 확장자만 가능합니다.");
				$("#createFileInput").val('');
				return;
			}

			sel_file = f;

			let reader = new FileReader();
			reader.onload = function(e) {
				$("#createPostImage").attr("src", e.target.result);
				$("#createPostImage").removeClass("d-none");
				$("#createPostImageFrame").addClass("d-none");
				$(".zoon-in-photo-unit").removeClass("d-none");
			}

			reader.readAsDataURL(f);

		});
	});

	$('#createPostSubmitBtn').on('click', function() {
		let content = $('#createContent').val();
		if (content == '') {
			alert('내용을 입력 해 주세요');
			return;
		}

		let file = $('#createFileInput').val();
		if (file == '') {
			alert('사진이 없습니다.');
			return;
		}

		let formData = new FormData();
		formData.append('content', content);
		formData.append('file', $('#createFileInput')[0].files[0]);

		$.ajax({
			type: 'POST'
			, url: '/post/post_create'
			, data: formData
			, processData: false
			, contentType: false
			, enctype: 'multipart/form-data'
			, success: function(data) {
				alert(data.result);
				location.href = '/timeline/timeline_view';
			}
			, error: function(e) {
				alert(e);
				alert('메모저장 실패 관리자에게 문의하세요');
			}
		});
	});
	
	//create post view----------------------------------------------------------------------
	
	//follow-modal-view---------------------------------------------------------------------
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
		let feedOwnerId=$('.profile-info-section').data('feed-owner-id');
		
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
							createLikeList(likeData.loginCheck
											,likeData.likeList
											,likeData.followingList);
						}
						,error:function(e){
							alert(e);
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
	
	
	
	//유저 피드에 팔로우하기 버튼 클릭 시 팔로우 진행
	$('.profile-follow-btn').on('click',function(){
		let followId=$(this).data('feed-owner-id');
		$.ajax({
			type:'POST'
			,url:'/follow/do_follow'
			,data:{'followId':followId,
				   'feedOwnerId':followId}
			,success:function(data){
				if(data.result===true){
					location.reload();
				}
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

	//좋아요 목록에서 팔로잉/언팔로우
	$('.like-unit-box').on('click','.like-section-follower-btn',function(){
		//팔로우 취소
		let followId=$(this).data('user-id');
		let postId=$(this).data('post-id');
		
		let userId=$(this).data('like-user-login-id');

		$('.unfollow-userId').text(userId);
		
		$('.delete-user-image').attr('src',$('#likeUserImg'+followId).attr('src'));
		//feedOwnerId
		let feedOwnerId=$('.profile-info-section').data('feed-owner-id');
		
		$('.follow-delete-modal-section').removeClass('d-none');
		
		
		
		$('.delete-btn').data('follow-id',followId);
		$('.delete-btn').data('feed-owner-id',feedOwnerId);
		
		
		$('.delete-btn').data('post-id',postId);
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
								alert(e);
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
	
	//-------------timeLineView---------------------------
	$('.post-item-action-button').on('click', '.timeline-like-after-btn', function() {
		//좋아요 취소
		let postId = $(this).data('post-id');
		let userId = $(this).data('post-user-id');


		$.ajax({
			type: 'POST'
			, url: '/like/set_like/' + postId
			, data: { 'userId': userId }
			, success: function(data) {
				if (data.result === true) {
					//성공 시 새로고침
					location.reload();
				}
			}

		});
	});

	$('.post-item-action-button').on('click', '.timeline-like-before-btn', function() {
		//좋아요 하기
		let postId = $(this).data('post-id');
		let userId = $(this).data('post-user-id');

		$.ajax({
			type: 'POST'
			, url: '/like/set_like/' + postId
			, data: { 'userId': userId }
			, success: function(data) {
				if (data.result === true) {
					//성공 시 새로고침
					location.reload();
				}
			}
		});
	});

	$('.post-item-action-button').on('click', '.timeline-pin-before-btn', function() {
		//게시글 핀하기
		$(this).removeClass('timeline-pin-before-btn');
		$(this).addClass('timeline-pin-after-btn');
		$(this).text('bookmark');

		let postId = $(this).data('post-id');
		$.ajax({
			type: 'POST'
			, url: '/pin/create_pin'
			, data: { 'postId': postId }
			, function(data) {
				if (data.result === true) {
					location.reload();
				}
			}
		});
	});
						
	$('.post-item-action-button').on('click', '.timeline-pin-after-btn', function() {
		//게시글 핀 취소
		let postId = $(this).data('post-id');
		$.ajax({
			type: 'POST'
			, url: '/pin/create_pin'
			, data: { 'postId': postId }
			, function(data) {
				if (data.result === true) {
					location.reload();
				}
			}
		});
	});

	$('.post-item-action-button').on('click', '.timeline-text-focus-btn', function() {
		//말풍선 버튼 클릭시 코멘트 인풋에 포커스
		let postId = $(this).data('post-id');
		$('#timeLineCommentInput' + postId).focus();
	});
						
	//타임라인과 comment modal 연결
	$('.post-comment-view-section').on('focus', '.show-timeline-post-detail', function() {
		$('.comment-modal-section').removeClass('d-none');
		$('body').addClass('no-scrollbar');
		let postId = $(this).data('post-id');
		let userId = $(this).data('user-id');
		let userLoginId = $(this).data('post-user-login-id');
		$('.owner-id').text(userLoginId);

		getCommentModalPost(postId, userId);
	});
						
	$('.btn-box').on('click', '.timeline-comment-submit-btn', function() {
		let postId = $(this).data('post-id');
		let comment = $('#timeLineCommentInput' + postId).val();

		if (comment == '') {
			alert('내용을 입력해 주세요.');
			return;
		}
		
		$.ajax({
			type: 'POST'
			, data: {'postId': postId
					, 'comment': comment
			}
			, url: '/comment/create_comment'
			, success: function(data) {
				if(data.loginCheck===true){
					location.reload();
				}
			}
			, error: function(e) {
				alert(e);
			}
		});

	});
	
	//-----------------detail-view
	
	$('.detail-like-before-btn').on('click', function() {
		let postId = $(this).data('post-id');
		let userId = $(this).data('post-user-id');

		$.ajax({
			type: 'POST'
			, url: '/like/set_like/' + postId
			, data: { 'userId': userId }
			, success: function(data) {
				if (data.result === true) {
					location.reload();
				}
			}
			, error: function(e) {
				alert(e);
			}
		});
	});
	
	$('.detail-like-after-btn').on('click', function() {
		let postId = $(this).data('post-id');
		let userId = $(this).data('post-user-id');

		$.ajax({
			type: 'POST'
			, url: '/like/set_like/' + postId
			, data: { 'userId': userId }
			, success: function(data) {
				if (data.result === true) {
					location.reload();
				}
			}
			, error: function(e) {
				alert(e);
			}
		});
	});
	
	$('.detail-pin-before-btn').on('click', function() {
		let postId = $(this).data('post-id');
		$.ajax({
			type: 'POST'
			, url: '/pin/create_pin'
			, data: { 'postId': postId }
			, success: function(data) {
				if (data.result === true) {
					location.reload();
				}
			}
			, error: function(e) {
				alert(e);
			}

		});

	});
	
	$('.detail-pin-after-btn').on('click', function() {
		let postId = $(this).data('post-id');
		$.ajax({
			type: 'POST'
			, url: '/pin/delete_pin'
			, data: { 'postId': postId }
			, success: function(data) {
				if (data.result === true) {
					location.reload();
				}
			}
			, error: function(e) {
				alert(e);
			}
	
		});
	});
			
	$('.detail-text-focus-btn').on('click', function() {
		$('.detail-comment-form').focus();
	});
	
	$('.detail-comment-submit-btn').on('click', function() {
		let postId = $(this).data('post-id');
		let comment = $('.detail-comment-form').val();
	
		if (comment == '') {
			alert('내용을 입력하세요.');
			return;
		}
	
		$.ajax({
			type: 'POST'
			, url: '/comment/create_comment'
			, data: {
				'postId': postId
				, 'comment': comment
			}
			, success: function(data) {
				if (data.loginCheck === true) {
					location.reload();
				}
			}
			, error: function(e) {
				alert(e);
				alert('실패?')
			}
	
		});
	});
			
	$('.comment-item').on('click', '.detail-comment-menu-btn', function() {
		let commentId = $(this).data('comment-id');
		let postId = $(this).data('post-id');
		$('.detail-comment-description-modal').removeClass('d-none');
		$('.detail-comment-delete-button').data('comment-id', commentId);
		$('.detail-comment-delete-button').data('post-id', postId);
		$('body').addClass('no-scrollbar');

	});

	$('.detail-comment-description-modal').on('click', function(e) {
		if (!$('.menu-modal-box').has(e.target).length) {

			$('.detail-comment-description-modal').addClass('d-none');
			//comment-modal-section에 d-none클래스가 없다면 --보이고있다면
			if ($('.comment-modal-section').hasClass('d-none') === true) {
				$('body').removeClass('no-scrollbar');
			}
		}
	});
			
	$('.detail-comment-delete-button').on('click', function() {
		let commentId = $(this).data('comment-id');
		let postId = $(this).data('post-id');
	
		$.ajax({
			type: 'POST'
			, url: '/comment/delete_comment'
			, data: {
				'commentId': commentId
				, 'postId': postId
			}
			, success: function(data) {
				if (data.loginCheck === true) {
					location.reload();
				}
			}
			, error: function(e) {
				alert(e);
			}
		});
	});
	
	$('.like-link').on('click', function(e) {
		e.preventDefault();
		$('.like-modal-section').removeClass('d-none');
		$('body').addClass('no-scrollbar');
		let postId = $(this).data('post-id');
		$.ajax({
			type: 'GET'
			, url: '/like/get_like_list'
			, data: { 'postId': postId }
			, success: function(data) {
				if (data.loginCheck === true) {
					createLikeList(data.loginCheck, data.likeList, data.followingList);
				} else {
					location.href = '/user/sign_in_view';
				}
			}
			, error: function(e) {
				alert(e);
			}
		});
	});
	
	//-------------------------------gnb
	$('.alert-modal-follow-btn-box').on('click', '.alert-modal-unfollow-btn', function() {
		let sendUserId = $(this).data('send-user-id');
		let sendUserProfileImagePath = $(this).data('send-user-profile-image');
		let sendUserLoginId = $(this).data('send-user-login-id');


		$('.alert-follow-delete-section').removeClass('d-none');
		$('body').addClass('no-scrollbar');

		let profileImagePath = sendUserProfileImagePath == '' ? '/static/images/no_profile_image.png' : sendUserProfileImagePath;

		$('.alert-delete-user-image').attr('src', profileImagePath);
		$('.unfollow-userId').text(sendUserLoginId);


		$('.alert-delete-btn').data('send-user-id', sendUserId);
		$('.alert-delete-btn').data('send-user-profile-image', sendUserProfileImagePath);
		$('.alert-delete-btn').data('send-user-login-id', sendUserLoginId);


	});
								
	$('.alert-delete-btn').on('click', function() {

		let sendUserId = $(this).data('send-user-id');
		let sendUserProfileImagePath = $(this).data('send-user-profile-image');
		let sendUserLoginId = $(this).data('send-user-login-id');

		$.ajax({
			type: 'POST'
			, data: { 'followId': sendUserId }
			, url: '/follow/do_unfollow'
			, success: function(data) {
				if (data.loginCheck === true) {
					$('#alertModalFollowBtnBox' + sendUserId).empty();

					let html = '<button class="alert-modal-follow-btn" data-send-user-id="' + sendUserId
						+ '" data-send-user-profile-image="' + sendUserProfileImagePath
						+ '" data-send-user-login-id="' + sendUserLoginId + '">팔로잉</button>';

					$('#alertModalFollowBtnBox' + sendUserId).append(html);
				}
			}
			, error: function(e) {
				alert(e);
			}
		});

		$('.alert-follow-delete-section').addClass('d-none');
		$('body').removeClass('no-scrollbar');

	});

	$('.alert-modal-follow-btn-box').on('click', '.alert-modal-follow-btn', function() {
		let sendUserId = $(this).data('send-user-id');
		let sendUserProfileImagePath = $(this).data('send-user-profile-image');
		let sendUserLoginId = $(this).data('send-user-login-id');

		$.ajax({
			type: 'POST'
			, data: { 'followId': sendUserId }
			, url: '/follow/do_follow'
			, success: function(data) {
				if (data.loginCheck === true) {
					$('#alertModalFollowBtnBox' + sendUserId).empty();

					let html = '<button class="alert-modal-unfollow-btn"data-send-user-id="' + sendUserId
						+ '" data-send-user-profile-image="' + sendUserProfileImagePath
						+ '" data-send-user-login-id="' + sendUserLoginId + '">팔로잉</button>';

					$('#alertModalFollowBtnBox' + sendUserId).append(html);
				}
			}
			, error: function(e) {
				alert(e);
			}
		});
	});

	$('.alert-cancel-btn').on('click', function() {
		$('.alert-follow-delete-section').addClass('d-none');
		$('body').removeClass('no-scrollbar');
	});

	$('.alert-follow-delete-section').on('click', function(e) {
		if (!$('.alert-follow-delete-box').has(e.target).length) {
			$('.alert-follow-delete-section').addClass('d-none');
			$('body').removeClass('no-scrollbar');
		}
	});
	
	
	//1.타임라인 이모지피커
	$('.post-comment-bar').on('click','.timeline-emoji-picker',function(){
		let postId=$(this).data('post-id');
		let buttonId='#post-emoji-picker'+postId;
		let inputClass="#timeLineCommentInput"+postId;
		//이모지 피커 함수 호출
		setPicker(buttonId,inputClass);
	});
	
	//2.모달창 이모지피커
	$('.item-emoji-picker').on('click',function(){
		let buttonId='#modal-emoji-picker';
		let inputClass=".modal-comment-form";
		//이모지 피커 함수 호출
		setPicker(buttonId,inputClass);
	});
	
	//3.게시물로 이동 페이지 이모지 피커
	$('.detail-emoji-picker').on('click',function(){
		let buttonId='#detail-emoji-picker';
		let inputClass=".detail-comment-form";

		setPicker(buttonId,inputClass);
	});
	//4. 글 올리기 이모지피커
	$('#postCreateEmojiPicker').on('click',function(){
			let buttonId='#postCreateEmojiPicker';
			let inputClass='.create-post-textarea';
			//이모지 피커 함수 호출
			setPicker(buttonId,inputClass);
	});
	
});	