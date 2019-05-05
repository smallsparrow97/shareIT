package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.Category;
import model.dao.CatDAO;
import util.AuthUtil;

public class AdminDelCatController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminDelCatController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// check login
		if (!AuthUtil.checkLogin(request, response)) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}
		
		int cid = 0;
		try {
			cid = Integer.valueOf(request.getParameter("cid"));
		} catch (Exception e) {
			response.sendRedirect(request.getContextPath() + "/admin/cat/index?msg=0");
			return;
		}
		
		CatDAO catDAO = new CatDAO();
		ArrayList<Category> listChildCat = catDAO.getChildCat(cid);
		if(catDAO.delItem(cid) > 0) {
			if (listChildCat.size() > 0) {
				for (Category childCatObj : listChildCat) {
					catDAO.delItem(childCatObj.getCatId());
				}
			}
			// xóa tất cả tin tức, comment liên quan
			response.sendRedirect(request.getContextPath() + "/admin/cat/index?msg=3");
			return;
		} else {
			response.sendRedirect(request.getContextPath() + "/admin/cat/index?msg=0");
			return;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	}

}
