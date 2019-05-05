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
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import model.bean.Category;
import model.bean.New;
import model.bean.User;
import model.dao.CatDAO;
import model.dao.NewDAO;
import util.AuthUtil;
import util.DefineUtil;
import util.FileUtil;

@MultipartConfig
public class AdminAddNewController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminAddNewController() {
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
		ArrayList<Category> listCat = catDAO.getItems();
		request.setAttribute("listCat", listCat);
		
		RequestDispatcher rd = request.getRequestDispatcher("/admin/new/add.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// check login
		if (!AuthUtil.checkLogin(request, response)) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}
		
		HttpSession session = request.getSession();
		User userInfo = (User) session.getAttribute("userInfo");
		
		NewDAO newDAO = new NewDAO();
		
		String title = request.getParameter("title");
		int catId = Integer.valueOf(request.getParameter("cat_id"));
		String preview = request.getParameter("preview");
		String detail = request.getParameter("detail");
		
		Part filePart = request.getPart("picture");
		String fileName = filePart.getSubmittedFileName();
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
		
		New item = new New(0, new User(userInfo.getId(), null, null, null), 0, 0, title, preview, detail, fileName, null, new Category(catId, 0, null, null, null));
		
		if(newDAO.addItem(item, userInfo.getId()) > 0) {
			response.sendRedirect(request.getContextPath() + "/admin/new/index?msg=1");
			return;
		} else {
			request.setAttribute("objNew", item);
			RequestDispatcher rd = request.getRequestDispatcher("/admin/new/add.jsp?msg=0");
			rd.forward(request, response);
			return;
		}
	}

}
