package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.bean.User;
import model.dao.CatDAO;
import model.dao.CommentDAO;
import model.dao.SlideDAO;
import model.dao.NewDAO;
import model.dao.UserDAO;
import util.AuthUtil;

public class AdminIndexController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminIndexController() {
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
		
		CatDAO catDAO = new CatDAO();
		int countCat = catDAO.countItem();
		
		NewDAO newDAO = new NewDAO();
		int countNew = newDAO.countItemOfUser(userInfo.getId());
		
		UserDAO userDAO = new UserDAO();
		int countUser = userDAO.countItem();
		
		SlideDAO slideDAO = new SlideDAO();
		int countSlide = slideDAO.countItem();
		
		CommentDAO cmtDAO = new CommentDAO();
		int countCmt = cmtDAO.countCmtAdmin();
		
		request.setAttribute("countCat", countCat);
		request.setAttribute("countNew", countNew);
		request.setAttribute("countUser", countUser);
		request.setAttribute("countSlide", countSlide);
		request.setAttribute("countCmt", countCmt);
		
		RequestDispatcher rd = request.getRequestDispatcher("/admin/index.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	}

}
