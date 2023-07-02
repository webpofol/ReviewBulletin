<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/review_content.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="js/review_content.js"></script>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<meta charset="UTF-8">
<title>Pofol | Review Content</title>
</head>
	<!-- 세션 정보 ID확인 -->
	<c:set var="id" value="${sessionScope.userid}"/>
	<!-- 날짜 데이터 포맷 변환 -->
	<fmt:parseDate value="${reviewContent.post_date}" var="dateValue" pattern="yyyy-MM-dd"/>
	<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd" var="reviewDate"/>
	<!-- 줄바꿈 처리 저장-->
	<% pageContext.setAttribute("newLineChar", "\n"); %>
<body>	
	<div class="contentWrap">
		<div class="contentTitle"><c:out value="${reviewContent.post_title}"/></div>
		<div class="reviewInfoWrap">
			<div class="reviewInfo">
				<div><img class="readCountIcon" src="image/user_data.png">&nbsp<c:out value="${reviewContent.post_readcount}"></c:out></div>
				<div><img class="writerIcon" src="image/writer_icon.png">&nbsp<c:out value="${reviewContent.user_id}"></c:out></div>
				<div><img class="writerDateIcon" src="image/write_date.png">&nbsp<c:out value="${reviewDate}"></c:out></div>
			</div>
		</div>
		<div class="reviewTextWrap">
			${fn:replace(reviewContent.post_body, newLineChar, "<br/>")}
		</div>
		<c:if test="${reviewContent.post_file != ''}">
			<section class="section slider-section">
			  <div class="container slider-column">
			    <div class="swiper swiper-slider">
			      <div class="swiper-wrapper">
			        <c:forEach var="image" items="${fn:split(reviewContent.post_file, ',')}">
					  <div class="swiper-slide"><img src="http://localhost:8081/ReviewBulletin/review_image/${image}"></div>
					</c:forEach>
			      </div>
			      <span class="swiper-button-prev"></span>
			      <span class="swiper-button-next"></span>
			      <div class="swiper-pagination" style="position: static"></div>
			    </div>
			  </div>
			</section>
		</c:if>
	</div>
</body>
<script>
const swiper = new Swiper(".swiper-slider", {
	  // Optional parameters
	  centeredSlides: true,
	  slidesPerView: 1.9,
	  spaceBetween: 20,
	  grabCursor: true,
	  freeMode: false,
	  loop: false,
	  mousewheel: false,
	  keyboard: {
	    enabled: true
	  },
	  pagination: { // 호출(pager) 여부
        el: ".swiper-pagination", //버튼을 담을 태그 설정
        clickable: true, // 버튼 클릭 여부
      },
	  // If we need navigation
	  navigation: {
	    nextEl: ".swiper-button-next",
	    prevEl: ".swiper-button-prev"
	  },
	});

</script>
</html>