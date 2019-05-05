package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.Category;
import model.dao.CatDAO;
import util.AuthUtil;

@WebServlet("/ajaxEditChildCat")
public class AdminAjaxEditChildCatController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminAjaxEditChildCatController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		// check login
		if (!AuthUtil.checkLogin(request, response)) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}
		
		int id = Integer.valueOf(request.getParameter("id"));
		String catname = request.getParameter("catname");
		int parent_id = Integer.valueOf(request.getParameter("parent_id"));
		
		Category objCat = new Category(id, parent_id, catname, null, null);
		CatDAO catDAO = new CatDAO();
		catDAO.editChildItem(objCat);
		
		if(catDAO.editChildItem(objCat) > 0) {
			out.print("<div class='alert alert-success' role='alert'>"
					+ "<strong>Sửa thành công!</strong>"
					+ "</div>");
			//response.sendRedirect(request.getContextPath() + "/admin/cat/index?msg=2");
		} else {
			out.print("<div class='alert alert-warning' role='alert'>"
					+ "<strong>Sửa thất bại. Vui lòng thử lại sau</strong>"
					+ "</div>");
			//response.sendRedirect(request.getContextPath() + "/admin/cat/edit?msg=0&cid=" + cid);
		}
	}
}
