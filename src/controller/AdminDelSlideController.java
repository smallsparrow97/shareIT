package controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.Slide;
import model.dao.SlideDAO;
import util.AuthUtil;
import util.DefineUtil;

public class AdminDelSlideController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminDelSlideController() {
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
			response.sendRedirect(request.getContextPath() + "/admin/slide/index?msg=0");
			return;
		}
		
		SlideDAO slideDAO = new SlideDAO();
		Slide objSlide = slideDAO.getItem(id);
		String fileNameOld = objSlide.getPicture();
		// nếu tồn tại file hình ảnh thì xóa file đó đi
		if (!"".equals(fileNameOld)) {
			String dirPath = request.getServletContext().getRealPath("") + DefineUtil.DIR_UPLOAD;
			String filePath = dirPath + File.separator + fileNameOld;
			File file = new File(filePath);
			file.delete(); // xóa file
			//System.out.println(dirPath);
		}
		if(slideDAO.delItem(id) > 0) {
			response.sendRedirect(request.getContextPath() + "/admin/slide/index?msg=3");
			return;
		} else {
			response.sendRedirect(request.getContextPath() + "/admin/slide/index?msg=0");
			return;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	}

}
