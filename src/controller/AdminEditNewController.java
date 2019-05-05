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
import model.bean.New;
import model.dao.CatDAO;
import model.dao.NewDAO;
import util.AuthUtil;
import util.DefineUtil;
import util.FileUtil;

@MultipartConfig
public class AdminEditNewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminEditNewController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
			response.sendRedirect(request.getContextPath() + "/admin/new/index?msg=0");
			return;
		}
		
		NewDAO newDAO = new NewDAO();
		New item = newDAO.getItem(id);
		if (item == null) {
			response.sendRedirect(request.getContextPath() + "/admin/new/index?msg=0");
			return;
		}
		request.setAttribute("objNew", item);
		
		CatDAO catDAO = new CatDAO();
		ArrayList<Category> listCat = catDAO.getItems();
		request.setAttribute("listCat", listCat);
		
		RequestDispatcher rd = request.getRequestDispatcher("/admin/new/edit.jsp");
		rd.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
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
			response.sendRedirect(request.getContextPath() + "/admin/new/index?msg=0");
			return;
		}
		NewDAO newDAO = new NewDAO();
		
		String title = request.getParameter("title");
		String preview = request.getParameter("preview");
		String detail = request.getParameter("detail");
		int catId = Integer.valueOf(request.getParameter("cat_id"));
		
		New item = newDAO.getItem(id);
		if (item == null) {
			response.sendRedirect(request.getContextPath() + "/admin/new/index?msg=0");
			return;
		}
		
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
		
		item = new New(id, null, 0, 0, title, preview, detail, fileName, null, new Category(catId, 0, null, null, null));
		
		// edit
		if(newDAO.editItem(item) > 0) {
			response.sendRedirect(request.getContextPath() + "/admin/new/index?msg=2");
			return;
		} else {
			request.setAttribute("objNew", item);
			RequestDispatcher rd = request.getRequestDispatcher("/admin/new/edit.jsp?msg=0");
			rd.forward(request, response);
			return;
		}
	}

}
