/**
 * 
 */
 
 
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
		$('.comment-description-modal').addClass('d-none');
		$('body').removeClass('no-scrollbar');
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
	$('#loginId , #loginPassword').on('input',function(e){

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
	
	$('.post-menu-btn').on('focus',function(){
		$('.menu-modal-section').removeClass('d-none');
		$('.detail-info').addClass('d-none');
		$('body').addClass('no-scrollbar');

	});
	
	$('.menu-modal-section').on('click',function(e){
		if(!$('.menu-modal-box').has(e.target).length){
			$('.menu-modal-section').addClass('d-none');
			$('.detail-info').removeClass('d-none');
			//comment-modal-section에 d-none클래스가 없다면 --보이고있다면
			if($('.comment-modal-section').hasClass('d-none')===true){ 
				$('body').removeClass('no-scrollbar');
			}
		}
	});
	
	$('.menu-btn').on('focus',function(){
		$('.comment-description-modal').removeClass('d-none');
		$('body').addClass('no-scrollbar');

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
	
	$('#showDetail').on('focus',function(){
		$('.comment-modal-section').removeClass('d-none');
		$('body').addClass('no-scrollbar');

	});
	
	$('.comment-modal-section').on('click',function(e){
		if(!$('.comment-modal-box').has(e.target).length){
			
			$('.comment-modal-section').addClass('d-none');
			$('.content-simple-info').removeClass('d-none');
			$('body').removeClass('no-scrollbar');
			
		}
	});
	
	$('.action-text-focus-btn').on('click',function(){
		$('.modal-comment-form').focus();
	});
	
	$('.detail-section-focus-btn').on('click',function(){
		$('.detail-comment-form').focus();
	});
	

			
	//1.타임라인 이모지피커
	$('.timeline-emoji-picker').on('click',function(){
		let buttonId='#post-emoji-picker';
		let inputClass=".comment-form";
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
	
});



		