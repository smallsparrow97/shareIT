package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.dao.CommentDAO;

public class AdminXuLyActiveCmtController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminXuLyActiveCmtController() {
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
		CommentDAO cmtDAO = new CommentDAO();
		
		String src = request.getParameter("asrc");
		int id = Integer.valueOf(request.getParameter("aid"));
		String status = src.substring(src.lastIndexOf("/") + 1, src.lastIndexOf("."));
		if ("active".equals(status)) {
			cmtDAO.updateActive(0, id);
			src = request.getContextPath() + "/templates/admin/assets/img/deactive.gif";
		} else {
			cmtDAO.updateActive(1, id);
			src = request.getContextPath() + "/templates/admin/assets/img/active.gif";
		}
		out.print(src);
	}

}
