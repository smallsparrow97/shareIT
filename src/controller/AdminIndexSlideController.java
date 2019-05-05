package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.Slide;
import model.dao.SlideDAO;
import util.AuthUtil;
import util.DefineUtil;

public class AdminIndexSlideController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminIndexSlideController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (!AuthUtil.checkLogin(request, response)) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}
		
		SlideDAO slideDAO = new SlideDAO();
		// lấy ra tổng số slide
		int numberOfItems = slideDAO.countItem();
		int numberOfPages = (int) Math.ceil((float) numberOfItems / DefineUtil.NUMBER_SLIDE_PER_PAGE);
		
		int currentPage = 1;
		try {
			currentPage = Integer.valueOf(request.getParameter("page"));
		} catch (NumberFormatException e) {
		}
		if (currentPage > numberOfPages || currentPage < 1) {
			currentPage = 1;
		}
		
		int offset = (currentPage - 1) * DefineUtil.NUMBER_SLIDE_PER_PAGE;
		
		ArrayList<Slide> listSlide = slideDAO.getItemsPagination(offset, DefineUtil.NUMBER_SLIDE_PER_PAGE);
		request.setAttribute("numberOfItems", numberOfItems);
		request.setAttribute("numberOfPages", numberOfPages);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("offset", offset);
		request.setAttribute("listSlide", listSlide);
		RequestDispatcher rd = request.getRequestDispatcher("/admin/slide/index.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	}

}
