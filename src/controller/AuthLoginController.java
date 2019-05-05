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
import util.StringUtil;

public class AuthLoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AuthLoginController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("/auth/login.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		password = StringUtil.md5(password); // mã hóa để khớp với dữ liệu trong database
		
		UserDAO userDAO = new UserDAO();
		User userInfo = userDAO.getItemByUsernameAndPassword(username, password);
		if (userInfo != null) {
			// login thành công
			HttpSession session = request.getSession();
			session.setAttribute("userInfo", userInfo);
			response.sendRedirect(request.getContextPath() + "/admin");
			return;
		} else {
			// login thất bại
			response.sendRedirect(request.getContextPath() + "/auth/login?msg=error");
			return;
		}
	}

}
