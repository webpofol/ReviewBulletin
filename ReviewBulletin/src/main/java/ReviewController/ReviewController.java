package ReviewController;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ReviewModeling.Bulletin;
import ReviewModeling.PageInfo;
import ReviewModeling.User;
import ReviewServiceProcess.ReviewService;

@Controller
public class ReviewController {
	@Autowired ReviewService service;
	
	@RequestMapping(value="loginProcess.pf", method=RequestMethod.POST, consumes = "application/json")
    @ResponseBody
	public boolean login(@RequestBody User user, HttpServletRequest request) {
		User obj = service.login(user.getUser_id(), user.getUser_pass());
		if(obj == null) {
			return false;
		}
		else {
			HttpSession session = request.getSession();
			session.setAttribute("userid", obj.getUser_id());
			return true;
		}
	}
	
	@RequestMapping(value="reviewPrint.pf")
	public String reviewPrint(HttpServletRequest request, Model model) {
		List<Bulletin> reviewList = null; 
		int page=1;
		int limit=10;
		
		if(request.getParameter("page")!=null){
			page=Integer.parseInt(request.getParameter("page"));
		}
		int listCount = service.boardCount();
		reviewList = service.reviewPrint(page, limit);
		
		int maxPage=(int)((double)listCount/limit+0.95); 
   		int startPage = (((int) ((double)page / 10 + 0.9)) - 1) * 10 + 1;
   	    int endPage = startPage+10-1;

   		if (endPage> maxPage) endPage= maxPage;

   		PageInfo pageInfo = new PageInfo();
   		pageInfo.setEndPage(endPage);
   		pageInfo.setListCount(listCount);
		pageInfo.setMaxPage(maxPage);
		pageInfo.setPage(page);
		pageInfo.setStartPage(startPage);	
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("array", reviewList);
		
		return "ReviewBulletinMain.jsp";
	}
	@RequestMapping(value="reviewSelec.pf")
	public String reviewSelec(HttpServletRequest request, Model model) {
		model.addAttribute("page", Integer.parseInt(request.getParameter("page")));
		model.addAttribute("reviewContent", service.reviewSelec(Integer.parseInt(request.getParameter("bNum"))));
		
		return "ReviewContentPage.jsp";
	}
	
	@RequestMapping(value="reviewInsert.pf", method=RequestMethod.POST)
	public String reviewInsert(MultipartHttpServletRequest mtfRequest, 
			HttpServletRequest request, Bulletin bulletin, 
			@RequestParam(value = "file", defaultValue = "", required = false) MultipartFile uploadFile) {
		String imgData = "";
		List<MultipartFile> imgFileList = mtfRequest.getFiles("file");
		String saveDir = request.getRealPath("/review_image");
	    //System.out.println("파일의 갯수:"+imgFileList.size());
	    InputStream inputStream = null; 
	    OutputStream outputStream = null;
	    
	    //다수개의 파일을 업로드하는 경우 처리하는 예
	    for(int i=imgFileList.size()-1; i>=0; i--) {
	    	MultipartFile file = imgFileList.get(i);
	    	// 파일의 내용이 비어 있는 경우에는 리스트에서 삭제한다
	    	if(file.getSize()==0) {
	    		imgFileList.remove(i);
	    		continue;
	    	}
	    	
		    String fileName = file.getOriginalFilename();
		    String ext = fileName.substring(fileName.lastIndexOf(".")); // 이미지 확장명 자르기
			UUID uuid = UUID.randomUUID();
			String name = uuid + ext;
			imgData += uuid + ext + ",";
			
			bulletin.setPost_file(imgData.substring(0, imgData.length()-1));
			bulletin.setUser_id(request.getParameter("user_id"));
			bulletin.setPost_title(request.getParameter("post_title"));
			bulletin.setPost_rating(Double.parseDouble(request.getParameter("post_rating")));
			bulletin.setPost_body(request.getParameter("post_body"));
			bulletin.setPost_travel_location(request.getParameter("post_travel_location"));
			bulletin.setPost_like(0);
			bulletin.setPost_date("now()");
			bulletin.setPost_readcount(0);
			
		    try { 
		        inputStream = file.getInputStream(); 
		   
		        File newFile = new File(saveDir + "/" + name);
		        if (!newFile.exists()) { 
		            newFile.createNewFile(); 
		        } 
		        outputStream = new FileOutputStream(newFile); 
		        int read = 0; 
		        byte[] bytes = new byte[1024]; 
		   
		        while ((read = inputStream.read(bytes)) != -1) { 
		            outputStream.write(bytes, 0, read); 
		        } 
		    } catch (IOException e) { 
		        e.printStackTrace(); 
		    } finally {
		        try {
		            if(inputStream!=null) inputStream.close();
		            if(outputStream!=null) outputStream.close();
		        } catch (IOException e) {
		            e.printStackTrace();
		        }
		    }
	    }
        service.reviewInsert(bulletin);
        return "redirect:/reviewPrint.pf";
	}
}
