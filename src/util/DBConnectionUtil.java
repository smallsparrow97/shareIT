package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class DBConnectionUtil {
	private static Connection conn;
	private static String url;
	private static String user;
	private static String password;
	
	public static Connection getConnection() {
		try {
			// nạp driver
			Class.forName("com.mysql.jdbc.Driver");
			Properties properties = PropertiesUtil.readProperties();
			url = properties.getProperty("url");
			user = properties.getProperty("user");
			password = properties.getProperty("password");
			// tạo chuỗi kết nối Connection
			conn = DriverManager.getConnection(url, user, password);
			//System.out.println(conn);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
			System.out.println("Kết nối không thành công!");
		}
		return conn;
	}
	public static void close(ResultSet rs) {
		if(rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void close(Statement st) {
		if(st != null) {
			try {
				st.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void close(PreparedStatement pst) {
		if(pst != null) {
			try {
				pst.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void close(Connection conn) {
		if(conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void close(ResultSet rs, Statement st, Connection conn) {
		close(rs);
		close(st);
		close(conn);
	}
	
	public static void close(ResultSet rs, PreparedStatement pst, Connection conn) {
		close(rs);
		close(pst);
		close(conn);
	}
	
	public static void close(PreparedStatement pst, Connection conn) {
		close(pst);
		close(conn);
	}
}
