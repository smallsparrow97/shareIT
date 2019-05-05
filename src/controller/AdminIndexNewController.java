package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.bean.New;
import model.bean.User;
import model.dao.NewDAO;
import util.AuthUtil;
import util.DefineUtil;

public class AdminIndexNewController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminIndexNewController() {
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
		
		NewDAO newDAO = new NewDAO();
		// lấy ra tổng số tin tức
		int numberOfItems = newDAO.countItemOfUser(userInfo.getId());
		int numberOfPages = (int) Math.ceil((float) numberOfItems / DefineUtil.NUMBER_NEWS_PER_PAGE);
		
		int currentPage = 1;
		try {
			currentPage = Integer.valueOf(request.getParameter("page"));
		} catch (NumberFormatException e) {
		}
		if (currentPage > numberOfPages || currentPage < 1) {
			currentPage = 1;
		}
		
		int offset = (currentPage - 1) * DefineUtil.NUMBER_NEWS_PER_PAGE;
		
		ArrayList<New> listNew = newDAO.getItemsPagination(offset, DefineUtil.NUMBER_NEWS_PER_PAGE, userInfo.getId());
		request.setAttribute("numberOfItems", numberOfItems);
		request.setAttribute("numberOfPages", numberOfPages);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("offset", offset);
		request.setAttribute("listNew", listNew);
		
		RequestDispatcher rd = request.getRequestDispatcher("/admin/new/index.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	}

}
