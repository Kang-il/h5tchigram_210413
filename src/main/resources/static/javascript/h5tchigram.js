/**
 * 
 */
 

	$(document).ready(function(){
		
		//signUp --- 값이 모두 입력되어야 회원가입 버튼 활성화
		$('div').on('change keyup paste','.sign-input',function(){
			
			$('#notEnterIdAlert').addClass('d-none');
			$('#duplicationAlert').addClass('d-none');
			$('#idLengthAlert').addClass('d-none');
			
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
		
		//Validation Check
		$('#signUpBtn').on('click',function(e){
			e.preventDefault();
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
			
			//1.아이디 중복 체크
			$.ajax({
				type:'GET'
				,data:{'signUpId':signUpId}
				,url:'/user/is_duplication_id'
				,success: function(data){
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
							,error: function(e){
								alert(e);
							}
						});
						
					}
				}
				,error: function(e){
					alert(e);
				}
			});
			
		});

	});



		