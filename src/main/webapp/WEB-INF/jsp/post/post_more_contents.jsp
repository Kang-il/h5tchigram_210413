<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<hr class="my-5">
<div class="contents-info"><span>${post.userLoginId}</span>님의 게시물 더 보기</div>
<div class="more-contents-box">
			<%--TODO:::forEach 동적으로--%>
	<c:forEach var="postThumbnail" items="${postThumbnailList}" varStatus="status">
	
		<c:if test="${status.index % 3 eq 0}">
			<div class="more-contents-row">
		</c:if>
		
			<div class="more-contents-unit" onclick='location.href="/post/post_detail_view?postId=${postThumbnail.postId}"'>
				<img src="${postThumbnail.imagePath}" class="post-image">
				<div class="detail-info">
					<span class="material-icons-outlined icon">favorite</span>
					<span class="count">${postThumbnail.likeCount}</span>
					<span class="material-icons icon">chat_bubble</span>
					<span class="count">${postThumbnail.commentCount}</span>
				</div>
			</div>
			
		<c:if test="${status.index % 3 eq 2}">
			</div>
		</c:if>
		
	</c:forEach>	
</div>