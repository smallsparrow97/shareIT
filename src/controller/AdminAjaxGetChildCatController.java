package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.bean.Category;
import model.dao.CatDAO;

@WebServlet("/getchildcat")
public class AdminAjaxGetChildCatController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminAjaxGetChildCatController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int childcat_id = Integer.parseInt(request.getParameter("id"));
		CatDAO catDAO = new CatDAO();
		Category objCat = catDAO.getItemById(childcat_id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("catname", objCat.getCatName());
		map.put("parent_id", objCat.getParentId());
		String json = new Gson().toJson(map);

	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    response.getWriter().write(json);
	}

}
