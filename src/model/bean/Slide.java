package model.bean;

public class Slide {
	private int id;
	private int active;
	private int location;
	private String name;
	private String picture;
	private String link;

	public Slide() {
		super();
	}

	public Slide(int id, int active, int location, String name, String picture, String link) {
		super();
		this.id = id;
		this.active = active;
		this.location = location;
		this.name = name;
		this.picture = picture;
		this.link = link;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getActive() {
		return active;
	}

	public void setActive(int active) {
		this.active = active;
	}

	public int getLocation() {
		return location;
	}

	public void setLocation(int location) {
		this.location = location;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

}
