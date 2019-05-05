package controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import model.bean.Slide;
import model.dao.SlideDAO;
import util.AuthUtil;
import util.DefineUtil;
import util.FileUtil;

@MultipartConfig
public class AdminAddSlideController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminAddSlideController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// check login
		if (!AuthUtil.checkLogin(request, response)) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("/admin/slide/add.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		SlideDAO slideDAO = new SlideDAO();
		
		String name = request.getParameter("name");
		String link = request.getParameter("link");
		
		Part filePart = request.getPart("picture");
		String fileName = filePart.getSubmittedFileName();
		if (!"".equals(fileName)) {
			// /webcontent/
			String dirPath = request.getServletContext().getRealPath("") + DefineUtil.DIR_UPLOAD;
			File dirFile = new File(dirPath);
			if (!dirFile.exists()) {
				dirFile.mkdir();
			}
			fileName = FileUtil.rename(fileName);
			String filePath = dirPath + File.separator + fileName;
			filePart.write(filePath);
			//System.out.println(filePath);
		} 
		
		Slide item = new Slide(0, 0, 0, name, fileName, link);
		
		if(slideDAO.addItem(item) > 0) {
			response.sendRedirect(request.getContextPath() + "/admin/slide/index?msg=1");
			return;
		} else {
			request.setAttribute("objslide", item);
			RequestDispatcher rd = request.getRequestDispatcher("/admin/slide/add.jsp?msg=0");
			rd.forward(request, response);
			return;
		}
	}

}
