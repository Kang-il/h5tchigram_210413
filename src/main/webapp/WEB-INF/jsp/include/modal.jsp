<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<%-- 게시글 메뉴창 클릭 시 보이는 모달창 --%>
<div class="menu-modal-section d-none">
	<div class="menu-modal-box">
			<%-- a태그 href는 동적으로 값이 담김 --%>
			<div class="modal-menu-item"><a href="delete" class="delete-link text-danger">삭제</a></div><hr>
			<div class="modal-menu-item"><a href="detail" class="go-to-post-link" >게시물로 이동</a></div><hr>
			<div class="modal-menu-item"><a href="#" >링크복사</a></div><hr>
			<div class="modal-menu-item"><a href="#" >퍼가기</a></div><hr>
			<div class="modal-menu-item cancel-modal" onclick="cancelModal()">취소</div>
	</div>
</div>

<%-- TODO DELETE API 작성 --%>		
<%-- 댓글 메뉴창 클릭 시 보이는 모달창 --%>
<div class="comment-description-modal d-none">
	<div class="menu-modal-box">
			<div class="modal-menu-item"><a class="comment-delete-button text-danger">삭제</a></div><hr>
			<div class="modal-menu-item cancel-modal" onclick="cancelModal()">취소</div>
	</div>
</div>

<div class="like-modal-section d-none">
	<div class="like-modal-box">
			<div class="like-modal-subject"><span>좋아요 목록</span></div>
			
			<div class="like-unit-box">
			<%--동적으로 좋아요 목록이 담기는 공간 --%>
			</div>
	</div>
</div>





<%--글 등록 사진 클릭 시 크게 보여주는 모달창 --%>
<div class="create-post-item-modal-section d-none">
	<div class="create-post-item-modal-box">
		<div class="create-post-zoom-in">
			<span>크게보기</span>
		</div>
		<div class="create-post-zoom-photo">
			<img id="PostingZoomInPhoto">
		</div>
	</div>
</div>


