package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import model.bean.Slide;
import util.DBConnectionUtil;

public class SlideDAO {
	private Connection conn;
	private Statement st;
	private PreparedStatement pst;
	private ResultSet rs;
	
	public int countItem() {
		int result = 0;
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT COUNT(*) AS count FROM slides";
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

	public ArrayList<Slide> getItemsPagination(int offset, int numberPage) {
		ArrayList<Slide> listItem = new ArrayList<>();
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT * FROM slides LIMIT ?, ? ";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, offset);
			pst.setInt(2, numberPage);
			rs = pst.executeQuery();
			while(rs.next()) {
				Slide objSlide = new Slide(rs.getInt("id"), rs.getInt("active"), rs.getInt("location"), rs.getString("name"), rs.getString("picture"), rs.getString("link"));
				listItem.add(objSlide);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, pst, conn);
		}
		return listItem;
	}
	
	public ArrayList<Slide> getItems() {
		ArrayList<Slide> listItem = new ArrayList<>();
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT * FROM slides WHERE active = 1 ORDER BY location";
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			while(rs.next()) {
				Slide objSlide = new Slide(rs.getInt("id"), rs.getInt("active"), rs.getInt("location"), rs.getString("name"), rs.getString("picture"), rs.getString("link"));
				listItem.add(objSlide);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, st, conn);
		}
		return listItem;
	}

	public void updateActive(int i, int id) {
		conn = DBConnectionUtil.getConnection();
		String sql = "UPDATE slides SET active = ? WHERE id = ?";
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

	public int addItem(Slide item) {
		int result = 0;
		conn = DBConnectionUtil.getConnection();
		String sql = "INSERT INTO slides (name, picture, link) "
				+ "VALUES (?, ?, ?)";
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, item.getName());
			pst.setString(2, item.getPicture());
			pst.setString(3, item.getLink());
			result = pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(pst, conn);
		}
		return result;
	}

	public Slide getItem(int id) {
		Slide objItem = null;
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT * FROM slides WHERE id = ?";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			if (rs.next()) {
				objItem = new Slide(rs.getInt("id"), rs.getInt("active"), rs.getInt("location"), rs.getString("name"), rs.getString("picture"), rs.getString("link"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, pst, conn);
		}
		return objItem;
	}

	public int editItem(Slide item) {
		int result = 0;
		conn = DBConnectionUtil.getConnection();
		String sql = "UPDATE slides SET name = ?, picture = ?, link = ?, location = ? "
				+ "WHERE id = ?";
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, item.getName());
			pst.setString(2, item.getPicture());
			pst.setString(3, item.getLink());
			pst.setInt(4, item.getLocation());
			pst.setInt(5, item.getId());
			result = pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(pst, conn);
		}
		return result;
	}

	public int delItem(int id) {
		int result = 0;
		conn = DBConnectionUtil.getConnection();
		String sql = "DELETE FROM slides WHERE id = ?";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, id);
			result = pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(pst, conn);
		}
		return result;
	}
}
