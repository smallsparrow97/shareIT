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

import model.bean.Category;
import model.dao.CatDAO;
import util.AuthUtil;
import util.DefineUtil;
import util.FileUtil;

@MultipartConfig
public class AdminEditCatController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminEditCatController() {
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
		} catch (NumberFormatException e) {
			response.sendRedirect(request.getContextPath() + "/admin/cat/edit?msg=0");
			return;
		}
		
		CatDAO catDAO = new CatDAO();
		Category objCat = catDAO.getItemById(cid);
		request.setAttribute("objCat", objCat);
		RequestDispatcher rd = request.getRequestDispatcher("/admin/cat/edit.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// check login
		if (!AuthUtil.checkLogin(request, response)) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}
		
		request.setCharacterEncoding("UTF-8");
		CatDAO catDAO = new CatDAO();
		int cid = 0;
		try {
			cid = Integer.valueOf(request.getParameter("cid"));
		} catch (NumberFormatException e) {
			System.out.println(e.getMessage());
			response.sendRedirect(request.getContextPath() + "/admin/cat/index?msg=0");
			return;
		}
		String name = request.getParameter("name");
		String description = request.getParameter("description");
		
		// lấy ra danh mục cần sửa
		Category oldCatObject = catDAO.getItemById(cid);
		if (oldCatObject == null) {
			response.sendRedirect(request.getContextPath() + "/admin/cat/index?msg=0");
			return;
		}
		
		// kiểm tra có chọn ảnh hay k, nếu có thì xóa ảnh cũ up ảnh mới, nếu không thì lấy ảnh cũ.
		Part filePart = request.getPart("picture");
		String fileName = filePart.getSubmittedFileName();
		// fileName không rỗng thì 
		if (!"".equals(fileName)) {
			String dirPath = request.getServletContext().getRealPath("") + DefineUtil.DIR_UPLOAD;
			File dirFile = new File(dirPath);
			if (!dirFile.exists()) {
				dirFile.mkdir();
			}
			fileName = FileUtil.rename(fileName);
			String filePath = dirPath + File.separator + fileName;
			// xóa file cũ trước
			String oldFilePath = dirPath + File.separator + oldCatObject.getPicture();
			File oldFile = new File(oldFilePath);
			if (oldFile.exists()) {
				oldFile.delete();
			}
			// ghi file mới vào
			filePart.write(filePath);
			//System.out.println(filePath);
			
		} else {
			fileName = oldCatObject.getPicture();
		}
		
		Category objCat = new Category(cid, 0, name, description, fileName);
		if(catDAO.editItem(objCat) > 0) {
			response.sendRedirect(request.getContextPath() + "/admin/cat/index?msg=2");
			return;
		} else {
			request.setAttribute("objCat", objCat);
			response.sendRedirect(request.getContextPath() + "/admin/cat/edit?msg=0");
			return;
		}

	}
}
