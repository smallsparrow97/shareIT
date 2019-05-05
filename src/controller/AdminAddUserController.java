package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.bean.User;
import model.dao.UserDAO;
import util.AuthUtil;
import util.StringUtil;

public class AdminAddUserController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminAddUserController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// check login
		if (!AuthUtil.checkLogin(request, response)) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}

		HttpSession session = request.getSession();
		User userInfo = (User) session.getAttribute("userInfo");

		// check quền admin
		if (!"admin".equals(userInfo.getUsername())) {
			// không được phép
			response.sendRedirect(request.getContextPath() + "/admin/user/index?msg=0");
			return;
		}

		RequestDispatcher rd = request.getRequestDispatcher("/admin/user/add.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// check login
		if (!AuthUtil.checkLogin(request, response)) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}

		HttpSession session = request.getSession();
		User userInfo = (User) session.getAttribute("userInfo");

		// check quền admin
		if (!"admin".equals(userInfo.getUsername())) {
			// không được phép
			response.sendRedirect(request.getContextPath() + "/admin/user/index?msg=0");
			return;
		}

		request.setCharacterEncoding("UTF-8");
		UserDAO userDAO = new UserDAO();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String fullname = request.getParameter("fullname");
		// VALIDATE DỮ LIỆU....
		// kiểm tra username đã tồn tại chưa
		if (userDAO.hasUser(username)) {
			RequestDispatcher rd = request.getRequestDispatcher("/admin/user/add.jsp?msg=4");
			rd.forward(request, response);
		} else {
			// mã hóa dữ liệu
			password = StringUtil.md5(password);
			User item = new User(0, username, password, fullname);
			if (userDAO.addItem(item) > 0) {
				response.sendRedirect(request.getContextPath() + "/admin/user/index?msg=1");
				return;
			} else {
				RequestDispatcher rd = request.getRequestDispatcher("/admin/user/add.jsp?msg=0");
				rd.forward(request, response);
			}
		}
	}

}
