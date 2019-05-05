package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.Category;
import model.bean.New;
import model.dao.CatDAO;
import model.dao.NewDAO;
import util.DefineUtil;

public class PublicCatController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public PublicCatController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int catId = 0;
		try {
			catId = Integer.valueOf(request.getParameter("cid"));
		} catch (NumberFormatException e) {
			response.sendRedirect(request.getContextPath() + "/404");
			return;
		}
		
		CatDAO catDAO = new CatDAO();
		Category category = catDAO.getItemById(catId);
		
		NewDAO newDAO = new NewDAO();
		// danh sách tin tức
		ArrayList<New> listNews = newDAO.getItemsByCatId(catId, DefineUtil.NUMBER_NEWS_PER_CAT_PAGE);
		//đếm số lượng tin tức
		int countNews = newDAO.countItem(catId);
		
		request.setAttribute("category", category);
		request.setAttribute("listNews", listNews);
		request.setAttribute("countNews", countNews);
		
		RequestDispatcher rd = request.getRequestDispatcher("/public/cat.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html");
		NewDAO newDAO = new NewDAO();
		
		int catId = Integer.valueOf(request.getParameter("catId"));
		int countTimeLoadMore = Integer.valueOf(request.getParameter("countTimeLoadMore"));
		int offset = countTimeLoadMore * DefineUtil.NUMBER_NEWS_PER_CAT_PAGE;
		
		ArrayList<New> listNewsLoadMore = newDAO.getItemsByCatIdLoadMore(catId, offset, DefineUtil.NUMBER_NEWS_PER_CAT_PAGE);
		request.setAttribute("listNewsLoadMore", listNewsLoadMore);
		
		RequestDispatcher rd = request.getRequestDispatcher("/templates/public/ajaxResult/ajaxLoadMoreNewsOfCatResult.jsp");
		rd.forward(request, response);
	}

}
