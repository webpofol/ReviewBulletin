function loginCheck() {
	if($(".idCheck").val() == "null") {
		alert("로그인을 먼저 진행해주세요.")
		location.href="Login.jsp"
		return false;
	}
}

$(function() {
	
});