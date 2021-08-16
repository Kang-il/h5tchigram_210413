<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<div class="sign-up-box">
		<div class="sign-up-item-box">
			<img src="/static/images/logo.png" class="logo" width="200px" />
		</div>
		<div class="sign-up-description">친구들의 사진과 동영상을 보려면<br> 가입하세요</div>
	
		<div class="sign-up-item-box mt-3 text-secondary">
			<div>――――――――</div>
			<div class="mx-3">가입정보</div>
			<div>――――――――</div>
		</div>
	
		<div class="sign-up-item-box mt-4">
			<input type="text" class="form-control col-10 sign-input" id="signUpId" placeholder="전화번호,사용자의 이름 또는 이메일">
		</div>
		
		<div class="d-none" id="duplicationAlert">
			<span class="validation-text">중복되는 아이디 입니다.</span>
		</div>
		
		<div class="d-none" id="notEnterIdAlert">
			<span class="validation-text">아이디를 입력해 주세요.</span>
		</div>
		
		<div class="d-none" id="idLengthAlert">
			<span class="validation-text">아이디가 너무 짧습니다.(4자 이상)</span>
		</div>
		
		<div class="sign-up-item-box mt-2">
			<input type="text" class="form-control col-10 sign-input" id="signUpName" placeholder="성명">
		</div>
		<div class="sign-up-item-box mt-2">
			<input type="text" class="form-control col-10 sign-input" id="signUpNickname" placeholder="닉네임">
		</div>
		<div class="sign-up-item-box mt-2">
			<input type="password" class="form-control col-10 sign-input" id="signUpPassword" placeholder="비밀번호">
		</div>
		
		<div class="justify-content-center d-none" id="passwordValidationCheck">
			<span class="validation-text text-center  ml-0">비밀번호는 6-20자리로 문자,숫자,특수문자를 <br>최소 한 개 이상씩 포함해야 합니다.</span>
		</div>
		
		<div class="sign-up-item-box">
			<button type="button" class="mt-4 col-10 sign-btn" id=signUpBtn disabled>가입</button>
		</div>
		
	</div>
	<div class="more-info">
			<div>계정이 있으신가요? <a href="/user/sign_in_view" class="font-weight-bold text-info">로그인</a></div>
	</div>
</div>
