function check() {
	let user_id = document.getElementById("id").value;
	let user_pass = document.getElementById("pw").value;
	
	if(id == "" || pw == "") {
		alert("아이디와 비밀번호 모두 입력해주세요");
		return false;
	} else {
		let logininfo = {user_id: user_id, user_pass: user_pass};
		
		$.ajax({
			url : "loginProcess.pf",
			type : "POST",
			contentType : "application/json",
			dataType : "json",
			data : JSON.stringify(logininfo),
			success : function(data){
				if(data == true){
					alert("로그인 성공");
					location.href = "reviewPrint.pf"
				} else {
					alert("다시 시도해 주세요");
				}
			}
		});
	}
}

$(function() {

});