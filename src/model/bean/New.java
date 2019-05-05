package model.bean;

import java.sql.Timestamp;

public class New {
	private int id;
	private User objUser;
	private int view;
	private int isActive;
	private String title;
	private String preview;
	private String detail;
	private String picture;
	private Timestamp dateCreate;
	private Category objCat;

	public New() {
		super();
	}

	public New(int id, User objUser, int view, int isActive, String title, String preview, String detail,
			String picture, Timestamp dateCreate, Category objCat) {
		super();
		this.id = id;
		this.objUser = objUser;
		this.view = view;
		this.isActive = isActive;
		this.title = title;
		this.preview = preview;
		this.detail = detail;
		this.picture = picture;
		this.dateCreate = dateCreate;
		this.objCat = objCat;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public User getObjUser() {
		return objUser;
	}

	public void setObjUser(User objUser) {
		this.objUser = objUser;
	}

	public int getView() {
		return view;
	}

	public void setView(int view) {
		this.view = view;
	}

	public int getIsActive() {
		return isActive;
	}

	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPreview() {
		return preview;
	}

	public void setPreview(String preview) {
		this.preview = preview;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public Timestamp getDateCreate() {
		return dateCreate;
	}

	public void setDateCreate(Timestamp dateCreate) {
		this.dateCreate = dateCreate;
	}

	public Category getObjCat() {
		return objCat;
	}

	public void setObjCat(Category objCat) {
		this.objCat = objCat;
	}

}
