package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import model.bean.Category;
import model.bean.Comment;
import model.bean.New;
import model.bean.User;
import util.DBConnectionUtil;
import util.DefineUtil;

public class CommentDAO {
	private Connection conn;
	private Statement st;
	private PreparedStatement pst;
	private ResultSet rs;
	
	public int addCmt(Comment objCmt) {
		int result = 0;
		conn = DBConnectionUtil.getConnection();
		String sql = "INSERT INTO comments (new_id, parent_id, user_name, answer_to, email, content) VALUES (?, ?, ?, ?, ?, ?)";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, objCmt.getObjNew().getId());
			pst.setInt(2, objCmt.getParent_id());
			pst.setString(3, objCmt.getUsername());
			pst.setString(4, objCmt.getAnswer_to());
			pst.setString(5, objCmt.getEmail());
			pst.setString(6, objCmt.getContent());
			result = pst.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(pst, conn);
		}
		return result;
	}

	public Comment getLastItem(int nid) {
		Comment cmt = null;
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT * FROM comments WHERE new_id = ? ORDER BY id DESC LIMIT 1";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, nid);
			rs = pst.executeQuery();
			if (rs.next()) {
				cmt = new Comment(rs.getInt("id"), rs.getInt("parent_id"), rs.getInt("is_active"), 
						rs.getString("user_name"), rs.getString("answer_to"), rs.getString("email"), rs.getString("content"), rs.getTimestamp("time_cmt"), new New());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(pst, conn);
		}
		return cmt;
	}
	
	public Comment getLastChildItem(int parentId) {
		Comment cmt = null;
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT * FROM comments WHERE parent_id = ? ORDER BY id DESC LIMIT 1";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, parentId);
			rs = pst.executeQuery();
			if (rs.next()) {
				cmt = new Comment(rs.getInt("id"), rs.getInt("parent_id"), rs.getInt("is_active"), 
						rs.getString("user_name"), rs.getString("answer_to"), rs.getString("email"), rs.getString("content"), rs.getTimestamp("time_cmt"), new New());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(pst, conn);
		}
		return cmt;
	}

	public ArrayList<Comment> getParentItems(int id, int number) {
		ArrayList<Comment> listCmt = new ArrayList<>();
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT * FROM comments WHERE new_id = ? AND parent_id = 0 AND is_active = 1 "
				+ "ORDER BY id DESC "
				+ "LIMIT ?";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, id);
			pst.setInt(2, number);
			rs = pst.executeQuery();
			while (rs.next()) {
				Comment cmt = new Comment(rs.getInt("id"), rs.getInt("parent_id"), rs.getInt("is_active"), 
						rs.getString("user_name"), rs.getString("answer_to"), rs.getString("email"), rs.getString("content"), rs.getTimestamp("time_cmt"), new New());
				listCmt.add(cmt);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, pst, conn);
		}
		return listCmt;
	}
	
	public ArrayList<Comment> getParentLoadAllItems(int id, int offset) {
		ArrayList<Comment> listCmt = new ArrayList<>();
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT * FROM comments WHERE new_id = ? AND parent_id = 0 AND is_active = 1 "
				+ "ORDER BY id DESC "
				+ "LIMIT ?, 10000";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, id);
			pst.setInt(2, offset);
			rs = pst.executeQuery();
			while (rs.next()) {
				Comment cmt = new Comment(rs.getInt("id"), rs.getInt("parent_id"), rs.getInt("is_active"), 
						rs.getString("user_name"), rs.getString("answer_to"), rs.getString("email"), rs.getString("content"), rs.getTimestamp("time_cmt"), new New());
				listCmt.add(cmt);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, pst, conn);
		}
		return listCmt;
	}
	
	public ArrayList<Comment> getChildItems(int id) {
		ArrayList<Comment> listCmt = new ArrayList<>();
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT * FROM comments WHERE parent_id = ? AND is_active = 1 LIMIT ?";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, id);
			pst.setInt(2, DefineUtil.NUMBER_CHILD_COMMENT_SHOW);
			rs = pst.executeQuery();
			while (rs.next()) {
				Comment cmt = new Comment(rs.getInt("id"), rs.getInt("parent_id"), rs.getInt("is_active"), 
						rs.getString("user_name"), rs.getString("answer_to"), rs.getString("email"), rs.getString("content"), rs.getTimestamp("time_cmt"), new New());
				listCmt.add(cmt);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, pst, conn);
		}
		return listCmt;
	}
	
	public ArrayList<Comment> getChildLoadAllItems(int parentId, int offset) {
		ArrayList<Comment> listCmt = new ArrayList<>();
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT * FROM comments WHERE parent_id = ? AND is_active = 1 LIMIT ?, 10000";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, parentId);
			pst.setInt(2, offset);
			rs = pst.executeQuery();
			while (rs.next()) {
				Comment cmt = new Comment(rs.getInt("id"), rs.getInt("parent_id"), rs.getInt("is_active"), 
						rs.getString("user_name"), rs.getString("answer_to"), rs.getString("email"), rs.getString("content"), rs.getTimestamp("time_cmt"), new New());
				listCmt.add(cmt);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, pst, conn);
		}
		return listCmt;
	}
	
	public int countCmtAdmin() {
		int result = 0;
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT COUNT(*) AS count FROM comments";
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
	
	public int countCmtOfNews(int id) {
		int result = 0;
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT COUNT(*) AS count FROM comments WHERE new_id = ? AND is_active = 1";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, id);
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
	
	public int countParentCmtOfNews(int id) {
		int result = 0;
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT COUNT(*) AS count FROM comments WHERE new_id = ? AND parent_id = 0 AND is_active = 1";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, id);
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
	
	public int countChildCmt(int parentId) {
		int result = 0;
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT COUNT(*) AS count FROM comments WHERE parent_id = ? AND is_active = 1";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, parentId);
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

	public ArrayList<Comment> getItemsPagination(int offset, int numberPage) {
		ArrayList<Comment> listItem = new ArrayList<>();
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT c.id, new_id, parent_id, user_name, answer_to, email, content, time_cmt, c.is_active, n.id, n.title "
				+ "FROM comments AS c "
				+ "INNER JOIN news AS n ON new_id = n.id "
				+ "ORDER BY c.id DESC "
				+ "LIMIT ?, ? ";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, offset);
			pst.setInt(2, numberPage);
			rs = pst.executeQuery();
			while(rs.next()) {
				Comment objCmt = new Comment(rs.getInt("c.id"), rs.getInt("parent_id"), rs.getInt("c.is_active"), 
						rs.getString("user_name"), rs.getString("answer_to"), rs.getString("email"), rs.getString("content"), rs.getTimestamp("time_cmt"), 
						new New(rs.getInt("n.id"), new User(), 0, 0, rs.getString("title"), "", "", "", null, new Category()));
				listItem.add(objCmt);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, pst, conn);
		}
		return listItem;
	}

	public void updateActive(int i, int id) {
		conn = DBConnectionUtil.getConnection();
		String sql = "UPDATE comments SET is_active = ? WHERE id = ? OR parent_id = ?";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, i);
			pst.setInt(2, id);
			pst.setInt(3, id);
			pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(pst, conn);
		}
	}
	
	public Comment getCmtById(int id) {
		Comment cmt = null;
		conn = DBConnectionUtil.getConnection();
		String sql = "SELECT * FROM comments WHERE id = ? AND is_active = 1";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			if (rs.next()) {
				cmt = new Comment(rs.getInt("id"), rs.getInt("parent_id"), rs.getInt("is_active"), 
						rs.getString("user_name"), rs.getString("answer_to"), rs.getString("email"), 
						rs.getString("content"), rs.getTimestamp("time_cmt"), new New(rs.getInt("new_id"), new User(), 0, 0, "", "", "", "", null, new Category()));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(pst, conn);
		}
		return cmt;
	}
	
}
