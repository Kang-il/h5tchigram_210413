<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"crossorigin="anonymous">
	
<script src="https://cdn.jsdelivr.net/npm/@joeattardi/emoji-button@3.0.3/dist/index.min.js"></script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>        
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp" rel="stylesheet">

<link rel="stylesheet" href="/static/css/style.css?${currentTime}" type="text/css"/>
<script src="/static/javascript/h5tchigram.js?${currentTime}" type="text/javascript"></script>
</head>
<body>

	<jsp:include page="../include/gnb.jsp"/>
	<jsp:include page="../include/modal.jsp"/>
	
	<c:if test="${userView eq'content_detail'}">
		
		<section class="detail-section">
			<section class="content-section">
				<jsp:include page="../post/post_detail.jsp"></jsp:include>
			</section>
				
			<section class="more-contents">
				<jsp:include page="../post/post_more_contents.jsp"/>
			</section>
		</section>
		
	</c:if>
	
	<c:if test="${userView eq 'post_create'}">
	
			<section class="create-post-section">
				<jsp:include page="../post/post_create.jsp"></jsp:include>
			</section>
	</c:if>
		
	<footer class="d-flex justify-content-center">
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</footer>

</body>
</html>