package ReviewModeling;

import org.springframework.stereotype.Repository;

public class Bulletin {
	int post_num, post_readcount, post_like;
	String user_id, post_date, post_title, post_body, post_file, post_travel_location;
	double post_rating;
	
	public int getPost_num() {
		return post_num;
	}
	public void setPost_num(int post_num) {
		this.post_num = post_num;
	}
	public int getPost_readcount() {
		return post_readcount;
	}
	public void setPost_readcount(int post_readcount) {
		this.post_readcount = post_readcount;
	}
	public int getPost_like() {
		return post_like;
	}
	public void setPost_like(int post_like) {
		this.post_like = post_like;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getPost_date() {
		return post_date;
	}
	public void setPost_date(String post_date) {
		this.post_date = post_date;
	}
	public String getPost_title() {
		return post_title;
	}
	public void setPost_title(String post_title) {
		this.post_title = post_title;
	}
	public String getPost_body() {
		return post_body;
	}
	public void setPost_body(String post_body) {
		this.post_body = post_body;
	}
	public String getPost_file() {
		return post_file;
	}
	public void setPost_file(String post_file) {
		this.post_file = post_file;
	}
	public String getPost_travel_location() {
		return post_travel_location;
	}
	public void setPost_travel_location(String post_travel_location) {
		this.post_travel_location = post_travel_location;
	}
	public double getPost_rating() {
		return post_rating;
	}
	public void setPost_rating(double post_rating) {
		this.post_rating = post_rating;
	}
}
