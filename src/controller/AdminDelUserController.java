package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.bean.User;
import model.dao.UserDAO;
import util.AuthUtil;

public class AdminDelUserController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminDelUserController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// check login
		if (!AuthUtil.checkLogin(request, response)) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}
		
		int id = 0;
		try {
			id = Integer.valueOf(request.getParameter("id"));
		} catch (NumberFormatException e) {
			response.sendRedirect(request.getContextPath() + "/admin/user/index?msg=0");
			return;
		}
		
		HttpSession session = request.getSession();
		User userInfo = (User) session.getAttribute("userInfo");
		
		UserDAO userDAO = new UserDAO();
		User user = userDAO.getItem(id);
		if ("admin".equals(user.getUsername())) {
			// không được xóa admin
			response.sendRedirect(request.getContextPath() + "/admin/user/index?msg=0");
			return;
		} else {
			if ("admin".equals(userInfo.getUsername())) {
				// được quyền xóa vì user đang login là admin
				if (userDAO.delItem(id) > 0) {
					response.sendRedirect(request.getContextPath() + "/admin/user/index?msg=3");
				} else {
					response.sendRedirect(request.getContextPath() + "/admin/user/index?msg=0");
				}
			} else {
				// không được xóa vì user đang login không phải là admin
				response.sendRedirect(request.getContextPath() + "/admin/user/index?msg=0");
				return;
			}
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	}

}
