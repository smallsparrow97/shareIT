package controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.bean.New;
import model.dao.NewDAO;
import util.AuthUtil;
import util.DefineUtil;

public class AdminDelNewController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminDelNewController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (!AuthUtil.checkLogin(request, response)) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}
		
		int id = 0;
		try {
			id = Integer.valueOf(request.getParameter("id"));
		} catch (NumberFormatException e) {
			response.sendRedirect(request.getContextPath() + "/admin/song/index?msg=0");
			return;
		}
		
		NewDAO newDAO = new NewDAO();
		New objNew = newDAO.getItem(id);
		String fileNameOld = objNew.getPicture();
		// nếu tồn tại file hình ảnh thì xóa file đó đi
		if (!"".equals(fileNameOld)) {
			String dirPath = request.getServletContext().getRealPath("") + DefineUtil.DIR_UPLOAD;
			String filePath = dirPath + File.separator + fileNameOld;
			File file = new File(filePath);
			file.delete(); // xóa file
			//System.out.println(dirPath);
		}
		if(newDAO.delItem(id) > 0) {
			response.sendRedirect(request.getContextPath() + "/admin/new/index?msg=3");
			return;
		} else {
			response.sendRedirect(request.getContextPath() + "/admin/new/index?msg=0");
			return;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	}

}
