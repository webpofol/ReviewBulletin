function check() {
	var titleStr = $(".content_title").val()
	var seconStr = $(".secon_text").val()
	var content = $(".txt").val();
	
	if(titleStr ==  "" || seconStr == "" || content == "") {
		alert("모든 항목에 내용을 입력해주세요");
		return false;
	}
	if($("input:radio[name=post_rating]").is(":checked")) {
			
	} else {
		alert("평점을 체크해주세요")
		return false;
	}
}

function delImage(index){
	const dataTransfer = new DataTransfer();

  	var title = $('#preview li').eq(index).find('.thumbNail').prop('title') + ",";
	var value = $(".upload-name").val()
	$(".upload-name").val(value.replace(title, ""))
	$('#preview li').eq(index).remove();
	$('#preview li').each(function(index) {
	    $(this).find('.delBtn').attr('onclick', 'delImage(' + index + ')');
	});
	
	let files = $('#file')[0].files;	//사용자가 입력한 파일을 변수에 할당
    let fileArray = Array.from(files);	//변수에 할당된 파일을 배열로 변환(FileList -> Array)
    
    fileArray.splice(index, 1);	//해당하는 index의 파일을 배열에서 제거
    
    fileArray.forEach(file => { dataTransfer.items.add(file); });
    //남은 배열을 dataTransfer로 처리(Array -> FileList)
    
    $('#file')[0].files = dataTransfer.files;
}


$(function(){
	$(document).ready(function (e){
		$("input[type='file']").change(function(e){
			var fileInput = document.getElementById("file");
			var files = fileInput.files;
			var str = "";
			for(var i=0; i<files.length; i++) {
				str += files[i].name + ","
				if(i==5) {
					alert("이미지 사진은 총 5장까지만 등록가능합니다.")
					return false;
				}
			}
			$(".upload-name").val(str.replace(/undefined/g, ""))

			//div 내용 비워주기
			$('#preview').empty();
	
			var files = e.target.files;
			var arr = Array.prototype.slice.call(files);
	      
			//업로드 가능 파일인지 체크
			for(var i=0;i<files.length;i++){
				if(!checkExtension(files[i].name,files[i].size)){
				return false;
				}
			}
			preview(arr);
	    });
	    
    function checkExtension(fileName,fileSize){
		var reg = /(.*?)\.(jpg|jpeg|png|gif|bmp)$/;
    	var maxSize = 20971520;  //20MB
      
		if(fileSize >= maxSize){
			alert('파일 사이즈 초과');
			$("input[type='file']").val("");  //파일 초기화
			$(".upload-name").val("");
			return false;
			}
      
		if(!fileName.match(reg)){
			alert('업로드 불가능한 파일이 있습니다.');
			$("input[type='file']").val("");  //파일 초기화
			$(".upload-name").val("");
        	return false;
      		}
      		return true;
    	}
    
    function preview(arr){
      arr.forEach(function(f, index){
        //파일명이 길면 파일명...으로 처리
        var fileName = f.name;
        if(fileName.length > 25){
          fileName = fileName.substring(0,20)+"...";
        }
        
        //div에 이미지 추가
        var str = "";
        //이미지 파일 미리보기
        if(f.type.match('image.*')){
          var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
          reader.onload = function (e) { //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
          	str += '<li><div style="padding: 15px;">'
            str += '<img src="image/close_icon.png" class="delBtn" id="delBtn" onclick="delImage('+index+')"><br>';
            str += '<img src="'+e.target.result+'" class="thumbNail" title="'+f.name+'" width=180 height=140 />';
            str += '<div><span>'+fileName+'</span><br></div></div></li>';
            $(str).appendTo('#preview');
          }
          console.log(f)
          reader.readAsDataURL(f);
        }else{
          str += '<img src="/resources/img/fileImg.png" title="'+f.name+'" width=100 height=100 />';
          $(str).appendTo('#preview');
        }
      });
    }
  });
 });