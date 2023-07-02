<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Pofol | Login</title>
	<link rel="stylesheet" type="text/css" href="css/login.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<script type="text/javascript" src="js/login.js"></script>
</head>
<body>
	<section>
		<div id="form_wrap">
			<form name="user_info" method="post">
				<h1>Login</h1>
				<label style="color: slateblue;">SungHeumPofol에 오신걸 환영합니다.</label>
				<input type="text" id="id" name="user_id" class="textfield" placeholder="UserID">
				<input type="password" id="pw" name="user_pass" class="textfield" placeholder="Password">
				<div id="login_stay">
					<input type="checkbox" id="login_check" class="cbox">
					<label style="cursor: pointer;" for="login_check">로그인 상태 유지</label><br>
				</div>
				<button type="button" onclick="check()" id="lbtn" class="custom-btn btn-5">로그인</button>
				<a href=""><p class="sign_up">회원가입</p></a>
				<a href=""><p class="id_search">아이디 찾기</p></a>
				<a href=""><p class="pass_search">비밀번호 찾기</p></a>
			</form>
		</div>
	</section>
</body>
</html>