package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import model.bean.Category;
import model.bean.New;
import model.bean.User;
import util.DBConnectionUtil;

public class NewDAO {
	private Connection conn;
	private Statement st;
	private PreparedStatement pst;
	private ResultSet rs;
	
	public int addItem(New objNew, int userId) {
		int result = 0;
		conn = DBConnectionUtil.getConnection();
		String sql = "INSERT INTO news (cat_id, user_id, title, preview, detail, picture) "
				+ "VALUES (?, ?, ?, ?, ?, ?)";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, objNew.getObjCat().getCatId());
			pst.setInt(2, userId);
			pst.setString(3, objNew.getTitle());
			pst.setString(4, objNew.getPreview());
			pst.setString(5, objNew.getDetail());
			pst.setString(6, objNew.getPicture());
			result = pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(pst, conn);
		}
		return result;
	}
	
	public New getItem(int id) {
		New objItem = null;
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT * FROM news WHERE id = ?";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			if (rs.next()) {
				objItem = new New(rs.getInt("id"), new User(), rs.getInt("view"), 
						rs.getInt("is_active"), rs.getString("title"), rs.getString("preview"), 
						rs.getString("detail"), rs.getString("picture"), rs.getTimestamp("date_create"), 
						new Category(rs.getInt("cat_id"), 0, null, null, null));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, pst, conn);
		}
		return objItem;
	}  
	
	public New getItemPublic(int id) {
		New objItem = null;
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT n.id, cat_id, user_id, title, preview, detail, date_create, " 
				+ "n.picture, view, is_active, c.name, c.parent_id, u.id, u.fullname "
				+ "FROM news AS n "
				+ "INNER JOIN categories AS c ON cat_id = c.id "
				+ "INNER JOIN users AS u ON user_id = u.id "
				+ "WHERE n.id = ? AND is_active = 1";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			if (rs.next()) {
				objItem = new New(rs.getInt("id"), new User(rs.getInt("u.id"), null, null, rs.getString("u.fullname")), rs.getInt("view"), 
						rs.getInt("is_active"), rs.getString("title"), rs.getString("preview"), 
						rs.getString("detail"), rs.getString("picture"), rs.getTimestamp("date_create"), 
						new Category(rs.getInt("cat_id"), rs.getInt("c.parent_id"), rs.getString("c.name"), null, null));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, pst, conn);
		}
		return objItem;
	}  
	
	public int delItem(int sid) {
		int result = 0;
		conn = DBConnectionUtil.getConnection();
		String sql = "DELETE FROM news WHERE id = ?";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, sid);
			result = pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(pst, conn);
		}
		return result;
	}

	public int editItem(New item) {
		int result = 0;
		conn = DBConnectionUtil.getConnection();
		String sql = "UPDATE news SET cat_id = ?, title = ?, preview = ?, detail = ?, "
				+ "picture = ? WHERE id = ?";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, item.getObjCat().getCatId());
			pst.setString(2, item.getTitle());
			pst.setString(3, item.getPreview());
			pst.setString(4, item.getDetail());
			pst.setString(5, item.getPicture());
			pst.setInt(6, item.getId());
			result = pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(pst, conn);
		}
		return result;
	}
	
	public ArrayList<New> getRelatedNew(New objNew) {
		ArrayList<New> listItem = new ArrayList<>();
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT n.id, cat_id, user_id, title, preview, detail, date_create, "
				+ "n.picture, view, is_active, c.id, c.name, c.parent_id, u.id, u.fullname "
				+ "FROM news AS n "
				+ "INNER JOIN users AS u ON user_id = u.id "
				+ "INNER JOIN categories AS c ON cat_id = c.id "
				+ "WHERE cat_id = ? AND n.id <> ? AND is_active = 1 "
				+ "ORDER BY n.id DESC LIMIT 3";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, objNew.getObjCat().getCatId());
			pst.setInt(2, objNew.getId());
			rs = pst.executeQuery();
			while(rs.next()) {
				New news = new New(rs.getInt("n.id"), new User(rs.getInt("u.id"), null, null, rs.getString("u.fullname")), rs.getInt("view"), rs.getInt("is_active"), 
						rs.getString("title"), rs.getString("preview"), rs.getString("detail"), 
						rs.getString("picture"), rs.getTimestamp("date_create"), new Category(rs.getInt("c.id"), rs.getInt("c.parent_id"), rs.getString("c.name"), null, null));
				listItem.add(news);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, pst, conn);
		}
		return listItem;
	}
	
	public void increaseView(int id) {
		conn = DBConnectionUtil.getConnection();
		String sql = "UPDATE news SET view = view + 1 WHERE id = ?";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, id);
			
			pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(pst, conn);
		}
	}

	public int countItemOfUser(int userId) {
		int result = 0;
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT COUNT(*) AS count FROM news WHERE user_id = ?";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, userId);
			rs = pst.executeQuery();
			if (rs.next()) {
				result = rs.getInt("count");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, pst, conn);
		}
		return result;
	}
	
	
	
	public int countItem(int catId) {
		int result = 0;
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT COUNT(*) AS count FROM news AS count "
					+ "INNER JOIN categories AS c ON cat_id = c.id "
					+ "WHERE is_active = 1 AND (cat_id = ? OR c.parent_id = ?) ";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, catId);
			pst.setInt(2, catId);
			rs = pst.executeQuery();
			if (rs.next()) {
				result = rs.getInt("count");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, pst, conn);
		}
		return result;
	}

	public ArrayList<New> getItemsPagination(int offset, int numberPage, int userId) {
		ArrayList<New> listItem = new ArrayList<>();
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT n.id, cat_id, user_id, title, preview, detail, date_create, "
				+ "n.picture, view, is_active, c.name, c.parent_id, u.id, u.fullname "
				+ "FROM news AS n "
				+ "INNER JOIN categories AS c ON cat_id = c.id "
				+ "INNER JOIN users AS u ON user_id = u.id "
				+ "WHERE user_id = ? "
				+ "ORDER BY n.id DESC "
				+ "LIMIT ?, ? ";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, userId);
			pst.setInt(2, offset);
			pst.setInt(3, numberPage);
			rs = pst.executeQuery();
			while(rs.next()) {
				New objNew = new New(rs.getInt("id"), new User(rs.getInt("id"), null, null, rs.getString("fullname")), rs.getInt("view"), 
						rs.getInt("is_active"), rs.getString("title"), rs.getString("preview"), 
						rs.getString("detail"), rs.getString("picture"), rs.getTimestamp("date_create"), 
						new Category(rs.getInt("cat_id"), rs.getInt("parent_id"), rs.getString("name"), null, null));
				listItem.add(objNew);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, pst, conn);
		}
		return listItem;
	}
	
	public ArrayList<New> getLatestItems(int number) {
		ArrayList<New> listItem = new ArrayList<>();
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT n.id, cat_id, user_id, title, preview, detail, date_create, "
				+ "n.picture, view, is_active, c.name, c.parent_id, u.id, u.fullname "
				+ "FROM news AS n "
				+ "INNER JOIN categories AS c ON cat_id = c.id "
				+ "INNER JOIN users AS u ON user_id = u.id "
				+ "WHERE is_active = 1 "
				+ "ORDER BY date_create DESC "
				+ "LIMIT ? ";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, number);
			rs = pst.executeQuery();
			while(rs.next()) {
				New objNew = new New(rs.getInt("id"), new User(rs.getInt("id"), null, null, rs.getString("fullname")), rs.getInt("view"), 
						rs.getInt("is_active"), rs.getString("title"), rs.getString("preview"), 
						rs.getString("detail"), rs.getString("picture"), rs.getTimestamp("date_create"), 
						new Category(rs.getInt("cat_id"), rs.getInt("parent_id"), rs.getString("name"), null, null));
				listItem.add(objNew);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, pst, conn);
		}
		return listItem;
	}
	
	public ArrayList<New> getTopItems(int number) {
		ArrayList<New> listItem = new ArrayList<>();
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT n.id, cat_id, user_id, title, preview, detail, date_create, "
				+ "n.picture, view, is_active, c.name, c.parent_id, u.id, u.fullname "
				+ "FROM news AS n "
				+ "INNER JOIN categories AS c ON cat_id = c.id "
				+ "INNER JOIN users AS u ON user_id = u.id "
				+ "WHERE is_active = 1 "
				+ "ORDER BY view DESC "
				+ "LIMIT ? ";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, number);
			rs = pst.executeQuery();
			while(rs.next()) {
				New objNew = new New(rs.getInt("id"), new User(rs.getInt("id"), null, null, rs.getString("fullname")), rs.getInt("view"), 
						rs.getInt("is_active"), rs.getString("title"), rs.getString("preview"), 
						rs.getString("detail"), rs.getString("picture"), rs.getTimestamp("date_create"), 
						new Category(rs.getInt("cat_id"), rs.getInt("parent_id"), rs.getString("name"), null, null));
				listItem.add(objNew);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, pst, conn);
		}
		return listItem;
	}
	
	public ArrayList<New> getItemsByCatId(int catId, int number) {
		ArrayList<New> listItem = new ArrayList<>();
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT n.id, cat_id, user_id, title, preview, detail, date_create, "
				+ "n.picture, view, is_active, c.name, c.parent_id, u.id, u.fullname "
				+ "FROM news AS n "
				+ "INNER JOIN categories AS c ON cat_id = c.id "
				+ "INNER JOIN users AS u ON user_id = u.id "
				+ "WHERE is_active = 1 AND (cat_id = ? OR c.parent_id = ?) "
				+ "ORDER BY n.id DESC "
				+ "LIMIT ? ";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, catId);
			pst.setInt(2, catId);
			pst.setInt(3, number);
			rs = pst.executeQuery();
			while(rs.next()) {
				New objNew = new New(rs.getInt("id"), new User(rs.getInt("id"), null, null, rs.getString("fullname")), rs.getInt("view"), 
						rs.getInt("is_active"), rs.getString("title"), rs.getString("preview"), 
						rs.getString("detail"), rs.getString("picture"), rs.getTimestamp("date_create"), 
						new Category(rs.getInt("cat_id"), rs.getInt("parent_id"), rs.getString("name"), null, null));
				listItem.add(objNew);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, pst, conn);
		}
		return listItem;
	}
	
	public ArrayList<New> getItemsByCatIdLoadMore(int catId, int offset, int number) {
		ArrayList<New> listItem = new ArrayList<>();
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT n.id, cat_id, user_id, title, preview, detail, date_create, "
				+ "n.picture, view, is_active, c.name, c.parent_id, u.id, u.fullname "
				+ "FROM news AS n "
				+ "INNER JOIN categories AS c ON cat_id = c.id "
				+ "INNER JOIN users AS u ON user_id = u.id "
				+ "WHERE is_active = 1 AND (cat_id = ? OR c.parent_id = ?) "
				+ "ORDER BY n.id DESC "
				+ "LIMIT ?, ? ";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, catId);
			pst.setInt(2, catId);
			pst.setInt(3, offset);
			pst.setInt(4, number);
			rs = pst.executeQuery();
			while(rs.next()) {
				New objNew = new New(rs.getInt("id"), new User(rs.getInt("id"), null, null, rs.getString("fullname")), rs.getInt("view"), 
						rs.getInt("is_active"), rs.getString("title"), rs.getString("preview"), 
						rs.getString("detail"), rs.getString("picture"), rs.getTimestamp("date_create"), 
						new Category(rs.getInt("cat_id"), rs.getInt("parent_id"), rs.getString("name"), null, null));
				listItem.add(objNew);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, pst, conn);
		}
		return listItem;
	}
	
	/*public ArrayList<Song> getItemsPaginationPublic(int offset, int numberPage) {
		ArrayList<Song> listItem = new ArrayList<>();
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT s.id, s.name AS songName, preview_text, detail_text, date_create, "
				+ "picture, counter, cat_id, c.name AS catName, active "
				+ "FROM songs AS s INNER JOIN categories AS c "
				+ "ON cat_id = c.id "
				+ "WHERE active = 1 "
				+ "LIMIT ?, ? ";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, offset);
			pst.setInt(2, numberPage);
			rs = pst.executeQuery();
			while(rs.next()) {
				Song objNew = new Song(rs.getInt("id"), rs.getInt("counter"), rs.getInt("active"), rs.getString("songName"), rs.getString("preview_text"), rs.getString("detail_text"), rs.getTimestamp("date_create"), rs.getString("picture"), new Category(rs.getInt("cat_id"), rs.getString("catName")));
				listItem.add(objNew);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, pst, conn);
		}
		return listItem;
	}*/

	public ArrayList<New> getItemByIdPagination(int offset, int numberOfPage, int catId) {
		ArrayList<New> listItem = new ArrayList<>();
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT n.id, cat_id, user_id, title, preview, detail, date_create, "
				+ "n.picture, view, is_active, c.name, c.parent_id, u.id, u.fullname "
				+ "FROM news AS n "
				+ "INNER JOIN categories AS c ON cat_id = c.id "
				+ "INNER JOIN users AS u ON user_id = u.id "
				+ "WHERE is_active = 1 AND (cat_id = ? OR c.parent_id = ?) "
				+ "ORDER BY n.id DESC "
				+ "LIMIT ?, ? ";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, catId);
			pst.setInt(2, catId);
			pst.setInt(3, offset);
			pst.setInt(4, numberOfPage);
			rs = pst.executeQuery();
			while(rs.next()) {
				New objNew = new New(rs.getInt("id"), new User(rs.getInt("id"), null, null, rs.getString("fullname")), rs.getInt("view"), 
						rs.getInt("is_active"), rs.getString("title"), rs.getString("preview"), 
						rs.getString("detail"), rs.getString("picture"), rs.getTimestamp("date_create"), 
						new Category(rs.getInt("cat_id"), rs.getInt("parent_id"), rs.getString("name"), null, null));
				listItem.add(objNew);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, pst, conn);
		}
		return listItem;
	}

	/*public ArrayList<Song> search(String textSearch) {
		ArrayList<Song> listItem = new ArrayList<>();
		conn = DBConnectionUtil.getConnection();
		//String text = textSearch.toUpperCase();
		//String sql = "SELECT * FROM songs WHERE name LIKE ?";
		String sql = "SELECT s.id, s.name AS songName, preview_text, detail_text, date_create, "
				+ "picture, counter, cat_id, c.name AS catName, active "
				+ "FROM songs AS s INNER JOIN categories AS c "
				+ "ON cat_id = c.id "
				+ "WHERE s.name LIKE ? AND active = 1";
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, "%" + textSearch + "%");
			rs = pst.executeQuery();
			while (rs.next()) {
				Song objNew = new Song(rs.getInt("id"), rs.getInt("counter"), rs.getInt("active"), rs.getString("songName"), rs.getString("preview_text"), rs.getString("detail_text"), rs.getTimestamp("date_create"), rs.getString("picture"), new Category(rs.getInt("cat_id"), rs.getString("catName")));
				listItem.add(objNew);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, pst, conn);
		}
		return listItem;
	}*/

	public void updateActive(int i, int id) {
		conn = DBConnectionUtil.getConnection();
		String sql = "UPDATE news SET is_active = ? WHERE id = ?";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, i);
			pst.setInt(2, id);
			pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(pst, conn);
		}
	}

	

}
