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
public class AdminEditSlideController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminEditSlideController() {
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
			System.out.println(e.getMessage());
			response.sendRedirect(request.getContextPath() + "/admin/slide/index?msg=0");
			return;
		}
		
		SlideDAO slideDAO = new SlideDAO();
		Slide item = slideDAO.getItem(id);
		if (item == null) {
			response.sendRedirect(request.getContextPath() + "/admin/slide/index?msg=0");
			return;
		}
		request.setAttribute("objSlide", item);
		
		RequestDispatcher rd = request.getRequestDispatcher("/admin/slide/edit.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		int id = 0;
		try {
			id = Integer.valueOf(request.getParameter("id"));
		} catch (NumberFormatException e) {
			System.out.println(e.getMessage());
			response.sendRedirect(request.getContextPath() + "/admin/slide/index?msg=0");
			return;
		}
		SlideDAO slideDAO = new SlideDAO();
		
		String name = request.getParameter("name");
		String link = request.getParameter("link");
		int location = Integer.valueOf(request.getParameter("location"));
		
		Slide item = slideDAO.getItem(id);
		if (item == null) {
			response.sendRedirect(request.getContextPath() + "/admin/slide/index?msg=0");
			return;
		}
		
		Part filePart = request.getPart("picture");
		String fileName = filePart.getSubmittedFileName();
		// fileName không rỗng thì 
		if (!"".equals(fileName)) {
			// /webcontent/
			String dirPath = request.getServletContext().getRealPath("") + DefineUtil.DIR_UPLOAD;
			File dirFile = new File(dirPath);
			if (!dirFile.exists()) {
				dirFile.mkdir();
			}
			fileName = FileUtil.rename(fileName);
			String filePath = dirPath + File.separator + fileName;
			// xóa file cũ trước
			String oldFilePath = dirPath + File.separator + item.getPicture();
			File oldFile = new File(oldFilePath);
			if (oldFile.exists()) {
				oldFile.delete();
			}
			// ghi file mới vào
			filePart.write(filePath);
			//System.out.println(filePath);
			
		} else {
			fileName = item.getPicture();
		}
		
		item = new Slide(id, 0, location, name, fileName, link);
		
		// edit
		if(slideDAO.editItem(item) > 0) {
			response.sendRedirect(request.getContextPath() + "/admin/slide/index?msg=2");
		} else {
			request.setAttribute("objSlide", item);
			RequestDispatcher rd = request.getRequestDispatcher("/admin/slide/edit.jsp?msg=0");
			rd.forward(request, response);
		}
	}

}
