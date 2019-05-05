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
import model.bean.Slide;
import model.dao.CatDAO;
import model.dao.NewDAO;
import model.dao.SlideDAO;
import util.DefineUtil;

public class PublicIndexController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public PublicIndexController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//System.out.println(request.getServletContext().getRealPath(""));
		
		NewDAO newDAO = new NewDAO();
		CatDAO catDAO = new CatDAO();
		SlideDAO slideDAO = new SlideDAO();
		// danh sách tin tức mới nhất in trên slide
		ArrayList<New> listSlideNews = newDAO.getLatestItems(DefineUtil.NUMBER_SLIDE_NEWS);
		// danh sách tin tức mới in trong phần slide tin mới
		ArrayList<New> listLatestNews = newDAO.getLatestItems(DefineUtil.NUMBER_LATEST_NEWS);
		// danh sách tin tuyển dụng mới nhất
		ArrayList<New> listJobNews = newDAO.getItemsByCatId(4, DefineUtil.NUMBER_JOB_NEWS);
		// danh sách danh mục cha
		ArrayList<Category> listParentCat = catDAO.getParentItems();
		// danh sách slide bg
		ArrayList<Slide> listSlideBg = slideDAO.getItems();
		
		request.setAttribute("listSlideNews", listSlideNews);
		request.setAttribute("listLatestNews", listLatestNews);
		request.setAttribute("listJobNews", listJobNews);
		request.setAttribute("listParentCat", listParentCat);
		request.setAttribute("listSlideBg", listSlideBg);
		
		RequestDispatcher rd = request.getRequestDispatcher("/public/index.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	}

}
