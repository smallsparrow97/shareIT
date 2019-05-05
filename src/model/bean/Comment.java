package model.bean;

import java.sql.Timestamp;

public class Comment {
	private int id;
	private int parent_id;
	private int is_active;
	private String username;
	private String answer_to;
	private String email;
	private String content;
	private Timestamp time_cmt;
	private New objNew;

	public Comment() {
		super();
	}

	public Comment(int id, int parent_id, int is_active, String username, String answer_to, String email,
			String content, Timestamp time_cmt, New objNew) {
		super();
		this.id = id;
		this.parent_id = parent_id;
		this.is_active = is_active;
		this.username = username;
		this.answer_to = answer_to;
		this.email = email;
		this.content = content;
		this.time_cmt = time_cmt;
		this.objNew = objNew;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getParent_id() {
		return parent_id;
	}

	public void setParent_id(int parent_id) {
		this.parent_id = parent_id;
	}

	public int getIs_active() {
		return is_active;
	}

	public void setIs_active(int is_active) {
		this.is_active = is_active;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getAnswer_to() {
		return answer_to;
	}

	public void setAnswer_to(String answer_to) {
		this.answer_to = answer_to;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Timestamp getTime_cmt() {
		return time_cmt;
	}

	public void setTime_cmt(Timestamp time_cmt) {
		this.time_cmt = time_cmt;
	}

	public New getObjNew() {
		return objNew;
	}

	public void setObjNew(New objNew) {
		this.objNew = objNew;
	}

}
