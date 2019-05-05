package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.Comment;
import model.dao.CommentDAO;
import util.AuthUtil;
import util.DefineUtil;

public class AdminIndexCmtController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminIndexCmtController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (!AuthUtil.checkLogin(request, response)) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}
		
		CommentDAO cmtDAO = new CommentDAO();
		// lấy ra tổng số cmt
		int numberOfItems = cmtDAO.countCmtAdmin();
		int numberOfPages = (int) Math.ceil((float) numberOfItems / DefineUtil.NUMBER_COMMENT_PER_PAGE_ADMIN);
		
		int currentPage = 1;
		try {
			currentPage = Integer.valueOf(request.getParameter("page"));
		} catch (NumberFormatException e) {
		}
		if (currentPage > numberOfPages || currentPage < 1) {
			currentPage = 1;
		}
		
		int offset = (currentPage - 1) * DefineUtil.NUMBER_COMMENT_PER_PAGE_ADMIN;
		
		ArrayList<Comment> listCmt = cmtDAO.getItemsPagination(offset, DefineUtil.NUMBER_COMMENT_PER_PAGE_ADMIN);
		
		request.setAttribute("numberOfItems", numberOfItems);
		request.setAttribute("numberOfPages", numberOfPages);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("offset", offset);
		request.setAttribute("listCmt", listCmt);
		
		RequestDispatcher rd = request.getRequestDispatcher("/admin/cmt/index.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	}

}
