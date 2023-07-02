package ReviewAction;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ReviewModeling.Bulletin;
import ReviewModeling.User;

@Repository
public class ReviewActionService {
	@Autowired
	SqlSession dataProcess;
	
	public User login(String user_id, String user_pass) {
		Map<String, Object> obj = new HashMap<String, Object>();
		obj.put("user_id", user_id);
		obj.put("user_pass", user_pass);
		
		return dataProcess.selectOne("login", obj);
	}
	
	public int boardCount() {
		return dataProcess.selectOne("boardCount");
	}
	
	public List<Bulletin> reviewPrint(int page, int limit) {
		Map<String, Object> obj = new HashMap<String, Object>();
		int startrow=(page-1)*10;
		
		obj.put("startrow", startrow);
		obj.put("limit", limit);
		
		return dataProcess.selectList("reviewPrint", obj);
	}

	public Bulletin reviewSelec(int hNum) {
		return dataProcess.selectOne("reviewSelec", hNum);
	}

	public void reviewInsert(Bulletin bulletin) {
		Map<String, Object> obj = new HashMap<String, Object>();
		obj.put("user_id", bulletin.getUser_id());
		obj.put("post_date", bulletin.getPost_date());
		obj.put("post_title", bulletin.getPost_title());
		obj.put("post_body", bulletin.getPost_body().replace("\r\n","<br/>"));
		obj.put("post_file", bulletin.getPost_file());
		obj.put("post_readcount", bulletin.getPost_readcount());
		obj.put("post_like", bulletin.getPost_like());
		obj.put("post_travel_location", bulletin.getPost_travel_location());
		obj.put("post_rating", bulletin.getPost_rating());
		
		dataProcess.update("reviewInsert", obj);
	}
}
