<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pofol | Write</title>
<link rel="stylesheet" type="text/css" href="css/review_write.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="js/review_write.js"></script>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String id = (String) session.getAttribute("userid");
		int nowPage = Integer.parseInt(request.getParameter("page"));
	%>
	<section>
		<div id="big_title"><h1 style="font-family: 'Lobster', cursive;">Review Write</h1></div>
		<div class="form_wrap">
			<form action="reviewInsert.pf" id="myform" onsubmit="return check()" method="post" enctype="multipart/form-data">
				<div class="title_wrap"><input type="text" class="content_title" name="post_title" placeholder="제목을 입력해주세요"></div>
				<div class="secon_wrap" style="margin-top: 10px;">
				<input type="hidden" name="page" value="<%= nowPage%>">
					<div class="avgscore_wrap">평점
					<fieldset class="avgscore">
						<input type="radio" name="post_rating" value="5" id="rate1"><label
							for="rate1">★</label>
						<input type="radio" name="post_rating" value="4" id="rate2"><label
							for="rate2">★</label>
						<input type="radio" name="post_rating" value="3" id="rate3"><label
							for="rate3">★</label>
						<input type="radio" name="post_rating" value="2" id="rate4"><label
							for="rate4">★</label>
						<input type="radio" name="post_rating" value="1" id="rate5"><label
							for="rate5">★</label>
					</fieldset>
					</div>
					<div>작성자<input type="text" class="id_text" value= "<%= id%>" name="user_id" readonly></div>
					<div>숙소명<input type="text" class="location_text" name="post_travel_location" placeholder="여행지를 입력해주세요"></div>
				</div>
				<div style="display: flex; justify-content: center;">
					<textarea class="txt" name="post_body" placeholder="소중한 리뷰를 작성해 주세요."></textarea>
				</div>
				<div id="input_file_wrap">
					<div class="filebox">
					    <input type="text" class="upload-name" name="post_file" readonly placeholder="첨부파일">
					    <label for="file">파일찾기</label><input type="file" id="file" name="file" multiple accept="image/*">
					</div>
				</div>
				<div id="preview"></div>
				<div id="sucess_bt">
					<button type="button" class="custom-btn btn-5" onclick="location.href='reviewPrint.pf?page=<%= nowPage%>'">목 록</button>
					<button type="submit" class="custom-btn btn-5">완 료</button>
				</div>
			</form>
		</div>
	</section>
</body>
</html>