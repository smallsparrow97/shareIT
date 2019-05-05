package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import model.bean.Category;
import util.DBConnectionUtil;

public class CatDAO {
	private Connection conn;
	private Statement st;
	private PreparedStatement pst;
	private ResultSet rs;

	public ArrayList<Category> getChildCat(int parentId) {
		ArrayList<Category> listItem = new ArrayList<>();
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT * FROM categories WHERE parent_id = ?";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, parentId);
			rs = pst.executeQuery();
			while (rs.next()) {
				Category objItem = new Category(rs.getInt("id"), rs.getInt("parent_id"), rs.getString("name"), rs.getString("description"), rs.getString("picture"));
				listItem.add(objItem);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, pst, conn);
		}
		return listItem;
	}
	public ArrayList<Category> getParentItems() {
		ArrayList<Category> listItem = new ArrayList<>();
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT * FROM categories WHERE parent_id = 0";
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			while (rs.next()) {
				Category objItem = new Category(rs.getInt("id"), rs.getInt("parent_id"), rs.getString("name"), rs.getString("description"), rs.getString("picture"));
				listItem.add(objItem);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, pst, conn);
		}
		return listItem;
	}

	public int addItem(Category objCat) {
		int result = 0;
		conn = DBConnectionUtil.getConnection();
		String sql = "INSERT INTO categories (name, description, picture, parent_id) VALUES (?, ?, ?, ?)";
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, objCat.getCatName());
			pst.setString(2, objCat.getDescription());
			pst.setString(3, objCat.getPicture());
			pst.setInt(4, objCat.getParentId());
			result = pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(pst, conn);
		}
		return result;
	}

	public Category getItemById(int id) {
		Category objItem = null;
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT * FROM categories WHERE id = ?";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			if (rs.next()) {
				objItem = new Category(rs.getInt("id"), rs.getInt("parent_id"), rs.getString("name"), rs.getString("description"), rs.getString("picture"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, pst, conn);
		}
		return objItem;
	}

	public int editItem(Category objCat) {
		int result = 0;
		conn = DBConnectionUtil.getConnection();
		String sql = "UPDATE categories SET name = ?, description = ?, picture = ? WHERE id = ?";
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, objCat.getCatName());
			pst.setString(2, objCat.getDescription());
			pst.setString(3, objCat.getPicture());
			pst.setInt(4, objCat.getCatId());
			result = pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(pst, conn);
		}
		return result;
	}
	
	public int editChildItem(Category objCat) {
		int result = 0;
		conn = DBConnectionUtil.getConnection();
		String sql = "UPDATE categories SET name = ?, parent_id = ? WHERE id = ?";
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, objCat.getCatName());
			pst.setInt(2, objCat.getParentId());
			pst.setInt(3, objCat.getCatId());
			result = pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(pst, conn);
		}
		return result;
	}

	public int delItem(int cid) {
		int result = 0;
		conn = DBConnectionUtil.getConnection();
		String sql = "DELETE FROM categories WHERE id = ?";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, cid);
			result = pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(pst, conn);
		}
		return result;
	}
	
	public int countItem() {
		int result = 0;
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT COUNT(*) AS count FROM categories";
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
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
	
	public int countParentCat() {
		int result = 0;
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT COUNT(*) AS count FROM categories WHERE parent_id = 0";
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
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
	
	public ArrayList<Category> getItems() {
		ArrayList<Category> listItem = new ArrayList<>();
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT * FROM categories";
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			while (rs.next()) {
				Category objItem = new Category(rs.getInt("id"), rs.getInt("parent_id"), rs.getString("name"), rs.getString("description"), rs.getString("picture"));
				listItem.add(objItem);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, pst, conn);
		}
		return listItem;
	}
}
