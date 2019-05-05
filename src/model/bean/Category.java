package model.bean;

public class Category {
	private int catId;
	private int parentId;
	private String catName;
	private String description;
	private String picture;

	public Category() {
		super();
	}

	public Category(int catId, int parentId, String catName, String description, String picture) {
		super();
		this.catId = catId;
		this.parentId = parentId;
		this.catName = catName;
		this.description = description;
		this.picture = picture;
	}

	public int getCatId() {
		return catId;
	}

	public void setCatId(int catId) {
		this.catId = catId;
	}

	public int getParentId() {
		return parentId;
	}

	public void setParentId(int parentId) {
		this.parentId = parentId;
	}

	public String getCatName() {
		return catName;
	}

	public void setCatName(String catName) {
		this.catName = catName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}
}
