package ReviewServiceProcess;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ReviewAction.ReviewActionService;
import ReviewModeling.Bulletin;
import ReviewModeling.User;

@Service
public class ReviewService {
	@Autowired ReviewActionService action;
	
	public User login(String user_id, String user_pass) {
		return action.login(user_id, user_pass);
	}
	
	public int boardCount() {
		return action.boardCount();
	}
	
	public List<Bulletin> reviewPrint(int page, int limit) {
		return action.reviewPrint(page, limit);
	}

	public Bulletin reviewSelec(int hNum) {
		return action.reviewSelec(hNum);
	}

	public void reviewInsert(Bulletin bulletin) {
		action.reviewInsert(bulletin);
	}
}
