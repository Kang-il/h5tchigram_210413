<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="user-info-section" id="userInfoSection">

		<div class="user-info-box">
			<c:if test="${user ne null}">
				<a href="/user/feed/${user.loginId}">
				
					<c:if test="${user.profileImagePath ne null}">
						<img src="${user.profileImagePath}" width="70px" class="user-info-profile">
					</c:if>
					
					<c:if test="${user.profileImagePath eq null}">
						<img src="/static/images/no_profile_image.png" width="70px" class="user-info-profile">
					</c:if>
					
				</a>
				
				<div class="user-info-item">
					<a href="/user/feed/${user.loginId}" class="user-info-id">${user.loginId}</a>
					<p class="user-info-introduce">${user.nickname}</p>	
				</div>
			</c:if>
		</div>
		<footer class="footer  user-info-footer">
			<jsp:include page="../include/footer.jsp"></jsp:include>
		</footer>
		
</div>