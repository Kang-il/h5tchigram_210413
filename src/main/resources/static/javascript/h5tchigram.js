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
	

});



		