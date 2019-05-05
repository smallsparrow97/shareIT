package controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

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
public class AdminAddCatController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminAddCatController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// check login
		if (!AuthUtil.checkLogin(request, response)) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}
		
		CatDAO catDAO = new CatDAO();
		ArrayList<Category> listParentCat = catDAO.getParentItems();
		request.setAttribute("listParentCat", listParentCat);
		
		RequestDispatcher rd = request.getRequestDispatcher("/admin/cat/add.jsp");
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
		String catName = request.getParameter("name");
		int parent_id = Integer.parseInt(request.getParameter("parent_select"));
		System.out.println(parent_id);
		String description = null;
		String fileName = null;
		// nếu là danh mục cha thì mới lấy description và picture, nếu không: chỉ lấy name và parent_id
		if (parent_id == 0) {
			description = request.getParameter("description");
			Part filePart = request.getPart("picture");
			fileName = filePart.getSubmittedFileName();
			if (!"".equals(fileName)) {
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
		} 
		
		Category objCat = new Category(0, parent_id, catName, description, fileName);
		if(catDAO.addItem(objCat) > 0) {
			response.sendRedirect(request.getContextPath() + "/admin/cat/index?msg=1");
			return;
		} else {
			request.setAttribute("objCat", objCat);
			response.sendRedirect(request.getContextPath() + "/admin/cat/add?msg=0");
			return;
		}
	}

}
