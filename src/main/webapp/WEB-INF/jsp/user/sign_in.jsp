<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<div>
		<div class="sign-in-box">
		
			<div class="sign-in-item-box">
				<img src="/static/images/logo.png" class="logo" width="200px"/>
			</div>
			
			<div class="sign-in-item-box mt-5">
				<input type="text" class="form-control col-10 sign-input" placeholder="전화번호,사용자의 이름 또는 이메일">
			</div>
			
			<div class="sign-in-item-box mt-2">
				<input type="password" class="form-control col-10" placeholder="비밀번호">
			</div>
		
			<div class="sign-in-item-box">
				<button class="mt-4 col-10 sign-btn" onclick="location.href='/post/timeline_view'">로그인</button>
			</div>
			<div class="sign-in-item-box mt-3 text-secondary">
				<div>―――――――</div>
				<div class="mx-3"> 또는 </div>
				<div>―――――――</div>
			</div>
			<div class="sign-in-item-box">
				<a href="#">비밀번호를 잊으셨나요?</a>	
			</div>
			
		</div>
		<div class="more-info">
			<div>계정이 없으신가요? <a href="/user/sign_up_view" class="font-weight-bold text-info">가입하기</a></div>
		</div>
	</div>
